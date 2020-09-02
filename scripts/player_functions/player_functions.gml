function get_input() {
	input = {
		up: keyboard_check(vk_up),
		right: keyboard_check(vk_right),
		down: keyboard_check(vk_down),
		left: keyboard_check(vk_left),
		attack: keyboard_check_pressed(vk_shift),
		jump: keyboard_check_pressed(vk_space),
		block: keyboard_check(ord("Z")),
	}	
}

function calc_movement() {
	speeds.horizontalSpeed += (input.right - input.left) * speeds.walkSpeed;
	speeds.verticalSpeed += global.gravity;

	// drag
	speeds.horizontalSpeed = lerp(speeds.horizontalSpeed, 0, speeds.drag); // reduce to 0 by drag speed

	// stop if below threshold
	if (abs(speeds.horizontalSpeed) <= 0.1) { speeds.horizontalSpeed = 0; }

	// face correct direction
	if (speeds.horizontalSpeed != 0) { facing = sign(speeds.horizontalSpeed); }

	// limit speed
	speeds.horizontalSpeed = min(abs(speeds.horizontalSpeed), speeds.maxHorizontalSpeed) * facing;
}

function collision() {
	// apply carried over decimals from previous step/iteration
	speeds.horizontalSpeed += speeds.horizontalSpeedDecimal;
	speeds.verticalSpeed += speeds.verticalSpeedDecimal;
	
	// floor decimals, then save and subtract
	speeds.horizontalSpeedDecimal = speeds.horizontalSpeed - (floor(abs(speeds.horizontalSpeed)) * sign(speeds.horizontalSpeed));
	speeds.horizontalSpeed -= speeds.horizontalSpeedDecimal;
	speeds.verticalSpeedDecimal = speeds.verticalSpeed - (floor(abs(speeds.verticalSpeed)) * sign(speeds.verticalSpeed));
	speeds.verticalSpeed -= speeds.verticalSpeedDecimal;
	
	// horizontal collisions
	// determine left or right side
	var isRightSide = speeds.horizontalSpeed > 0;
	var side = isRightSide ? bbox_right : bbox_left;
	
	// check top and bottom of side
	var testSideTop = tilemap_get_at_pixel(global.map, side + speeds.horizontalSpeed, bbox_top);
	var testSideBottom = tilemap_get_at_pixel(global.map, side + speeds.horizontalSpeed, bbox_bottom);
	
	if (testSideTop != VOID || testSideBottom != VOID) {
		// collision found (remember x is at the center due to bottom center setting)
		if (isRightSide) {
			x = x - (x mod global.tileSize) + global.tileSize - 1 - (side - x);
		} else {
			x = x - (x mod global.tileSize) - (side - x);
		}
		speeds.horizontalSpeed = 0;
	}
	x += speeds.horizontalSpeed;
	
	// vertical collisions
	// determine bottom or top
	var isBottom = speeds.verticalSpeed > 0;
	var side = isBottom ? bbox_bottom : bbox_top;
	
	// check left and right of bottom/top
	var testLeft = tilemap_get_at_pixel(global.map, bbox_left, side + speeds.verticalSpeed);
	var testRight = tilemap_get_at_pixel(global.map, bbox_right, side + speeds.verticalSpeed);
	
	if (testLeft != VOID || testRight != VOID) {
		// collision found
		if (isBottom) {
			y = y - (y mod global.tileSize) + global.tileSize - 1 - (side - y);
		} else {
			y = y - (y mod global.tileSize) - (side - y);
		}
		speeds.verticalSpeed = 0;
	}
	y += speeds.verticalSpeed;
}

function anim() {
	image_xscale = facing; // reface, 1 is normal scale and -1 is flipped
	sprite_index = sprites[state];
	
	switch (state) {
		case PLAYER_STATES.JUMP:
			image_index = speeds.verticalSpeed < 0 ? 0 : 1;
		break;
		case PLAYER_STATES.ATTACK:
			if (!on_ground()) {
				sprite_index = s_player_attack_walk;
			} else {
				sprite_index = speeds.horizontalSpeed != 0 ? s_player_attack_walk : s_player_attack;
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