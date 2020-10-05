function checkEnemyHP() {
	if (hp <= 0) {
		repeat(deathGemValue) {
			instance_create_layer(x, bbox_top, "Gems", o_gem);
			// generate particles
			repeat(o_game.enemy_sparks) {
				var inst = instance_create_depth(x, (bbox_bottom + bbox_top)/2, depth-1, o_spark);
				switch (object_index) {
					case o_frog:
						if (choose(0, 1, 1)) {
							// gray
							inst.col_head = c_gray;
							inst.col_tail = c_dkgray;
						} else {
							// white
							inst.col_head = c_white;
							inst.col_tail = c_ltgray;
						}
					break;
				}
			}
		}
		instance_destroy();
	}
}

/// @description process_enemy_attack(hurtKnockback, blockKnockback)
function process_enemy_attack(hurtKnockback, blockKnockback) {
	hurtKnockback = typeof(hurtKnockback) == "undefined" ? 4 : hurtKnockback;
	blockKnockback = typeof(blockKnockback) == "undefined" ? 2.5 : blockKnockback;
	if (o_player.hp > 0 && !hurt) {
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
			movement.horizontalSpeed = -facing * hurtKnockback;
			
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
				movement.horizontalSpeed = sign(x - other.x) * blockKnockback;
			}
		}
	}	
}