/// @description
// cycle through all enemies and see if they were hit
with (o_enemy) {
	// check collision
	if (place_meeting(x, y, other)) {
		if (!hurt) {
			hurt = true;
			
			// get sign direction from hitbox to enemy
			var dir = sign(x - other.x);
			
			// ensure objects are not at the same x
			if (dir == 0) {
				dir = 1;
			}
			
			// face the hitbox if on ground (not air)
			if (on_ground()) {
				facing = -dir; // reverse of hitbox to enemy since it's enemy to hitbox
			}
			
			// damage
			hp -= 1;
			
			// set hurt timer
			alarm[HURT] = hurtTime;
		}
	}
}

// enable death at begin step
die = true;
