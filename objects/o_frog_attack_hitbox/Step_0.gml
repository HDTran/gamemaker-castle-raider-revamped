/// @description
// check with o_player because there is only one player object
with (instance_place(x, y, o_player)) {
	process_enemy_attack(5, 2.5);
}

// enable death at begin step
die = true;
