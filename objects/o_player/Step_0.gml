if (!instance_exists(o_fade)) {
	stepFunctions[state]();
} else {
	// stop animations playing
	image_index = 0;
}