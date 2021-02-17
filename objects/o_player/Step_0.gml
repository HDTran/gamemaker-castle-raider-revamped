if (!instance_exists(o_fade)) {
	stepFunctions[state]();
} else {
	// stop animations playing
	if (state != PLAYER_STATES.DIE) {
		image_index = 0;
	}
}