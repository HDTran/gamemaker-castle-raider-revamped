function player_idle_step() {
	get_input();
	calc_movement();
	// check state
	if (speeds.horizontalSpeed != 0) {
		state = PLAYER_STATES.WALK;	
	}
	collision(); // apply movement
	anim(); // apply animations
};

function player_walk_step() {
	get_input();
	calc_movement();
	// check state
	if (speeds.horizontalSpeed == 0) {
		state = PLAYER_STATES.IDLE;	
	}
	collision(); // apply movement
	anim(); // apply animations
};