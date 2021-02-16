/// @description
calc_entity_movement();

// bounce
if (on_ground() and !hasBounced) {
	// give vertical movement
	movement.verticalSpeed = movement.verticalSpeedInitial * random_range(0.7, 0.8);
	hasBounced = true;
	canPickup = true;
}

// bouncing off walls
var side = sign(movement.horizontalSpeedInitial) ? bbox_right : bbox_left;
var test = tilemap_get_at_pixel(global.map, side + sign(movement.horizontalSpeedInitial), bbox_bottom);

if (test == SOLID) {
	// wall found, reverse direction
	movement.horizontalSpeed = movement.horizontalSpeedInitial * 0.75 * -1; // 0.75 reduces power, -1 refaces
}

// destroy gem if death or if it falls out of the room
if (y > room_height) {
	instance_destroy();
}

// generate sparks
if (die) {
	repeat(o_game.gem_sparks) {
		var inst = instance_create_depth(x, y, depth, o_spark);
		inst.col_head = c_white;
		inst.col_tail = c_maroon;
	}
	instance_destroy();
}


// collision
collision();

// update the light's position
with (light_id) {
	x = other.x;
	y = other.y;
}
