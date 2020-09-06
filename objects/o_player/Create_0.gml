/// @description Init
enum PLAYER_STATES {
	IDLE,
	WALK,
	JUMP,
	ATTACK,
	BLOCK,
	CROUCH,
	CROUCH_BLOCK,
	HURTING,
	KNOCKBACK
};

movement = {
	horizontalSpeed: 0,
	verticalSpeed: 0,
	maxHorizontalSpeed: 2,
	horizontalSpeedDecimal: 0, // subpixel remainder to be carried over post calculation
	verticalSpeedDecimal: 0, // subpixel remainder to be carried over post calculation
	walkSpeed: 1.5,
	drag: 0.15,
	jumpDampner: 2.5,
	jumpSpeed: -5,
	jumpsInitial: 2,
	jumps: 2,
}

facing = 1; // 1 is facing right, -1 is facing left

// gems
gems = 0;

// hurt
flashCounter = 0;
hurt = false;
hurtTime = room_speed;
hp = 5;

input = {
	up: 0,
	right: 0,
	down: 0,
	left: 0,
	attack: 0,
	jump: 0,
	jumpHeld: 0,
	block: 0
}

o_camera.follow = o_player;

state = PLAYER_STATES.IDLE;

stepFunctions[PLAYER_STATES.IDLE] = player_idle_step;
stepFunctions[PLAYER_STATES.WALK] = player_walk_step;
stepFunctions[PLAYER_STATES.JUMP] = player_jump_step;
stepFunctions[PLAYER_STATES.ATTACK] = player_attack_step;
stepFunctions[PLAYER_STATES.BLOCK] = player_block_step;
stepFunctions[PLAYER_STATES.CROUCH] = player_crouch_step;
stepFunctions[PLAYER_STATES.CROUCH_BLOCK] = player_crouch_block_step;
stepFunctions[PLAYER_STATES.HURTING] = player_hurting_step;
stepFunctions[PLAYER_STATES.KNOCKBACK] = player_knockback_step;

sprites[PLAYER_STATES.IDLE] = s_player_idle;
sprites[PLAYER_STATES.WALK] = s_player_walk;
sprites[PLAYER_STATES.JUMP] = s_player_jump;
sprites[PLAYER_STATES.ATTACK] = s_player_attack;
sprites[PLAYER_STATES.BLOCK] = s_player_block;
sprites[PLAYER_STATES.CROUCH] = s_player_crouch;
sprites[PLAYER_STATES.CROUCH_BLOCK] = s_player_crouch_block;
sprites[PLAYER_STATES.HURTING] = s_player_hurting;
sprites[PLAYER_STATES.KNOCKBACK] = s_player_knockback;

masks[PLAYER_STATES.IDLE] = s_player_idle;
masks[PLAYER_STATES.WALK] = s_player_idle;
masks[PLAYER_STATES.JUMP] = s_player_idle;
masks[PLAYER_STATES.ATTACK] = s_player_idle;
masks[PLAYER_STATES.BLOCK] = s_player_idle;
masks[PLAYER_STATES.CROUCH] = s_player_crouch;
masks[PLAYER_STATES.CROUCH_BLOCK] = s_player_crouch;
masks[PLAYER_STATES.HURTING] = s_player_idle;
masks[PLAYER_STATES.KNOCKBACK] = s_player_knockback;
