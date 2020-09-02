/// @description Init
enum PLAYER_STATES {
	IDLE,
	WALK,
	JUMP,
	ATTACK,
	BLOCK,
	CROUCH,
	CROUCH_BLOCK,
};
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

state = PLAYER_STATES.IDLE;

stepFunctions[PLAYER_STATES.IDLE] = player_idle_step;
stepFunctions[PLAYER_STATES.WALK] = player_walk_step;

states[PLAYER_STATES.IDLE] = {
	sprite: s_player_idle,
	step: stepFunctions[PLAYER_STATES.IDLE],
};
states[PLAYER_STATES.WALK] = {
	sprite: s_player_walk,
	step: stepFunctions[PLAYER_STATES.WALK],
};
states[PLAYER_STATES.JUMP] = {
	sprite: s_player_jump,
	step: function() {},
};
states[PLAYER_STATES.ATTACK] = {
	sprite: s_player_attack,
	step: function() {},
};
states[PLAYER_STATES.BLOCK] = {
	sprite: s_player_block,
	step: function() {},
};
states[PLAYER_STATES.CROUCH] = {
	sprite: s_player_crouch,
	step: function() {},
};
states[PLAYER_STATES.CROUCH_BLOCK] = {
	sprite: s_player_crouch_block,
	step: function() {},
};
