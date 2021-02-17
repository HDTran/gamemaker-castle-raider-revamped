with (other) {
	// with transition object
	if (!active) {
		// other is player now
		fade_to_room(target_rm, target_x, target_y, other.facing, c_black);
		active = true;
	}
	
	if(target_rm == rm_game_end) { 
		with (o_game) {
			o_game.game_over_won = true;
		}
	}
}