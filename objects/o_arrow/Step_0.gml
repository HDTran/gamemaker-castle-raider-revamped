/// @description
var OUTSIDE_ROOM = -1;
	
// movement
movement.horizontalSpeed = movement.walkSpeed * facing;
image_xscale = sign(movement.horizontalSpeed);

// stop if dead
if (die) {
	movement.horizontalSpeed = 0; // stop the arrow on hit of player
}

var test1 = 0, test2 = 0;

// destroy at wall if moved more than 1 tile (so that it can start inside a tile)
if (abs(xstart - x) > global.tileSize) {
	var side = sign(movement.horizontalSpeed) ? bbox_right: bbox_left;
	var test1 = tilemap_get_at_pixel(global.map, side + sign(movement.horizontalSpeed), bbox_top);
	var test2 = tilemap_get_at_pixel(global.map, side + sign(movement.horizontalSpeed), bbox_bottom);
	
	if (test1 == SOLID || test1 == OUTSIDE_ROOM || test2 == SOLID || test2 == OUTSIDE_ROOM) {
		die = true;
	}
	collision();
} else {
	x += movement.horizontalSpeed;
}

// play animation
if (die) {
	// jump to image index 1 the first time we run die so that it starts on the right frame
	if (image_speed != 1) {
		image_index = 1;
	}

	image_speed = 1;
}

// destroy arrow if leaving room
if (x > room_width || x < 0) {
	instance_destroy();
}

if (test1 == OUTSIDE_ROOM || test2 == OUTSIDE_ROOM) {
	instance_destroy();
}