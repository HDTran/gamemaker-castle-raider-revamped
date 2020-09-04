function collision() {
	if (movement.horizontalSpeed == 0) {
		movement.horizontalSpeedDecimal = 0;
	}
	if (movement.verticalSpeed == 0) {
		movement.verticalSpeedDecimal = 0;
	}
	// apply carried over decimals from previous step/iteration
	movement.horizontalSpeed += movement.horizontalSpeedDecimal;
	movement.verticalSpeed += movement.verticalSpeedDecimal;
	
	// floor decimals, then save and subtract
	movement.horizontalSpeedDecimal = movement.horizontalSpeed - (floor(abs(movement.horizontalSpeed)) * sign(movement.horizontalSpeed));
	movement.horizontalSpeed -= movement.horizontalSpeedDecimal;
	movement.verticalSpeedDecimal = movement.verticalSpeed - (floor(abs(movement.verticalSpeed)) * sign(movement.verticalSpeed));
	movement.verticalSpeed -= movement.verticalSpeedDecimal;
	
	// horizontal collisions
	// determine left or right side
	var isRightSide = movement.horizontalSpeed > 0;
	var side = isRightSide ? bbox_right : bbox_left;
	
	// check top and bottom of side
	var testSideTop = tilemap_get_at_pixel(global.map, side + movement.horizontalSpeed, bbox_top);
	var testSideBottom = tilemap_get_at_pixel(global.map, side + movement.horizontalSpeed, bbox_bottom);
	
	if ((testSideTop != VOID && testSideTop != PLATFORM) || (testSideBottom != VOID && testSideBottom != PLATFORM)) {
		// collision found (remember x is at the center due to bottom center setting)
		if (isRightSide) {
			x = x - (x mod global.tileSize) + global.tileSize - 1 - (side - x);
		} else {
			x = x - (x mod global.tileSize) - (side - x);
		}
		movement.horizontalSpeed = 0;
	}
	x += movement.horizontalSpeed;
	
	// vertical collisions
	// determine bottom or top
	var isMovingDown = movement.verticalSpeed > 0;
	var side = isMovingDown ? bbox_bottom : bbox_top;
	
	// check left and right of bottom/top and where they're going to be
	var testLeft = tilemap_get_at_pixel(global.map, bbox_left, side + movement.verticalSpeed);
	var testRight = tilemap_get_at_pixel(global.map, bbox_right, side + movement.verticalSpeed);
	
	// check left and right bottom for platforms
	var testBottomLeft = tilemap_get_at_pixel(global.map, bbox_left, bbox_bottom - 1);
	var testBottomRight = tilemap_get_at_pixel(global.map, bbox_right, bbox_bottom - 1);
	
	if (testLeft != VOID && (((movement.verticalSpeed > 0 || testLeft != PLATFORM)) && testBottomLeft != PLATFORM) || (testLeft == SOLID && testBottomLeft == PLATFORM)) ||
	(testRight != VOID && (((movement.verticalSpeed > 0 || testRight != PLATFORM)) && (testBottomRight != PLATFORM) || (testRight == SOLID && testBottomRight == PLATFORM))) {
		// collision found
		if (isMovingDown) {
			y = y - (y mod global.tileSize) + global.tileSize - 1 - (side - y);
		} else {
			y = y - (y mod global.tileSize) - (side - y);
		}
		movement.verticalSpeed = 0;
	}
	y += movement.verticalSpeed;
}

function on_ground() {
	var side = bbox_bottom;
	var testBottomLeftSurface = tilemap_get_at_pixel(global.map, bbox_left, side + 1);
	var testBottomRightSurface = tilemap_get_at_pixel(global.map, bbox_right, side + 1);
	var testBottomLeftBelow = tilemap_get_at_pixel(global.map, bbox_left, side);
	var testBottomRightBelow = tilemap_get_at_pixel(global.map, bbox_right, side);

	return(
		(testBottomLeftSurface == SOLID || testBottomLeftSurface == PLATFORM) &&
		(testBottomLeftBelow != SOLID && testBottomLeftBelow != PLATFORM) ||
		(testBottomLeftSurface == SOLID || testBottomLeftBelow == PLATFORM) ||
		(testBottomRightSurface == SOLID || testBottomRightSurface == PLATFORM) &&
		(testBottomRightBelow != SOLID && testBottomRightBelow != PLATFORM) ||
		(testBottomRightSurface == SOLID && testBottomRightBelow == PLATFORM)
	);
}
