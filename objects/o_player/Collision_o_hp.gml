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
	}
}
