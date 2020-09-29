// draw line

// set blend mode
gpu_set_blendmode(bm_add); // drawn over top of what's under them in addition

// draw head
draw_set_color(col_head);
draw_line_width(xp, yp, x, y, min(abs(speed), 1) * line_width);

// draw tail
draw_set_color(col_tail);
draw_line_width(xpp, ypp, xp, yp, min(abs(speed), 1) * line_width);

// reset blendmode
gpu_set_blendmode(bm_normal);

// update variables
// update positions
xpp = xp;
ypp = yp;
xp = xprevious;
yp = yprevious;

// update directions
direction += dir_change;
dir_change *= dir_change_decay;

// update speed
speed *= speed_decay;

// die if not visible
if (abs(speed) < 0.1) {
	instance_destroy();
}
