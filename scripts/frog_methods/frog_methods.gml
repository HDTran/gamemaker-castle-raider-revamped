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
	breathing();
	
	// calculate movement
	// modify state
	// apply movement
	// animations
	frog_anim();
}

function frog_jump_land_step() {
	// get inputs
	breathing();
	
	// calculate movement
	// modify state
	// apply movement
	// animations
	frog_anim();
}

function frog_jump_start_step() {
	// get inputs	
	// calculate movement
	// modify state
	// apply movement
	collision();
	
	// animations
	frog_anim();
}

