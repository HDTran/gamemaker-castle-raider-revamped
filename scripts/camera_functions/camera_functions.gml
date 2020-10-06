/// @func	scr_screen_shake(_time, _amount);
/// @desc Shake the screen for a specified amount of time and magnitude.
/// @param {int} _time Time to shake.
/// @param {int} _amount The amount to shake (default = -1).
function scr_screen_shake(_time, _amount) {
	with (o_camera) {
		// default
		if (_amount == -1) {
			_amount = screen_shake_amount_initial;
		}
		screen_shake = true;
		alarm[SCREEN_SHAKE_TIME] = room_speed * _time;
		screen_shake_amount = _amount;
	}
}
