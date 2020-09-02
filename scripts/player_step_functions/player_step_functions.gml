function player_attack_step() {
	get_input();
	calc_movement();
	// check state
	if (image_index >= image_number - sprite_get_speed(sprite_index)/room_speed) {
		if (speeds.horizontalSpeed != 0) {
			state = PLAYER_STATES.WALK;
		} else {
			state = PLAYER_STATES.IDLE;
		}
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
		speeds.horizontalSpeed = 0; // stop movement
	} else {
		if (speeds.horizontalSpeed != 0) {
			state = !on_ground() ? PLAYER_STATES.JUMP : PLAYER_STATES.WALK;
		} else {
			state = PLAYER_STATES.IDLE;
		}
	}
	if (input.jump) {
		state = PLAYER_STATES.JUMP;
		speeds.verticalSpeed = speeds.jumpSpeed;
	}
	collision(); // apply movement
	anim(); // apply animations
};

function player_idle_step() {
	get_input();
	calc_movement();
	// check state
	if (speeds.horizontalSpeed != 0) {
		state = PLAYER_STATES.WALK;
	}
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.block) {
		state = PLAYER_STATES.BLOCK;
		speeds.horizontalSpeed = 0; // stop movement
	}
	if (input.jump) {
		state = PLAYER_STATES.JUMP;
		speeds.verticalSpeed = speeds.jumpSpeed;
	}
	collision(); // apply movement
	anim(); // apply animations
};

function player_jump_step() {
	get_input();
	calc_movement();
	
	// check state
	if (on_ground()) {
		state = speeds.horizontalSpeed != 0 ? PLAYER_STATES.WALK : PLAYER_STATES.IDLE;
	}
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	// enable smalller jumps
	if (speeds.verticalSpeed < 0 && !input.jumpHeld) {
		speeds.verticalSpeed = max(speeds.verticalSpeed, speeds.jumpSpeed/speeds.jumpDampner);
	}
	
	collision(); // apply movement
	anim(); // apply animations
};


function player_walk_step() {
	get_input();
	calc_movement();
	// check state
	if (speeds.horizontalSpeed == 0) {
		state = PLAYER_STATES.IDLE;
	}
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.block) {
		state = PLAYER_STATES.BLOCK;
		speeds.horizontalSpeed = 0; // stop movement
	}
	if (input.jump) {
		state = PLAYER_STATES.JUMP;
		speeds.verticalSpeed = speeds.jumpSpeed;
	}
	collision(); // apply movement
	anim(); // apply animations
};