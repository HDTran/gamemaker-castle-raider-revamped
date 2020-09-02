function get_input() {
	input = {
		up: keyboard_check(vk_up),
		right: keyboard_check(vk_right),
		down: keyboard_check(vk_down),
		left: keyboard_check(vk_left),
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
	x += speeds.horizontalSpeed;
	y += speeds.verticalSpeed;
}

function anim() {
	image_xscale = facing; // reface, 1 is normal scale and -1 is flipped
	if (speeds.horizontalSpeed != 0) {
		sprite_index = s_player_walk;
	} else {
		sprite_index = s_player_idle;
	}
}
