/// @description Shoot if within view
if (on_screen(global.tileSize)) {
	// object is within the screen
	if (can_fire) {
		can_fire = false;
		
		// set spawn position from the center
		var PIXEL_DIFFERENCE = 2;
		var ypos = ((sprite_get_height(sprite_index) / 2) - PIXEL_DIFFERENCE) * spawn_pos; // multiply for top or  bottom
		
		// switch y position for next arrow
		spawn_pos *= -1;
		
		// create arrow
		var inst = instance_create_layer(x, y + ypos, "Arrow_shoot", o_arrow);
		inst.facing = facing; // facing the same as spawner
		
		// create spark
		var side = facing ? bbox_right : bbox_left;
		var inst = instance_create_layer(side, y + ypos, "Arrow_shoot", o_arrow_spark);
		inst.image_xscale = facing;
		
		// create sound
		audio_play_sound(snd_arrow_firing, 10, false);
	} else {
		fire_delay = fire_delay - 1;
		if (fire_delay <= 0) {
			can_fire = true;
			fire_delay = fire_delay_initial;
		}
	}
}