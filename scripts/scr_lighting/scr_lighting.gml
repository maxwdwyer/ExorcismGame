global.col = [obj_wall, obj_hiding_spot, obj_doorway, obj_placeholder]
global.stairnum = 0

function scr_calc_lights(){
	var _corners = []
	var _off = - 1
	var _precis = 1
	var _room_width = 2176
	var _room_height = 1376
	
	array_push(_corners, [0, 0])
	array_push(_corners, [0, _room_height])
	array_push(_corners, [_room_width, 0])
	array_push(_corners, [_room_width, _room_height])
	
	for (var _i = 0; _i < _precis; _i += 1){
		var _x = _room_width / _precis
		array_push(_corners, [_x * _i, 0])
		array_push(_corners, [_x * _i, _room_height])
	}
	for (var _i = 0; _i < _precis; _i += 1){
		var _y = _room_height / _precis
		array_push(_corners, [0, _y * _i])
		array_push(_corners, [_room_width, _y * _i])
	}
	/*for (var _i = 0; _i < 30; _i += 1){
		var _x = lengthdir_x(1200, (360 / 30) * _i)
		var _y = lengthdir_y(1200, (360 / 30) * _i)
		array_push(_corners, [_x, _y])
	}*/
	for (var _i = 0; _i < array_length(global.col); _i += 1){
		for (var _q = 0; _q < instance_number(global.col[_i]); _q += 1){
			var _inst = instance_find(global.col[_i], _q)
			if point_distance(x, y, _inst.x, _inst.y) < 900
			{
				if _inst.image_angle mod(90) = 0 {
					array_push(_corners, [_inst.bbox_left - _off, _inst.bbox_bottom + _off])
					array_push(_corners, [_inst.bbox_left - _off, _inst.bbox_top - _off])
					array_push(_corners, [_inst.bbox_right + _off, _inst.bbox_bottom + _off])
					array_push(_corners, [_inst.bbox_right + _off, _inst.bbox_top - _off])
				}
				else
				{
					var _spr = _inst.sprite_index
					var _x = (sprite_get_width(_spr) / 2 * _inst.image_xscale) + _off
					var _y = (sprite_get_height(_spr) / 2 * _inst.image_yscale) + _off
					var _dir = degtorad(-_inst.image_angle)
					var _x2 = _x * cos(_dir) + _y * sin(_dir)
					var _y2 = _x * sin(_dir) - _y * cos(_dir)
					var _x3 = _x * cos(_dir) - _y * sin(_dir)
					var _y3 = _x * sin(_dir) + _y * cos(_dir)
					array_push(_corners, [_x2 + _inst.x, _y2 + _inst.y])
					array_push(_corners, [-_x2 + _inst.x, -_y2 + _inst.y])
					array_push(_corners, [_x3 + _inst.x, _y3 + _inst.y])
					array_push(_corners, [-_x3 + _inst.x, -_y3 + _inst.y])
				}
			}
		}
	}
	for (var _i = 0; _i < array_length(_corners); _i += 1){
		_corners[_i] = scr_lines_ip(_corners[_i])
	}
	//ORDERING ----------------------------
	for (var _i = 0; _i < array_length(_corners); _i += 1){
		_corners[_i] = [_corners[_i, 0], _corners[_i, 1], point_direction(x, y, _corners[_i, 0], _corners[_i, 1])]
	}
	var _ord = _corners
	for (var _t = 0; _t < array_length(_ord) + 4; _t += 1){
		for (var _i = 0; _i < array_length(_ord) - 1; _i += 1){
			if _ord[_i, 2] > _ord[_i + 1, 2]{
				var _1 = _ord[_i]
				var _2 = _ord[_i + 1]
				_ord[_i] = _2
				_ord[_i + 1] = _1
			}
		}
	}
	return _ord
}

function scr_lines(_line){
	var _return = []
	var _dir = point_direction(x, y, _line[0], _line[1])
	var _x = lengthdir_x(1, _dir)
	var _y = lengthdir_y(1, _dir)
	
	var _start = 0
	var _end = 2400
	
	for (var _i = 0; _i < 17; _i += 1){
		var _mid = (_start + _end) / 2
		var _mx = _mid * _x + x
		var _my = _mid * _y + y
		if (collision_line(x, y, _mx, _my, global.col, true, false)) then _end = _mid else _start = _mid
	}
	
    var _fx = clamp(x + _x * _end, 0, room_width)
    var _fy = clamp(y + _y * _end, 0, room_height)
	_return[0] = _fx
	_return[1] = _fy
	draw_set_color(c_blue)
	draw_rectangle(_fx - 2, _fy - 2, _fx + 2, _fy + 2, false)
	draw_set_color(c_white)
	return _return
}



function scr_lines_ip(_line){
	var _dir = point_direction(x, y, _line[0], _line[1])
	var _x = lengthdir_x(2, _dir)
	var _y = lengthdir_y(2, _dir)
	var _pos = [x, y]
	do{
		_pos[0] += _x
		_pos[1] += _y
	} until instance_place(_pos[0], _pos[1], global.col) or _pos[0] < 0 or _pos[1] < 0 or _pos[0] > room_width or _pos[1] > room_height
	return _pos
}



function scr_lines_ray(_line){
	var _dir = point_direction(x, y, _line[0], _line[1])
	var _x = lengthdir_x(1.5, _dir)
	var _y = lengthdir_y(1.5, _dir)
	var _pos = [x, y]
	for (var _i = 0; _i < 250; _i += 1){
		_pos[0] += _x
		_pos[1] += _y
		if instance_place(_pos[0], _pos[1], global.col) then break
	}
	return _pos
}



