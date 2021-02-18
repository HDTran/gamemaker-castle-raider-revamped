// hp is other
with (other) {
	if (canPickup) {
		die = true;
		
		// player is other
		with (other) {
			if (hp < maxHP) {
				hp++;
			}
		}
		audio_play_sound(snd_pickup_hp, 15, false);
	}
}
