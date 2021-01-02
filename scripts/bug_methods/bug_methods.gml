function bug_chase_step() {
	// check health
	checkEnemyHP();
	
	// calculate target movement
	if (o_player.hp > 0) {
		target_x = o_player.xprevious;
		target_y = o_player.yprevious - (sprite_get_height(o_player.sprite_index) / 2);
	} else {
		state = BUG_STATES.IDLE;
	}
	
	// calculate movement
	var _dir = point_direction(x, y, target_x, target_y);
	var xx = lengthdir_x(chase_spd, _dir);
	var yy = lengthdir_y(chase_spd, _dir);
	
	movement.horizontalSpeed = xx;
	movement.verticalSpeed = yy;
	
	// facing direction
	if (sign(movement.horizontalSpeed) != 0) {
		facing = sign(movement.horizontalSpeed);
	}

	// apply movement
	collision();

	// animations
	bug_anim();
}

function bug_idle_step() {
	// check health
	checkEnemyHP();
	
	// set speed
	movement.horizontalSpeed = 0;
	movement.verticalSpeed = 0;

	// change state
	if (wait_time < 0) {
		facing *= -1; // reverse patrol
		start_x = x;
		state = BUG_STATES.PATROL;
		wait_time = wait_time_initial;
	} else {
		wait_time--;
	}
	
	// chase
	if (distance_to_object(o_player) < chase_distance && o_player.hp > 0) {
		state = BUG_STATES.CHASE;
	}

	// apply movement
	collision();

	// animations
	bug_anim();
}

function bug_patrol_step() {
	// check health
	checkEnemyHP();
	
	// set speed
	movement.horizontalSpeed = movement.walkSpeed * facing;
	movement.verticalSpeed = 0;

	// change state
	if (abs(start_x - x) > patrol_dis) {
		state = BUG_STATES.IDLE;
	}
	
	// turn around if wall is found
	var side = facing ? bbox_right : bbox_left;
	var t1 = tilemap_get_at_pixel(global.map, side + sign(movement.horizontalSpeed), y);
	if (t1 == SOLID) {
		state = BUG_STATES.IDLE;
	}
	
	// chase
	if (distance_to_object(o_player) < chase_distance && o_player.hp > 0) {
		state = BUG_STATES.CHASE;
	}

	// apply movement
	collision();

	// animations
	bug_anim();
}
