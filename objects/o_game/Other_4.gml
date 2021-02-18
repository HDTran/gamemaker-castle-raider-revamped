// set collisions layer
global.map = layer_tilemap_get_id("Collisions");

// player create
if (room != rm_init && room != rm_menu && (!instance_exists(o_player))) {
	instance_create_layer(x, y, "Player", o_player);
}

// play music
if (room == rm_game_end) {
	// stop game music
	audio_stop_sound(snd_mus_middle_park);
	
	// play end game music
	audio_play_sound(snd_mus_game_end, 10, false);
} else {
	// play normal game music
	if (!audio_is_playing(snd_mus_middle_park)) {
		audio_play_sound(snd_mus_middle_park, 20, true);
	}
}