// bounce off solids
// horizontal speed check
if (tilemap_get_at_pixel(global.map, x + hspeed, y) == SOLID) {
	hspeed *= -1; // reverse direction if hitting wall
}

// vertical speed check
if (tilemap_get_at_pixel(global.map, x, y + vspeed) == SOLID) {
	vspeed *= -1; // reverse direction if hitting wall
}