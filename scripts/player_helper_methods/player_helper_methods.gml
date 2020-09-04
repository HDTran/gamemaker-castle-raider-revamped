function anim() {
	image_xscale = facing; // reface, 1 is normal scale and -1 is flipped
	sprite_index = sprites[state];
	mask_index = masks[state];
	
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

function block_check() {
	if (input.block) {
		state = input.down ? PLAYER_STATES.CROUCH_BLOCK : PLAYER_STATES.BLOCK;
		movement.horizontalSpeed = 0;
	} else {
		if (movement.horizontalSpeed != 0) {
			state = !on_ground() ? PLAYER_STATES.JUMP : PLAYER_STATES.WALK;
		} else {
			state = input.down ? PLAYER_STATES.CROUCH : PLAYER_STATES.IDLE;
		}
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

	// controller input
	var deviceIndex = 0; // first gamepad (of 4)
	var deadzone = 0.3;
	if (gamepad_is_connected(deviceIndex)) {
		input.left = gamepad_axis_value(deviceIndex, gp_axislh) < -deadzone || gamepad_button_check_pressed(deviceIndex, gp_padl) || input.left;
		input.right = gamepad_axis_value(deviceIndex, gp_axislh) > deadzone || gamepad_button_check_pressed(deviceIndex, gp_padr) ||input.right;
		input.up = gamepad_axis_value(deviceIndex, gp_axislv) < -deadzone || gamepad_button_check_pressed(deviceIndex, gp_padu) ||input.up;
		input.down = gamepad_axis_value(deviceIndex, gp_axislv) > deadzone || gamepad_button_check_pressed(deviceIndex, gp_padd) ||input.down;
		input.attack = gamepad_button_check_pressed(deviceIndex, gp_face2) || input.attack;
		input.jump = gamepad_button_check_pressed(deviceIndex, gp_face1) || input.jump;
		input.jumpHeld = gamepad_button_check(deviceIndex, gp_face1) || input.jumpHeld;
		input.block = gamepad_button_check(deviceIndex, gp_shoulderr) || input.block;
	}
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

function on_ground() {
	var side = bbox_bottom;
	var testBottomLeftSurface = tilemap_get_at_pixel(global.map, bbox_left, side + 1);
	var testBottomRightSurface = tilemap_get_at_pixel(global.map, bbox_right, side + 1);
	var testBottomLeftBelow = tilemap_get_at_pixel(global.map, bbox_left, side);
	var testBottomRightBelow = tilemap_get_at_pixel(global.map, bbox_right, side);

	return(
		(testBottomLeftSurface == SOLID || testBottomLeftSurface == PLATFORM) &&
		(testBottomLeftBelow != SOLID && testBottomLeftBelow != PLATFORM) ||
		(testBottomLeftSurface == SOLID || testBottomLeftBelow == PLATFORM) ||
		(testBottomRightSurface == SOLID || testBottomRightSurface == PLATFORM) &&
		(testBottomRightBelow != SOLID && testBottomRightBelow != PLATFORM) ||
		(testBottomRightSurface == SOLID && testBottomRightBelow == PLATFORM)
	);
}
