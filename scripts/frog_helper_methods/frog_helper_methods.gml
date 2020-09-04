function breathing() {
	if (breathTimer < 0) {
		image_speed = 1; // start breath animation
	} else {
		breathTimer--;
	}

	// stop breathing at the end of the animation
	if (image_index >= image_number - sprite_get_speed(sprite_index)/room_speed) {
		breathTimer = breathTimerInitial;

		// pause at first frame
		image_index = 0;
		image_speed = 0;
	}
}

function frog_anim() {
	image_xscale = facing; // reface, 1 is normal scale and -1 is flipped
	sprite_index = sprites[state];
	//mask_index = masks[state];
	
	//switch (state) {
	//	case PLAYER_STATES.JUMP:
	//		image_index = movement.verticalSpeed < 0 ? 0 : 1;
	//	break;
	//}
}