function get_input() {
	input = {
		up: keyboard_check(vk_up),
		right: keyboard_check(vk_right),
		down: keyboard_check(vk_down),
		left: keyboard_check(vk_left),
		attack: keyboard_check_pressed(vk_shift),
		jump: keyboard_check_pressed(vk_space),
		jumpHeld: keyboard_check(vk_space),
		block: keyboard_check(ord("Z")),
	}	
}

function calc_movement() {
	movement.horizontalSpeed += (input.right - input.left) * movement.walkSpeed;
	movement.verticalSpeed += global.gravity;

	// drag
	movement.horizontalSpeed = lerp(movement.horizontalSpeed, 0, movement.drag); // reduce to 0 by drag speed

	// stop if below threshold
	if (abs(movement.horizontalSpeed) <= 0.1) { movement.horizontalSpeed = 0; }

	// face correct direction
	if (movement.horizontalSpeed != 0) { facing = sign(movement.horizontalSpeed); }

	// limit speed
	movement.horizontalSpeed = min(abs(movement.horizontalSpeed), movement.maxHorizontalSpeed) * facing;
}

function collision() {
	// apply carried over decimals from previous step/iteration
	movement.horizontalSpeed += movement.horizontalSpeedDecimal;
	movement.verticalSpeed += movement.verticalSpeedDecimal;
	
	// floor decimals, then save and subtract
	movement.horizontalSpeedDecimal = movement.horizontalSpeed - (floor(abs(movement.horizontalSpeed)) * sign(movement.horizontalSpeed));
	movement.horizontalSpeed -= movement.horizontalSpeedDecimal;
	movement.verticalSpeedDecimal = movement.verticalSpeed - (floor(abs(movement.verticalSpeed)) * sign(movement.verticalSpeed));
	movement.verticalSpeed -= movement.verticalSpeedDecimal;
	
	// horizontal collisions
	// determine left or right side
	var isRightSide = movement.horizontalSpeed > 0;
	var side = isRightSide ? bbox_right : bbox_left;
	
	// check top and bottom of side
	var testSideTop = tilemap_get_at_pixel(global.map, side + movement.horizontalSpeed, bbox_top);
	var testSideBottom = tilemap_get_at_pixel(global.map, side + movement.horizontalSpeed, bbox_bottom);
	
	if (testSideTop != VOID || testSideBottom != VOID) {
		// collision found (remember x is at the center due to bottom center setting)
		if (isRightSide) {
			x = x - (x mod global.tileSize) + global.tileSize - 1 - (side - x);
		} else {
			x = x - (x mod global.tileSize) - (side - x);
		}
		movement.horizontalSpeed = 0;
	}
	x += movement.horizontalSpeed;
	
	// vertical collisions
	// determine bottom or top
	var isBottom = movement.verticalSpeed > 0;
	var side = isBottom ? bbox_bottom : bbox_top;
	
	// check left and right of bottom/top
	var testLeft = tilemap_get_at_pixel(global.map, bbox_left, side + movement.verticalSpeed);
	var testRight = tilemap_get_at_pixel(global.map, bbox_right, side + movement.verticalSpeed);
	
	if (testLeft != VOID || testRight != VOID) {
		// collision found
		if (isBottom) {
			y = y - (y mod global.tileSize) + global.tileSize - 1 - (side - y);
		} else {
			y = y - (y mod global.tileSize) - (side - y);
		}
		movement.verticalSpeed = 0;
	}
	y += movement.verticalSpeed;
}

function anim() {
	image_xscale = facing; // reface, 1 is normal scale and -1 is flipped
	sprite_index = sprites[state];
	
	switch (state) {
		case PLAYER_STATES.JUMP:
			image_index = movement.verticalSpeed < 0 ? 0 : 1;
		break;
		case PLAYER_STATES.ATTACK:
			if (!on_ground()) {
				sprite_index = s_player_attack_walk;
			} else {
				sprite_index = movement.horizontalSpeed != 0 ? s_player_attack_walk : s_player_attack;
			}
		break;
	}
}

function on_ground() {
	var side = bbox_bottom;
	var testBottomLeft = tilemap_get_at_pixel(global.map, bbox_left, side + 1);
	var testBottomRight = tilemap_get_at_pixel(global.map, bbox_right, side + 1);
	
	return(testBottomLeft == SOLID || testBottomRight == SOLID);
}

function jump_dust() {
	var inst = instance_create_layer(x, y, "Dust", o_player_dust_jump);
	inst.image_xscale = facing; // change in relation to player
}

function jumped() {
	if (on_ground()) {
		movement.jumps = movement.jumpsInitial;
	}
	
	if (movement.jumps > 0) {
		state = PLAYER_STATES.JUMP;
		movement.verticalSpeed = movement.jumpSpeed;
		movement.jumps -= 1;
		jump_dust();
	}
}
