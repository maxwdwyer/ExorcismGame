#macro FSW 2176
#macro FSH 1368
global.stairs = []

#region vector set up
	function vec2(_x, _y) constructor{
		x = _x;
		y = _y;
	}

	function vec3(_x, _y, _z) constructor{
		x = _x;
		y = _y;
		z = _z;
	}

	function distance(_vec1, _vec2){
		return point_distance(_vec1.x, _vec1.y, _vec2.x, _vec2.y)
	}

	function Vdir(_vec1, _vec2){
		return point_direction(_vec1.x, _vec1.y, _vec2.x, _vec2.y)
	}

	function lengthdir_vec(_dist, _dir){
		var _x = lengthdir_x(_dist, _dir)
		var _y = lengthdir_y(_dist, _dir)
		return new vec2(_x, _y)
	}
	
	function VA(_vec1, _vec2){
		var _vec3 = 0
			if struct_get(_vec1, "z") != undefined and struct_get(_vec2, "z") != undefined
			{
				var _x = _vec1.x + _vec2.x
				var _y = _vec1.y + _vec2.y
				var _z = _vec1.z + _vec2.z
				_vec3 = new vec3(_x, _y, _z)
			}
			else if struct_get(_vec1, "z") != undefined or struct_get(_vec2, "z") != undefined
			{
				var _x = _vec1.x + _vec2.x
				var _y = _vec1.y + _vec2.y
				_vec3 = new vec2(_x, _y)
			}
			else if struct_get(_vec1, "z") = undefined
			{
				var _x = _vec1.x + _vec2.x
				var _y = _vec1.y + _vec2.y
				_vec3 = new vec2(_x, _y)
			}
		return _vec3
	}
	
	function VE(_vec1, _vec2){
		var _true = true
			if struct_get(_vec1, "z") != undefined and struct_get(_vec2, "z") != undefined
			{
				if _vec1.x != _vec2.x then _true = false
				if _vec1.y != _vec2.y then _true = false
				if _vec1.z != _vec2.z then _true = false
			}
			else if struct_get(_vec1, "z") != undefined or struct_get(_vec2, "z") != undefined
			{
				if _vec1.x != _vec2.x then _true = false
				if _vec1.y != _vec2.y then _true = false
			}
			else if struct_get(_vec1, "z") = undefined
			{
				if _vec1.x != _vec2.x then _true = false
				if _vec1.y != _vec2.y then _true = false
			}
		return _true
	}
		
	function DLV(_vec1, _vec2, _w){
		draw_line_width(_vec1.x, _vec1.y, _vec2.x, _vec2.y, _w)
	}
