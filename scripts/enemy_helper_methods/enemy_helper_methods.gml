function calc_entity_movement() {
	movement.verticalSpeed += global.gravity;

	// drag
	movement.horizontalSpeed = lerp(movement.horizontalSpeed, 0, drag); // reduce to 0 by drag speed

	// stop if below threshold
	if (abs(movement.horizontalSpeed) <= 0.1) { movement.horizontalSpeed = 0; }
}
