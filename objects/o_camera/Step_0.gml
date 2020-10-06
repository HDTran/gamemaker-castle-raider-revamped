/// @description
// move towards moveToX and moveToY
x = lerp(x, moveToX, cameraPanSpeed);
y = lerp(y, moveToY, cameraPanSpeed);

camera_set_view_pos(camera, x - camera_get_view_width(camera)/2, y - camera_get_view_height(camera)/2);

if (follow != noone) {
	moveToX = follow.x;
	var spriteBuffer = global.tileSize/2;
	moveToY = follow.y - spriteBuffer;
}

// make camera not move outside of room
var xx = clamp(camera_get_view_x(camera), 0, room_width - camera_get_view_width(camera));
var yy = clamp(camera_get_view_y(camera), 0, room_height - camera_get_view_height(camera));

// screen shake
if (screen_shake) {
	xx += random_range(-screen_shake_amount, screen_shake_amount);
	yy += random_range(-screen_shake_amount, screen_shake_amount);
}

camera_set_view_pos(camera, xx, yy);

// background parallax scrolling
var layerId = layer_get_id("Background");
layer_x(layerId, lerp(0, camera_get_view_x(view_camera[0]), 0.7));
layer_y(layerId, lerp(0, camera_get_view_y(view_camera[0]), 0.4));