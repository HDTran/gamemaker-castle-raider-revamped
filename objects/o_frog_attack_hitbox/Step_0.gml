/// @description
// check with o_player because there is only one player object
with (instance_place(x, y, o_player)) {
	if (!hurt) {
		hurt = true;

		// face the enemy
		facing = sign(other.x - x);
		
		// ensure facing can never be 0
		if (facing == 0) {
			facing = 1;
		}
		
		// ensure enemy faces the player
		other.facing = -facing; // other will refer to the enemy
		
		// move player away
		var KNOCKBACK_DISTANCE = 5;
		movement.horizontalSpeed = -facing * KNOCKBACK_DISTANCE;
			
		// damage the player
		hp -= 1;
			
		// set hurt timer
		alarm[HURT] = hurtTime;
		
		// change state
		state = PLAYER_STATES.HURTING;
		image_index = 0;
	}
}

// enable death at begin step
die = true;
