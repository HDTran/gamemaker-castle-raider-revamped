/// @description
// flash red when getting hurt
if (hurt) {
	flashCounter++;
	var FLASH_DURATION = 8; // how long the sprite will stay red
	if (flashCounter < FLASH_DURATION) {
		// flash white
		gpu_set_fog(true, c_white, 0, 0);
		draw_self();
		gpu_set_fog(false, c_white, 0, 0);
		// draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_maroon, image_alpha);
	} else {
		draw_self();
		if (flashCounter > FLASH_DURATION * 4) {
			flashCounter = 0;
		}
	}
} else {
	draw_self();
}

// debug: show bounding box
//draw_set_alpha(0.3);
//draw_rectangle_color(bbox_left, bbox_top, bbox_right, bbox_bottom, c_red, c_red, c_red, c_red, false);
//draw_set_alpha(1);