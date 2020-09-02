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
	horizontalSpeedDecimal: 0, // subpixel remainder to be carried over post calculation
	verticalSpeedDecimal: 0, // subpixel remainder to be carried over post calculation
	walkSpeed: 1.5,
	drag: 0.15,
}

facing = FACING_RIGHT; // 1 is facing right, -1 is facing left

input = {
	up: 0,
	right: 0,
	down: 0,
	left: 0,
	attack: 0,
}

state = PLAYER_STATES.IDLE;

stepFunctions[PLAYER_STATES.IDLE] = player_idle_step;
stepFunctions[PLAYER_STATES.WALK] = player_walk_step;
stepFunctions[PLAYER_STATES.JUMP] = player_idle_step;
stepFunctions[PLAYER_STATES.ATTACK] = player_attack_step;
stepFunctions[PLAYER_STATES.BLOCK] = player_idle_step;
stepFunctions[PLAYER_STATES.CROUCH] = player_idle_step;
stepFunctions[PLAYER_STATES.CROUCH_BLOCK] = player_idle_step;

sprites[PLAYER_STATES.IDLE] = s_player_idle;
sprites[PLAYER_STATES.WALK] = s_player_walk;
sprites[PLAYER_STATES.JUMP] = s_player_jump;
sprites[PLAYER_STATES.ATTACK] = s_player_attack;
sprites[PLAYER_STATES.BLOCK] = s_player_block;
sprites[PLAYER_STATES.CROUCH] = s_player_crouch;
sprites[PLAYER_STATES.CROUCH_BLOCK] = s_player_crouch_block;
