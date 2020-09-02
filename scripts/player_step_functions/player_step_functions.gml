function player_attack_step() {
	get_input();
	calc_movement();
	
	// check state
	if (image_index >= image_number - sprite_get_speed(sprite_index)/room_speed) {
		if (!on_ground()) {
			state = PLAYER_STATES.JUMP;	
		} else {
			state = movement.horizontalSpeed != 0 ? PLAYER_STATES.WALK : PLAYER_STATES.IDLE;
		}
	}
	if (input.jump) {
		jumped();
		state = PLAYER_STATES.ATTACK; // restore attack state after doing jump immediately
	}
	// enable smaller jumps
	if (movement.verticalSpeed < 0 && !input.jumpHeld) {
		movement.verticalSpeed = max(movement.verticalSpeed, movement.jumpSpeed/movement.jumpDampner);
	}
	
	collision(); // apply movement
	anim(); // apply animations
}

function player_block_step() {
	get_input();
	calc_movement();
	// check state
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.block) {
		movement.horizontalSpeed = 0; // stop movement
	} else {
		if (movement.horizontalSpeed != 0) {
			state = !on_ground() ? PLAYER_STATES.JUMP : PLAYER_STATES.WALK;
		} else {
			state = PLAYER_STATES.IDLE;
		}
	}
	if (input.jump) {
		jumped();
	}
	collision(); // apply movement
	anim(); // apply animations
};

function player_idle_step() {
	get_input();
	calc_movement();
	// check state
	if (movement.horizontalSpeed != 0) {
		state = PLAYER_STATES.WALK;
	}
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.block) {
		state = PLAYER_STATES.BLOCK;
		movement.horizontalSpeed = 0; // stop movement
	}
	if (input.jump) {
		jumped();
	}
	collision(); // apply movement
	anim(); // apply animations
};

function player_jump_step() {
	get_input();
	calc_movement();
	
	// check state
	if (on_ground()) {
		state = movement.horizontalSpeed != 0 ? PLAYER_STATES.WALK : PLAYER_STATES.IDLE;
	}
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.jump) {
		jumped();
	}
	// enable smalller jumps
	if (movement.verticalSpeed < 0 && !input.jumpHeld) {
		movement.verticalSpeed = max(movement.verticalSpeed, movement.jumpSpeed/movement.jumpDampner);
	}
	
	collision(); // apply movement
	anim(); // apply animations
};


function player_walk_step() {
	get_input();
	calc_movement();
	// check state
	// check if falling off a ledge (same as on_ground() almost)
	var side = bbox_bottom;
	var testBottomLeft = tilemap_get_at_pixel(global.map, bbox_left, side + 1);
	var testBottomRight = tilemap_get_at_pixel(global.map, bbox_right, side + 1);
	
	if (testBottomLeft == VOID && testBottomRight == VOID) {
		state = PLAYER_STATES.JUMP;
		movement.jumps = movement.jumpsInitial;
	}
	
	if (movement.horizontalSpeed == 0) {
		state = PLAYER_STATES.IDLE;
	}
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.block) {
		state = PLAYER_STATES.BLOCK;
		movement.horizontalSpeed = 0; // stop movement
	}
	if (input.jump) {
		jumped();
	}
	
	collision(); // apply movement
	anim(); // apply animations
};