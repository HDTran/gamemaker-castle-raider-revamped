function frog_attack_step() {
	// get inputs
	
	// calculate movement

	// modify state
	// attacking
	// set tongue depth
	depth = layer_get_depth(layer_get_id("Player")) -1;
	
	if (image_index >= image_number - sprite_get_speed(sprite_index)/room_speed) {
		state = FROG_STATES.IDLE;
		alarm[CAN_ATTACK] = attackDelay;
		depth = layer_get_depth(layer_get_id("Enemies"));
	}

	// apply movement
	collision();

	// animations
	frog_anim();
}

function frog_idle_step() {
	// get inputs
	breathing();
	
	// calculate movement
	// modify state
	// attack
	var DETECT_PLAYER_DISTANCE = 40;
	var playerAlert = false; // player in front and within range, but the attack is not ready
	// if player is within detected distance and we are facing player, then attack
	// checking sign(o_player.x - x) will return whether they're facing or not
	if ((distance_to_object(o_player) < DETECT_PLAYER_DISTANCE) && sign(o_player.x - x) == facing) {
		if (canAttack) {
			canAttack = false;
			state = FROG_STATES.ATTACK;
			image_index = 0;
			image_speed = 1;
		} else {
			playerAlert = true;
		}
	}
	
	// jumping
	if (movement.jumpTimer < 0 && !playerAlert) {
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
			var testTileAhead = tilemap_get_at_pixel(global.map, x + sign(facing) * global.tileSize, bbox_bottom);
			if (testTileAhead == SOLID) {
				facing *= -1;
				turned = true;
			}
			// look for a void one tile ahead
			testTileAhead = tilemap_get_at_pixel(global.map, x + sign(facing) * global.tileSize, bbox_bottom + 1);
			if (testTileAhead == VOID) {
				if (!turned) {
					facing *= -1;
				}
			}
			// look for voids multiple tiles ahead
			var TILES_AHEAD = 3;
			for (var i = TILES_AHEAD; i > 0; i--) {
				testTileAhead = tilemap_get_at_pixel(global.map, x + sign(facing) * global.tileSize * i, bbox_bottom + 1);
				if (testTileAhead == VOID) {
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
	collision();

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
