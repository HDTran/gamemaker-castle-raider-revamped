/// @description Init
event_inherited(); // run parent code

enum BUG_STATES {
	IDLE,
	PATROL,
};

movement = {
	horizontalSpeed: 0,
	horizontalSpeedDecimal: 0,
	maxHorizontalSpeedInitial: 0.5,
	maxHorizontalSpeed: 2,
	verticalSpeed: 0,
	verticalSpeedDecimal: 0,
	walkSpeed: 0.5,
	drag: 0.04,
}

hp = 3;
deathGemValue = 5;

facing = choose(-1, 1);

// patrol
patrol_dis = 96; // how far the bug moves in one direction
// patrol start position
start_x = x;
start_y = y;
// how long to wait before patrolling
wait_time_initial = random_range(room_speed * 2, room_speed * 4);
wait_time = wait_time_initial;

state = BUG_STATES.IDLE;

stepFunctions[BUG_STATES.IDLE] = bug_idle_step;
stepFunctions[BUG_STATES.PATROL] = bug_patrol_step;

sprites[BUG_STATES.IDLE] = s_bug_idle;
sprites[BUG_STATES.PATROL] = s_bug_idle;

