function get_input() {
	input = {
		up: keyboard_check(vk_up),
		right: keyboard_check(vk_right),
		down: keyboard_check(vk_down),
		left: keyboard_check(vk_left),
		attack: keyboard_check_pressed(vk_shift),
	}	
}

function calc_movement() {
	speeds.horizontalSpeed += (input.right - input.left) * speeds.walkSpeed;

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
	// horizontal collision
	// apply carried over decimals from previous step/iteration
	speeds.horizontalSpeed += speeds.horizontalSpeedDecimal;
	speeds.verticalSpeed += speeds.verticalSpeedDecimal;
	
	// floor decimals, then save and subtract
	speeds.horizontalSpeedDecimal = speeds.horizontalSpeed - (floor(abs(speeds.horizontalSpeed)) * sign(speeds.horizontalSpeed));
	speeds.horizontalSpeed -= speeds.horizontalSpeedDecimal;
	speeds.verticalSpeedDecimal = speeds.verticalSpeed - (floor(abs(speeds.verticalSpeed)) * sign(speeds.verticalSpeed));
	speeds.verticalSpeed -= speeds.verticalSpeedDecimal;
	
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
	y += speeds.verticalSpeed;
}

function anim() {
	image_xscale = facing; // reface, 1 is normal scale and -1 is flipped
	sprite_index = sprites[state];
}
