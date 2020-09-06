/// @description 720 x 360
// gems
draw_set_font(fnt_stats);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var color = make_color_rgb(173, 144, 159);
draw_set_color(color);

// set draw location
var xStart = display_get_gui_width() - 92; // right hand side
var yStart = 2;
draw_sprite(s_gem_gui, 0, xStart, yStart);

// text
var textX = 7;
var textY = 22;
draw_set_color(c_black);
draw_text(xStart + textX + 1, yStart + textY + 1, o_player.gems);
draw_set_color(color);
draw_text(xStart + textX, yStart + textY, o_player.gems);
