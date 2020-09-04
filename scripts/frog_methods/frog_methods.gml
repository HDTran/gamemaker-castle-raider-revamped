function frog_idle_step() {
	// get inputs
	breathing();
	
	// calculate movement
	// modify state
	if (movement.jumpTimer < 0) {
		movement.jumpTimer = movement.jumpTimerInitial;
		var shouldJump = random(1);
		if (shouldJump > movement.jumpChance) {
			state = FROG_STATES.JUMP_START;
			
			// reset breath values
			image_index = 0;
			image_speed = 1;
		}
	} else {
		movement.jumpTimer--;
	}

	// apply movement
	// animations
	frog_anim();
}

function frog_jump_step() {
	// get inputs
	
	// calculate movement
	movement.horizontalSpeed = movement.walkSpeed * facing;
	movement.verticalSpeed += global.gravity;

	movement.horizontalSpeed = min(abs(movement.horizontalSpeed), movement.maxHorizontalSpeed) * facing; // limit speed

	// modify state
	if (on_ground()) {
		state = FROG_STATES.JUMP_LAND;
		movement.horizontalSpeed = 0;
		image_index = 0;
		image_speed = 1;
	}

	// apply movement
	collision();

	// animations
	frog_anim();
}

function frog_jump_land_step() {
	// get inputs
	
	// calculate movement

	// modify state
	if (image_index >= image_number - sprite_get_speed(sprite_index)/room_speed) {
		state = FROG_STATES.IDLE;
		image_index = 0;
		image_speed = 0;
	}

	// apply movement
	collision();

	// animations
	frog_anim();
}

function frog_jump_start_step() {
	// get inputs	
	// calculate movement
	// modify state
	if (image_index >= image_number - sprite_get_speed(sprite_index)/room_speed) {
		state = FROG_STATES.JUMP;
		movement.verticalSpeed = movement.jumpSpeed;
	}

	// apply movement
	collision();
	
	// animations
	frog_anim();
}

