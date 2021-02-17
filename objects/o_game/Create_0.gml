/// @description Init values
// tiles
// get tilemap
global.tileSize = 32;
global.gravity = 0.25;

// set gui size
display_set_gui_size(720, 360);

// how many sparks come off gems
gem_sparks = 6;

// how many sparks come off dead enemies
enemy_sparks = 6;

// gameover
// game over and we lost
game_over_lose = false;

// game over and we won
game_over_won = false;

// main menu
current_frame = 0;

// fade in menu
fade_in = true;
alpha = 1;
fade_spd = 0.02;