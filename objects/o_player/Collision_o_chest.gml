var isOnSameHeight = bbox_bottom == other.bbox_bottom;
if (input.action && !other.open && hp > 0 && isOnSameHeight) {
	with(other) {
		image_speed = 1;
		open = true;
		alarm[OPEN] = 1;
	}
	audio_play_sound(snd_open_chest, 50, false);
}
