/// @description 720 x 360
// get gui dimensions
var gw = display_get_gui_width();
var gh = display_get_gui_height();
	
if (room != rm_menu) {
	if (room  != rm_game_end) {
		// gems
		#region
		draw_set_font(fnt_stats);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		var color = make_color_rgb(173, 144, 159);
		draw_set_color(color);

		// set draw location
		var xStart = gw - 92; // right hand side
		var yStart = 2;
		draw_sprite(s_gem_gui, 0, xStart, yStart);

		// text
		var textX = 7;
		var textY = 22;
		draw_set_color(c_black);
		draw_text(xStart + textX + 1, yStart + textY + 1, o_player.gems);
		draw_set_color(color);
		draw_text(xStart + textX, yStart + textY, o_player.gems);
		#endregion

		// hp bar
		#region
		xStart = 48;
		yStart = 25;
		draw_sprite(s_hp_bar, 1, xStart, yStart);
		draw_sprite_ext(s_hp_bar, 2, xStart, yStart, o_player.hp/o_player.maxHP, 1, 0, c_white, image_alpha);
		draw_sprite(s_hp_bar, 0, xStart, yStart);
		#endregion

		// lives
		#region
		xx = 64;
		yy = 48;
		var gap = 22; // gap between lives
		if (lives > 0) {
			// draw number of lives
			for (var i = 0; i < lives; i++) {
				draw_sprite(s_lives, 0, xx + (i*gap), yy);
			}
		}
		#endregion

		// score
		#region
		xx = gw / 2;
		yy = 11;
		draw_sprite(s_score, 0, xx, yy);
		draw_set_halign(fa_right);
		text_xx = 54;
		text_yy = 14;
		// draw shadow
		draw_set_color(c_black);
		draw_text(xx + text_xx + 1, yy + text_yy + 1, score);
		// draw text
		draw_set_color(color);
		draw_text(xx + text_xx, yy + text_yy, score);
		#endregion
	}

	// game over
	#region
	if (game_over_lose || (game_over_won && game_over_won_delay <= 0)) {
		// center GUI
		if (game_over_won) {
			var mx = gw/4;
			var my = gh/2;
		} else {
			// game over lose
			var mx = gw/2;
			var my = gh/2;
		}
	
		// draw game over
		draw_sprite(s_game_over, 0, mx, my);
		if (game_over_lose) {
			var _index = 0;
		} else {
			var _index = 1;
		}
		draw_sprite(s_game_over_text, _index, mx, my);
		draw_set_halign(fa_right);
		draw_set_color(c_white);
	
		// create array of text to output
		var text;
	
		// line 1
		// gems value | gems | gems total
		text[0] = string(o_player.gems_value) + " x";
		text[1] = o_player.gems;
		var _gems_total = o_player.gems * o_player.gems_value;
		text[2] = _gems_total;
	
		// line 2
		// lives value | lives | lives total
		text[3] = string(o_player.lives_value) + " x";
		text[4] = lives;
		var _lives_total = lives * o_player.lives_value;
		text[5] = _lives_total;
	
		// line 3
		// blank | "Score" | score
		text[6] = "";
		text[7] = "Score";
		text[8] = score;
	
		// line 4
		// blank | "Total Score" | total score
		text[9] = "";
		text[10] = "Total Score";
		var _score_total = score + _gems_total + _lives_total;
		text[11] = _score_total;
	
		// update highscore
		if (_score_total > highscore) {
			highscore = _score_total;
			ini_open(savename);
			ini_write_real("Score", "Highscore", highscore);
			ini_close();
		}
	
		// set starting position
		var xx = mx - 10;
		var yy = my - 32;
	
		// set gaps
		var gap_c = 40; // column gap
		var gap_r = 30; // row gap
	
		// what line we are on
		var line = 0;
		var rows = 4;
		var columns = 3;
	
		for (var j = 0; j < rows; j++) {
			for (var i = 0; i < columns; i++) {
				draw_text(xx + (i * gap_c), yy, text[i + (line * columns)]);
			}
			yy += gap_r;
			line++;
		
			// move down extra for last line
			if (j == 2) {
				yy += gap_r/3;
			}
		}
	}
	#endregion
} else {
	// draww main menu and fade to first level
	// draw bounce
	var start_y = 350; // how far the animation moves
	var factor = start_y;
	
	var max_frames = 60; // how long animation goes for
	if (current_frame < max_frames) {
		current_frame++;
		var move = EaseInOutBounce(current_frame, 0, 1, max_frames);
	} else {
		move = 1;
		// allow game start as menu has dropped
		if (keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1)) && !instance_exists(o_fade) {
			fade_to_room(room_next(room), 0, 0, 1, c_black);
		}
	}
	
	// draw main menu
	draw_sprite(s_main_menu, 0, 0, ((move * factor) - start_y));
	
	// draw highscore
	if (current_frame == max_frames) {
		draw_set_halign(fa_right);
		draw_set_font(fnt_bookman);
		draw_text_ext_color(gw - 10, 28, highscore, 5, 100, c_aqua, c_aqua, c_gray, c_gray, 1);
	}
}

// fade screen in
if (fade_in) {
	alpha = lerp(alpha, 0, fade_spd);
	draw_set_alpha(alpha);
	draw_rectangle_color(0, 0, gw, gh, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}