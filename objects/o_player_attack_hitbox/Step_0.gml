/// @description
// cycle through all enemies and see if they were hit
with (o_enemy) {
	// distance to object check to reduce collision checks
	if (distance_to_object(other) < 60) {
		// check collision
		if (place_meeting(x, y, other)) {
			if (!hurt) {
				hurt = true;
			
				// get sign direction from hitbox to enemy
				var dir = sign(x - other.x);
				
				// move away from the hitbox/player
				var KNOCKBACK_DISTANCE = 3;
				movement.horizontalSpeed = dir * KNOCKBACK_DISTANCE;
			
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
				
				scr_screen_shake(.1, 1.5);

				var inst = instance_create_depth(x, (bbox_top + bbox_bottom)/2, depth -1, o_sword_hit);
				inst.image_xscale = o_player.facing;
				if (hp <= 0) {
					var inst = instance_create_depth(x, (bbox_top + bbox_bottom)/2, depth -1, o_sword_hit);
					inst.image_xscale = o_player.facing;
					inst.sprite_index = s_sword_hit2;
				}
			}
		}
	}
}

// enable death at begin step
die = true;
