/// @description
// gems is other
with (other) {
	if (canPickup) {
		die = true;
		
		// player is other
		other.gems++;
		audio_play_sound(snd_pickup_gem, 5, false);
	}
}
