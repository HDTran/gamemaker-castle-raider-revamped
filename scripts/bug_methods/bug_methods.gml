function bug_idle_step() {
	// check health
	checkEnemyHP();
	
	// set speed
	movement.horizontalSpeed = 0;
	movement.verticalSpeed = 0;

	// apply movement
	collision();

	// animations
	bug_anim();
}
