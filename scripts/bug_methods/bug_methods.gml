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

	// apply movement
	collision();

	// animations
	bug_anim();
}
