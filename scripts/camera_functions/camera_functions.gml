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

/// @func	on_screen(_buffer);
/// @desc Is the object on the screen
/// @param {Object} _buffer Padding buffer of the camera
function on_screen(_buffer) {
	var left = global.cx - _buffer;
	var right = global.cx + global.cw + _buffer;
	var top = global.cy - _buffer;
	var bottom = global.cy + global.ch + _buffer;

	return (x > left && x < right && y > top && y < bottom);
}

/// @func fade_to_room(_target_room, _target_x, _target_y, _facing, _color)
/// @desc Fades to another room
/// @param _target_room
/// @param _target_x
/// @param _target_y
/// @param _facing
/// @param _color
function fade_to_room(_target_room, _target_x, _target_y, _facing, _color) {
	var _fade = instance_create_layer(x, y, "Fade", o_fade);
	with (_fade) {
		target_rm = _target_room;
		target_x = _target_x;
		target_y = _target_y;
		facing = _facing;
		col = _color;
	}
}
