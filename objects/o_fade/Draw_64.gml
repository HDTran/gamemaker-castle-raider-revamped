// get dimensions
var dw = display_get_gui_width();
var dh = display_get_gui_height();

// fade to color
if (fade_to_color) {
	alpha += fade_spd;
	draw_set_alpha(alpha);
	draw_rectangle_color(0, 0, dw, dh, col, col, col, col, false);
	if (alpha >= 1) {
		fade_to_color = false;
		with (o_player) {
			// set starting position
			// other is now fade object
			room_start_pos_x = other.target_x;
			room_start_pos_y = other.target_y;
			x = room_start_pos_x;
			y = room_start_pos_y;
			
			// set facing direction
			room_start_facing = other.facing;
			facing = room_start_facing;
			
			// reset values
			horizontalSpeed = 0;
			verticalSpeed = 0;
			horizontalSpeedDecimal = 0;
			verticalSpeedDecimal = 0;
			scale_x = 1;
			scale_y = 1;
			
			// change state and update animation
			state = PLAYER_STATES.IDLE;
			anim();
		}
		
		// pan camera quickly
		o_camera.cameraPanSpeed = 1;
		room_goto(target_rm);
	}
} else {
	// fade from color
	alpha -= fade_spd;
	draw_set_alpha(alpha);
	draw_rectangle_color(0, 0, dw, dh, col, col, col, col, false);
	if (alpha <= 0) {
		// reset camera pan speed
		o_camera.cameraPanSpeed = o_camera.cameraPanSpeedInitial;
		instance_destroy();
	}
}

// reset alpha from the fade for future draws
draw_set_alpha(1);