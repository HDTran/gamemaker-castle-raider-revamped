/// @description Flash red when taking damage
if (hurt) {
	flashCounter++;
	var FLASH_DURATION = 8; // how long the sprite will stay red
	if (flashCounter < FLASH_DURATION) {
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_maroon, image_alpha);
	} else {
		draw_self();
		if (flashCounter > FLASH_DURATION * 2) {
			flashCounter = 0;
		}
	}
} else {
	draw_self();
}