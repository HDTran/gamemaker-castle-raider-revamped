if (col = c_black) {
	switch (type) {
		case 0:
			// wall torch
			intensity = 0.4;
			radius = 34;
			col = make_color_rgb(220, 134, 59);
		break;
		case 1:
			// window
			intensity = 0.2;
			radius = 27;
			col = make_color_rgb(220, 134, 59);
		break;
		case 2:
			// chest
			intensity = 0.25;
			radius = 40;
			col = c_red;
		break;
		case 3:
			// water
			intensity = 0.3;
			radius = 20;
			col = c_aqua;
		break;
	}
}
