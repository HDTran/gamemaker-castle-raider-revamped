/// @description Init
enum FROG_STATES {
	IDLE,
	JUMP_START,
	JUMP,
	JUMP_LAND,
	ATTACK
};

movement = {
	horizontalSpeed: 0,
	horizontalSpeedDecimal: 0,
	maxHorizontalSpeedInitial: 2,
	maxHorizontalSpeed: 2,
	verticalSpeed: 0,
	verticalSpeedDecimal: 0,
	walkSpeed: 2,
	jumpChance: 0.5, // will he jump this change
	jumpSpeed: -6,
	jumpTimerInitial: random_range(room_speed, room_speed * 1.5), // how often to check for a jump chance
	jumpTimer: room_speed,
}
movement.maxHorizontalSpeed = movement.maxHorizontalSpeedInitial;
movement.jumpTimer = movement.jumpTimerInitial;

facing = choose(-1, 1);

// attacking
canAttack = true;
attackDelay = room_speed;
attack = false;
inhale = false;
inhaleTimer = room_speed * 0.3;

// breathing
breathTimerInitial = random_range(room_speed * 1.75, room_speed * 2.25);
breathTimer = breathTimerInitial;
image_speed = 0;

state = FROG_STATES.IDLE;

stepFunctions[FROG_STATES.IDLE] = frog_idle_step;
stepFunctions[FROG_STATES.JUMP_START] = frog_jump_start_step;
stepFunctions[FROG_STATES.JUMP] = frog_jump_step;
stepFunctions[FROG_STATES.JUMP_LAND] = frog_jump_land_step;
stepFunctions[FROG_STATES.ATTACK] = frog_attack_step;

sprites[FROG_STATES.IDLE] = s_frog_idle;
sprites[FROG_STATES.JUMP_START] = s_frog_jump_start;
sprites[FROG_STATES.JUMP] = s_frog_jump;
sprites[FROG_STATES.JUMP_LAND] = s_frog_jump_land;
sprites[FROG_STATES.ATTACK] = s_frog_attack;
