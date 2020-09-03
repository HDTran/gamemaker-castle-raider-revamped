/// @description
// get dimensions
var cameraViewWidth = camera_get_view_width(view_camera[0]);
var cameraViewHeight = camera_get_view_height(view_camera[0]);

// create camera
camera = camera_create_view(0, 0, cameraViewWidth, cameraViewHeight, 0, -1, -1, -1, 128, 128);
view_set_camera(0, camera);

// camera following variables
follow = noone;
moveToX = x;
moveToY = y;

// how fast the camera pans
cameraPanSpeedInitial = 0.015; // lower is slower pan
cameraPanSpeed = 1; // 1 instantly warps to player

// reset camera to default pan speed
alarm[CAMERA_RESET] = 3; // alarm sets my milestones to actual game projects

// move to main room
room_goto_next();