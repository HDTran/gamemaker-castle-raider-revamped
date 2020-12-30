/// @description Init
event_inherited(); // run parent code

enum BUG_STATES {
	IDLE,
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

state = BUG_STATES.IDLE;

stepFunctions[BUG_STATES.IDLE] = bug_idle_step;

sprites[BUG_STATES.IDLE] = s_bug_idle;