function scr_draw_lights(_array, pos, _vp){
	_vp = [1_000_000, 1_000_000, 0, 0]
	for (var _i = 0; _i < array_length(_array); _i += 1){
		if _array[_i, 0] < _vp[0] then _vp[0] = _array[_i, 0]
		if _array[_i, 1] < _vp[1] then _vp[1] = _array[_i, 1]
		if _array[_i, 0] > _vp[2] then _vp[2] = _array[_i, 0]
		if _array[_i, 1] > _vp[3] then _vp[3] = _array[_i, 1]
	}
	
	var _surf = surface_create(_vp[2], _vp[3])
	surface_set_target(_surf)
	
	draw_set_alpha(1)
	shader_set(shd_lighting2)
	
	var _light = shader_get_uniform(shd_lighting2, "light")
	shader_set_uniform_f(_light, pos.x, pos.y - camera_get_view_y(view_camera[1]), on)
	draw_set_color(c_white)
	
	draw_primitive_begin(pr_trianglelist)
	var _len = array_length(_array)
	
	for (var _i = 0; _i < _len - 1; _i += 1){
		draw_vertex(_array[_i, 0], _array[_i, 1])
		draw_vertex(_array[_i + 1, 0], _array[_i + 1, 1])
		draw_vertex(pos.x, pos.y)
	}
	draw_vertex(_array[0, 0], _array[0, 1])
	draw_vertex(_array[_len - 1, 0], _array[_len - 1, 1])
	draw_vertex(pos.x, pos.y)
	
	draw_primitive_end()
	shader_reset()
	
	surface_reset_target()
	var _spr = sprite_create_from_surface(_surf, _vp[0], _vp[1], _vp[2] - _vp[0], _vp[3] - _vp[1], false, false, 0, 0)
	//var _spr = sprite_create_from_surface(_surf, 0, 0, _vp[2] - _vp[0], _vp[3] - _vp[1], false, false, _vp[0], _vp[1])
	surface_free(_surf)
	
	return _spr
}

function scr_calc_size(_array){
	var _vp = [1_000_000, 1_000_000, 0, 0]
	for (var _i = 0; _i < array_length(_array); _i += 1){
		if _array[_i, 0] < _vp[0] then _vp[0] = _array[_i, 0]
		if _array[_i, 1] < _vp[1] then _vp[1] = _array[_i, 1]
		if _array[_i, 0] > _vp[2] then _vp[2] = _array[_i, 0]
		if _array[_i, 1] > _vp[3] then _vp[3] = _array[_i, 1]
	}
	
	//_vp[1] = camera_get_view_y(view_camera[0])
	//_vp[3] = camera_get_view_y(view_camera[0] + 1440)
	return _vp
}

function scr_hiding_shadow(_other, _num){
	var _dir = _other.image_angle
	var _points = []
	var _z = floor(_other.y / FSH)
	array_push(_points, [0, _z * FSH])
	array_push(_points, [2176, _z * FSH])
	array_push(_points, [0, _z * FSH + 1376])
	array_push(_points, [2176, _z * FSH + 1376])
	
	if _num = 0 then draw_set_alpha(.1)
	if _num = 1 then draw_set_alpha(.2)
	if _num = 2 then draw_set_alpha(.3)
	if _num = 3 then draw_set_alpha(.4)
	if _num = 4 then draw_set_alpha(.5)
	if _num = 5 then draw_set_alpha(.6)
	if _num = 6 then draw_set_alpha(1)
	var _ang = 13 + 1.5 * _num
	
	var _off = 90
	var _x1 = x + lengthdir_x(2500, _dir + _ang + _off)
	var _y1 = y + lengthdir_y(2500, _dir + _ang + _off)
	var _x2 = x + lengthdir_x(2500, _dir - _ang + _off)
	var _y2 = y + lengthdir_y(2500, _dir - _ang + _off)
	var _x3 = x + lengthdir_x(.5, _dir + _off)
	var _y3 = y + lengthdir_y(.5, _dir + _off)
	
	array_push(_points, [_x1, _y1])
	array_push(_points, [_x2, _y2])
	array_push(_points, [_x3, _y3])
	
	for (var _i = 0; _i < array_length(_points); _i += 1){
		_points[_i] = [_points[_i, 0], _points[_i, 1], point_direction(x, y, _points[_i, 0], _points[_i, 1])]
	}
	
	var _ord = _points
	for (var _t = 0; _t < array_length(_ord) + 4; _t += 1){
		for (var _i = 0; _i < array_length(_ord) - 1; _i += 1){
			if _ord[_i, 2] > _ord[_i + 1, 2]{
				var _1 = _ord[_i]
				var _2 = _ord[_i + 1]
				_ord[_i] = _2
				_ord[_i + 1] = _1
			}
		}
	}
	
	draw_primitive_begin(pr_trianglelist)
	draw_set_color(c_black)
	var _len = array_length(_ord)
	
	for (var _i = 0; _i < _len - 1; _i += 1){
		draw_vertex(_ord[_i, 0], _ord[_i, 1])
		draw_vertex(_ord[_i + 1, 0], _ord[_i + 1, 1])
		draw_vertex(x, y)
	}

	draw_vertex(_ord[0, 0], _ord[0, 1])
	draw_vertex(_ord[_len - 1, 0], _ord[_len - 1, 1])
	draw_vertex(x, y)
	
	draw_primitive_end()
	
	draw_set_color(c_white)
}