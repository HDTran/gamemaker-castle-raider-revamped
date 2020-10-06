gpu_set_blendmode(bm_add);
if (circle) {
	draw_circle_color(x, y, radius, merge_color(c_black, col, intensity), c_black, 0);
} else {
	// ellipse
	var _w = abs(sprite_width) * .75;
	var _h = abs(sprite_height) + abs(sprite_height) * .75;
	draw_ellipse_color(x - _w, y - _h, x + _w, y + _h, merge_color(c_black, col, intensity), c_black, 0);
}

gpu_set_blendmode(bm_normal);
