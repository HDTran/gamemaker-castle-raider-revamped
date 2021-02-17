/// @description 720 x 360
// get gui dimensions
var gw = display_get_gui_width();
var gh = display_get_gui_height();

// gems
draw_set_font(fnt_stats);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var color = make_color_rgb(173, 144, 159);
draw_set_color(color);

// set draw location
var xStart = gw - 92; // right hand side
var yStart = 2;
draw_sprite(s_gem_gui, 0, xStart, yStart);

// text
var textX = 7;
var textY = 22;
draw_set_color(c_black);
draw_text(xStart + textX + 1, yStart + textY + 1, o_player.gems);
draw_set_color(color);
draw_text(xStart + textX, yStart + textY, o_player.gems);

// hp bar
xStart = 48;
yStart = 25;
draw_sprite(s_hp_bar, 1, xStart, yStart);
draw_sprite_ext(s_hp_bar, 2, xStart, yStart, o_player.hp/o_player.maxHP, 1, 0, c_white, image_alpha);
draw_sprite(s_hp_bar, 0, xStart, yStart);

// lives
xx = 64;
yy = 48;
var gap = 22; // gap between lives
if (lives > 0) {
	// draw number of lives
	for (var i = 0; i < lives; i++) {
		draw_sprite(s_lives, 0, xx + (i*gap), yy);
	}
}

// score
xx = gw / 2;
yy = 11;
draw_sprite(s_score, 0, xx, yy);
draw_set_halign(fa_right);
text_xx = 54;
text_yy = 14;
// draw shadow
draw_set_color(c_black);
draw_text(xx + text_xx + 1, yy + text_yy + 1, score);
// draw text
draw_set_color(color);
draw_text(xx + text_xx, yy + text_yy, score);
