/// @description
// check with o_player because there is only one player object
with (instance_place(x, y, o_player)) {
	if (!hurt) {
		if (!input.block || (input.block && sign(x - other.x) == facing)) {
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
		} else {
			// is blocking damage
			if (state != PLAYER_STATES.KNOCKBACK) {
				state = PLAYER_STATES.KNOCKBACK;
				image_index = 0;
				image_speed = 1;
				
				// zero hsp_decimal as precision is more important here
				movement.horizontalSpeedDecimal = 0;
				
				// move player away from the attack
				var KNOCKBACK_DISTANCE = 2.5;
				movement.horizontalSpeed = sign(x - other.x) * KNOCKBACK_DISTANCE;
			}
		}
	}
}

// enable death at begin step
die = true;
