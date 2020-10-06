// bounce off solids
// horizontal speed check
var horizontalTest = tilemap_get_at_pixel(global.map, x + hspeed, y);
if (horizontalTest == SOLID || horizontalTest == DEATH) {
	hspeed *= -1; // reverse direction if hitting wall
}

// vertical speed check
var verticalTest = tilemap_get_at_pixel(global.map, x, y + vspeed);
if (verticalTest == SOLID || verticalTest == DEATH) {
	vspeed *= -1; // reverse direction if hitting wall
}
