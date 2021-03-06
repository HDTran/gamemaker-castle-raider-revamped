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

	// create hitbox
	var startingSlashImageIndex = 1;
	var endingSlashImageIndex = 3;
	if (image_index >= startingSlashImageIndex && image_index <= endingSlashImageIndex) {
		var inst = instance_create_layer(x, y, "Player", o_player_attack_hitbox);
		inst.image_xscale = facing;
		if (image_index == 1) {
			audio_play_sound(snd_sword_swing, 20, false);
		}
	}

	// enable smaller jumps
	if (movement.verticalSpeed < 0 && !input.jumpHeld) {
		movement.verticalSpeed = max(movement.verticalSpeed, movement.jumpSpeed/movement.jumpDampner);
	}
	
	collision(); // apply movement
	check_player_hp();
	anim(); // apply animations
}

function player_block_step() {
	get_input();
	calc_movement();
	// check state
	block_check();
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.jump) {
		jumped();
	}
	collision(); // apply movement
	check_player_hp();
	anim(); // apply animations
};

function player_crouch_step() {
	get_input();
	calc_movement();
	// check state
	block_check();
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.jump) {
		jumped();
	}
	collision(); // apply movement
	check_player_hp();
	anim(); // apply animations
};

function player_crouch_block_step() {
	get_input();
	calc_movement();
	// check state
	block_check();
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.jump) {
		jumped();
	}
	collision(); // apply movement
	check_player_hp();
	anim(); // apply animations
};

function player_die_step() {	
	// calculate movement
	movement.verticalSpeed += global.gravity;

	// drag
	movement.horizontalSpeed = lerp(movement.horizontalSpeed, 0, movement.drag); // reduce to 0 by drag speed

	// stop if below threshold
	if (abs(movement.horizontalSpeed) <= 0.5) { movement.horizontalSpeed = 0; }
	
	// check state
	if (image_index >= image_number - 1) {
		image_speed = 0;

		if (lives <= 0) {
			o_game.game_over_lose = true;
		} else {			
			get_input();
			if (input.jump || input.attack) {
				//room_restart();
				//// reset player
				//x = room_start_pos_x;
				//y = room_start_pos_y;
				//facing = room_start_facing;
				//state = PLAYER_STATES.IDLE;
			
				//// reset speed after death pause
				//image_speed = 1;
			
				//// reset hp
				//hp = maxHP;
				fade_to_room(room, room_start_pos_x, room_start_pos_y, room_start_facing, c_black);
				
			
				// allow instant camera panning
				with(o_camera) {
					// enable instant panning
					cameraPanSpeed = 1;
				
					// reset camera pan speed
					alarm[CAMERA_RESET] = 3;
				}
			}
		}
	}

	collision(); // apply movement
	anim(); // apply animations
};

function player_hurting_step() {
	get_input();
	
	// calculate movement
	movement.verticalSpeed += global.gravity;

	// drag
	movement.horizontalSpeed = lerp(movement.horizontalSpeed, 0, movement.drag); // reduce to 0 by drag speed

	// stop if below threshold
	if (abs(movement.horizontalSpeed) <= 0.1) { movement.horizontalSpeed = 0; }
	
	// check state
	// set to first frame and stop if animation has played once
	if (on_ground()) {
		if (image_index >= image_number - sprite_get_speed(sprite_index)/room_speed) {
			image_index = 0;
			image_speed = 0;
		}
	}

	var recoverTime = 0.4; // 1 = instant recover
	if (alarm[HURT] < hurtTime * recoverTime) {
		state = on_ground() ? PLAYER_STATES.IDLE : PLAYER_STATES.JUMP;
		image_speed = 1;
	}

	collision(); // apply movement
	check_player_hp();
	anim(); // apply animations
};

function player_knockback_step() {
	get_input();
	
	// calculate movement
	movement.verticalSpeed += global.gravity;

	// drag
	movement.horizontalSpeed = lerp(movement.horizontalSpeed, 0, movement.drag); // reduce to 0 by drag speed

	// stop if below threshold
	if (abs(movement.horizontalSpeed) <= 0.5) { movement.horizontalSpeed = 0; }
	
	// check state
	// change state after animation and no longer moving
	if (image_index >= image_number - sprite_get_speed(sprite_index)/room_speed && movement.horizontalSpeed == 0) {
		// change state
		if (input.block) {
			state = input.down ? PLAYER_STATES.CROUCH_BLOCK : PLAYER_STATES.BLOCK;
		} else {
			state = PLAYER_STATES.IDLE;
		}
	}

	collision(); // apply movement
	check_player_hp();
	anim(); // apply animations
};

function player_idle_step() {
	get_input();
	calc_movement();
	// check state
	block_check();
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.jump) {
		jumped();
	}

	collision(); // apply movement
	check_player_hp();
	anim(); // apply animations
};

function player_jump_step() {
	get_input();
	calc_movement();
	
	// check state
	if (on_ground()) {
		// apply squash
		scale_x = scale_max;
		scale_y = scale_min;
		
		state = movement.horizontalSpeed != 0 ? PLAYER_STATES.WALK : PLAYER_STATES.IDLE;
		
		// create dust if landing
		if (movement.verticalSpeed > 0) {
			instance_create_layer(x, y, "Dust", o_player_dust_land);
			audio_play_sound(snd_landing, 20, false);
		}
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
	check_player_hp();
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
	
	block_check();
	if (input.attack) {
		state = PLAYER_STATES.ATTACK;
	}
	if (input.jump) {
		jumped();
	}
	
	collision(); // apply movement
	check_player_hp();
	anim(); // apply animations
};