#endregion
#region misc set up
	function VecCreate(){
		var _z = floor(y / FSH)
		return new vec3(x, y, _z)
	}
	
	function scr_cid(VecP){
		if instance_place(VecP.x, VecP.y, obj_floor){
			return instance_place(VecP.x, VecP.y, obj_floor).cid}
		else return -1
	}
	
	function scr_MP(_start, _end, path){ // vec3
		var _path = []
	
		if _end.z != _start.z {
			var _place = 0
			if _start.z = 0 and _end.z = 1{
				array_push(_path, [new vec2(x, y), new vec2(global.stairs[3].x, global.stairs[3].y)])
				array_push(_path, [new vec2(global.stairs[1].x, global.stairs[1].y), new vec2(_end.x, _end.y)]) // 3
				_place = 0
				//draw_line_width(x, y, global.stairs[3].x, global.stairs[3].y, 5)
				//draw_line_width(global.stairs[1].x, global.stairs[1].y, _end.x, _end.y, 5)
			}
			if _start.z = 2 and _end.z = 1{
				array_push(_path, [new vec2(x, y), new vec2(global.stairs[0].x, global.stairs[0].y)])
				array_push(_path, [new vec2(global.stairs[1].x, global.stairs[1].y), new vec2(_end.x, _end.y)]) // 0
				_place = 1
				//draw_line_width(x, y, global.stairs[0].x, global.stairs[0].y, 5)
				//draw_line_width(global.stairs[1].x, global.stairs[1].y, _end.x, _end.y, 5)
			}
			if _start.z = 2 and _end.z = 0 {
				array_push(_path, [new vec2(x, y), new vec2(global.stairs[0].x, global.stairs[0].y)])
				array_push(_path, [new vec2(global.stairs[1].x, global.stairs[1].y), new vec2(global.stairs[2].x, global.stairs[2].y)]) // 1
				array_push(_path, [new vec2(global.stairs[3].x, global.stairs[3].y), new vec2(_end.x, _end.y)])
				_place = 2
			}
			if _start.z = 0 and _end.z = 2{
				array_push(_path, [new vec2(x, y), new vec2(global.stairs[3].x, global.stairs[3].y)])
				array_push(_path, [new vec2(global.stairs[1].x, global.stairs[1].y), new vec2(global.stairs[2].x, global.stairs[2].y)]) // 0
				array_push(_path, [new vec2(global.stairs[0].x, global.stairs[0].y), new vec2(_end.x, _end.y)])
				_place = 3
			}
			if _start.z = 1 and _end.z = 0{
				array_push(_path, [new vec2(x, y), new vec2(global.stairs[1].x, global.stairs[1].y)])
				array_push(_path, [new vec2(global.stairs[3].x, global.stairs[3].y), new vec2(_end.x, _end.y)]) // 1
				_place = 4
			}
		}
		
		if _start.z = _end.z then array_push(_path, [_start, _end])
		var _endpath = []
		
		for (var _i = 0; _i < array_length(_path); _i += 1){
			var _sx = _path[_i, 0].x
			var _sy = _path[_i, 0].y
			var _ex = _path[_i, 1].x
			var _ey = _path[_i, 1].y
			mp_grid_path(global.grid, path, _sx, _sy, _ex, _ey, true)
			for (var _q = 0; _q < path_get_number(path); _q += 1){
				var _px = path_get_point_x(path, _q)
				var _py = path_get_point_y(path, _q)
				array_push(_endpath, new vec2(_px, _py))
			}
		}
		return _endpath
	}

	function scr_draw_connection(_start, _end){
		if _end.z != _start.z {
			var _place = 0
			if _start.z = 0 and _end.z = 1{
				//array_push(_path, [new vec2(x, y), new vec2(global.stairs[3].x, global.stairs[3].y)])
				//array_push(_path, [new vec2(global.stairs[1].x, global.stairs[1].y), new vec2(_end.x, _end.y)]) // 3
				_place = 0
				draw_line_width(x, y, global.stairs[3].x, global.stairs[3].y, 5)
				draw_line_width(global.stairs[1].x, global.stairs[1].y, _end.x, _end.y, 5)
			}
			if _start.z = 2 and _end.z = 1{
				//array_push(_path, [new vec2(x, y), new vec2(global.stairs[0].x, global.stairs[0].y)])
				//array_push(_path, [new vec2(global.stairs[1].x, global.stairs[1].y), new vec2(_end.x, _end.y)]) // 0
				_place = 1
				draw_line_width(x, y, global.stairs[0].x, global.stairs[0].y, 5)
				draw_line_width(global.stairs[1].x, global.stairs[1].y, _end.x, _end.y, 5)
			}
			if _start.z = 2 and _end.z = 0 {
				//array_push(_path, [new vec2(x, y), new vec2(global.stairs[0].x, global.stairs[0].y)])
				//array_push(_path, [new vec2(global.stairs[1].x, global.stairs[1].y), new vec2(global.stairs[2].x, global.stairs[2].y)]) // 1
				//array_push(_path, [new vec2(global.stairs[3].x, global.stairs[3].y), new vec2(_end.x, _end.y)])
				_place = 2
				draw_line_width(x, y, global.stairs[0].x, global.stairs[0].y, 5)
				draw_line_width(global.stairs[1].x, global.stairs[1].y, global.stairs[2].x, global.stairs[2].y, 5)
				draw_line_width(global.stairs[3].x, global.stairs[3].y, _end.x, _end.y, 5)
			}
			if _start.z = 0 and _end.z = 2{
				//array_push(_path, [new vec2(x, y), new vec2(global.stairs[3].x, global.stairs[3].y)])
				//array_push(_path, [new vec2(global.stairs[1].x, global.stairs[1].y), new vec2(global.stairs[2].x, global.stairs[2].y)]) // 0
				//array_push(_path, [new vec2(global.stairs[0].x, global.stairs[0].y), new vec2(_end.x, _end.y)])
				_place = 3
				draw_line_width(x, y, global.stairs[3].x, global.stairs[3].y, 5)
				draw_line_width(global.stairs[2].x, global.stairs[2].y, global.stairs[1].x, global.stairs[1].y, 5)
				draw_line_width(global.stairs[0].x, global.stairs[0].y, _end.x, _end.y, 5)
			}
			if _start.z = 1 and _end.z = 0{
				//array_push(_path, [new vec2(x, y), new vec2(global.stairs[1].x, global.stairs[1].y)])
				//array_push(_path, [new vec2(global.stairs[3].x, global.stairs[3].y), new vec2(_end.x, _end.y)]) // 1
				_place = 4
				draw_line_width(x, y, global.stairs[1].x, global.stairs[1].y, 5)
				draw_line_width(global.stairs[3].x, global.stairs[3].y, _end.x, _end.y, 5)
			}
		}
	}
	
	function scr_cdraw_path(_path){
		for (var _i = 1; _i < array_length(_path); _i += 1){
			if !is_struct(_path[_i]) and (_i + 2) < array_length(_path) then _i += 2
			if !is_struct(_path[_i]) and (_i + 2) > array_length(_path) then break
			draw_line_width(_path[_i - 1].x, _path[_i - 1].y, _path[_i].x, _path[_i].y, 5)
		}
	}

#endregion