//draw_self()
draw_set_alpha(1)
for (var _i = 1; _i < array_length(traila); _i += 1){
	draw_set_color(c_black)
	draw_body_seg(traila[_i], traila[_i - 1], _i)
	draw_set_color(c_white)
}

function draw_body_seg(_pos, _pos2, _i){
	draw_line_width(_pos[0], _pos[1], _pos2[0], _pos2[1], 31)
	draw_circle(_pos[0], _pos[1], 19, false)
	var _dir = point_direction(_pos[0], _pos[1], _pos2[0], _pos2[1]) + (21 * sin((current_time + _i * 27.5) / 45)) + 90
	var _len = 60
	var _det = 20
	
	var _x1 = lengthdir_x(_len, _dir) / _det
	var _y1 = lengthdir_y(_len, _dir) / _det
	var _x2 = lengthdir_x(_len, _dir + 180) / _det
	var _y2 = lengthdir_y(_len, _dir + 180) / _det
	draw_line_width(_x1, _y1, _x2, _y2, 5)
	
	var _dir2 = point_direction(_x1, _y1, _x2, _y2)
	var _x3 = lengthdir_x(_len / _det, _dir2)
	var _y3 = lengthdir_y(_len / _det, _dir2)

	var _last = [_x1 * _det + _pos[0], _y1 * _det + _pos[1]]
	for (var _q = 1; _q < _det * 2; _q += 1){
		var _w = clamp(11 - (point_distance(_pos[0], _pos[1], _last[0] + (_x3 / 2), _last[1] + (_y3 / 2)) / 5.25), .2, 11)
		draw_line_width(_last[0], _last[1], _last[0] + _x3, _last[1] + _y3, _w)
		_last[0] += _x3
		_last[1] += _y3
	}	
}
