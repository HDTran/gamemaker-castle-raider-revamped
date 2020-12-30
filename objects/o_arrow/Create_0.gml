/// @description Init variables
movement = {
	horizontalSpeed: 0,
	verticalSpeed: 0,
	horizontalSpeedDecimal: 0,
	verticalSpeedDecimal: 0,
	walkSpeed: 4,
}

facing = -1;
image_speed = 0; // stay on first frame

// destroy object
die = false;

// change the object's layer after a set time
alarm[LAYER_CHANGE] = room_speed/7;
