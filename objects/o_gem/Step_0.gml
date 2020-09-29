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

		// set color
		switch (image_index) {
			case 0:
				var col_head = c_lime;
				var col_tail = make_color_rgb(137, 190, 133);
				break;
			case 1:
				var col_head = c_yellow;
				var col_tail = make_color_rgb(218, 215, 152);
				break;
			case 2:
				var col_head = c_aqua;
				var col_tail = make_color_rgb(152, 193, 218);
				break;
			case 3:
				var col_head = c_fuchsia;
				var col_tail = make_color_rgb(200, 152, 218);
				break;
			case 4:
				var col_head = c_red;
				var col_tail = make_color_rgb(220, 154, 154);
				break;
		}
		
		inst.col_head = col_head;
		inst.col_tail = col_tail;
	}
	instance_destroy();
}


// collision
collision();