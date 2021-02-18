/// @description Check arrow
var take_damage = false;

// only do this if arrow is not set to die
if (!other.die) {
	// if player is looking away, take damage
	if (facing == other.facing) {
		take_damage = true;
	} else {
		// facing arrow
		if (input.block) {
			if (input.down) {
				// blocking and crouching
				other.die = true;
				audio_play_sound(snd_block, 15, false);
			} else {
				// blocking and standing (arrow will hit head or knees)
				take_damage = true;
			}
		} else {
			// not blocking
			take_damage = true;
		}
	}
	
	// don't take damage if dead
	if (hp <= 0) {
		take_damage = false;
	}
	
	// process damag
	if (take_damage) {
		if (!hurt) {
			hurt = true;
			
			// damage_player
			hp -= 1;
			
			// set hurt time
			alarm[HURT] = hurtTime;
			
			// screen_shake
			scr_screen_shake(0.125, -1);
			
			audio_play_sound(snd_player_hit, 20, false);
		} else {
			other.die = true;
		}
	}
}
