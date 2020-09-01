/// @description Init
FACING_RIGHT = 1;

speeds = {
	horizontalSpeed: 0,
	verticalSpeed: 0,
	maxHorizontalSpeed: 2,
	walkSpeed: 1.5,
	drag: 0.15,
}

facing = FACING_RIGHT; // 1 is facing right, -1 is facing left

input = {
	up: 0,
	right: 0,
	down: 0,
	left: 0,
}

// states
enum states { IDLE, WALK };
state = states.IDLE;

player_idle_state = function() {
	// get input
	get_input();

	// calculate movement
	calc_movement();

	// check state
	if (speeds.horizontalSpeed != 0) {
		state = states.WALK;	
	}

	// apply movement
	collision();

	// apply animations
	anim();
}

player_walk_state = function() {
	// get input
	get_input();

	// calculate movement
	calc_movement();

	// check state
	if (speeds.horizontalSpeed == 0) {
		state = states.IDLE;	
	}

	// apply movement
	collision();

	// apply animations
	anim();
}