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
			movement.maxHorizontalSpeed = movement.maxHorizontalSpeedInitial;
			
			var turned = false;
			// look for solid one tile ahead
			var testTileAhead1 = tilemap_get_at_pixel(global.map, x + sign(facing) * global.tileSize, bbox_bottom);
			if (testTileAhead1 == SOLID) {
				facing *= -1;
				turned = true;
			}
			// look for a void one tile ahead
			testTileAhead1 = tilemap_get_at_pixel(global.map, x + sign(facing) * global.tileSize, bbox_bottom + 1);
			if (testTileAhead1 == VOID) {
				if (!turned) {
					facing *= -1;
				}
			}
			// look for voids multiple tiles ahead
			var TILES_AHEAD = 3;
			for (var i = TILES_AHEAD; i > 0; i--) {
				testTileAhead1 = tilemap_get_at_pixel(global.map, x + sign(facing) * global.tileSize * i, bbox_bottom + 1);
				if (testTileAhead1 == VOID) {
					// adjust frog so that he doesn't go off edge
					// find the furthest solid jump point
					var tileStartX = (x + sign(facing) * global.tileSize * i) - (x + sign(facing) * global.tileSize * i) mod global.tileSize;
					// half of mask
					var halfMask = (bbox_right + 1 - bbox_left)/2;
					var target = facing ? tileStartX - halfMask : tileStartX + halfMask + global.tileSize; // target area is based on adjustment to ledge + mask + facing
					// adjust maxHorizontalSpeed to land at target
					// speed = distance/time
					var STEPS_IN_AIR = 48; // how long is frog in air? 48 steps
					movement.maxHorizontalSpeed = abs(target - x)/STEPS_IN_AIR;
				}
			}
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
