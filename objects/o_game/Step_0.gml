if (instance_exists(o_player)) {
	// debug to test gems
	if (mouse_check_button_pressed(mb_left)) {
		repeat(3) {
			instance_create_layer(mouse_x, mouse_y, "Gems", o_gem);
		}
	}

	// debug to test death
	if (mouse_check_button_pressed(mb_right)) {
		o_player.hp = 0;
		/*
		repeat(3) {
			instance_create_layer(mouse_x, mouse_y, "Gems", o_arrow);
		}
		*/
	}
}

if (game_over_lose) {
	with (o_player) {
		get_input();
		if (input.jump || input.attack) {
			game_restart();
		}
	}
}