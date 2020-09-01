/// @description

// get input
var input = {
	up: keyboard_check(vk_up),
	right: keyboard_check(vk_right),
	down: keyboard_check(vk_down),
	left: keyboard_check(vk_left),
}

// calculate movement
speeds.horizontalSpeed += (input.right - input.left) * speeds.walkSpeed;

// drag
speeds.horizontalSpeed = lerp(speeds.horizontalSpeed, 0, speeds.drag); // reduce to 0 by drag speed

// stop if below threshold
if (abs(speeds.horizontalSpeed) <= 0.1) { horizontalSpeed = 0; }

// face correct direction
if (speeds.horizontalSpeed != 0) { facing = sign(speeds.horizontalSpeed); }

// limit speed
speeds.horizontalSpeed = min(abs(speeds.horizontalSpeed), speeds.maxHorizontalSpeed) * facing;

// apply movement
x += speeds.horizontalSpeed;
y += speeds.verticalSpeed;

// apply animations
image_xscale = facing; // reface, 1 is normal scale and -1 is flipped
