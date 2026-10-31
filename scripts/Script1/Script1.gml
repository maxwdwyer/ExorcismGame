global.room_ids = 0 
global.ready = false
global.cols = [obj_wall, obj_doorway, obj_hiding_spot, obj_placeholder, obj_box]

function scr_start(){
	var _multi = 8
	global.grid = mp_grid_create(-32, -32, (room_width / _multi + 64/_multi) / 2, (room_height / _multi + 64/_multi), _multi, _multi)
	//mp_grid_add_instances(global.grid, obj_wall, true)
	mp_grid_add_instances(global.grid, obj_enemy_wall, true)
	mp_grid_add_instances(global.grid, obj_hiding_spot, true)
}


function scr_getroomsize(_id, z){
	var _roomobjs = [] // rooms to check
	var _fillspace = []
	var _fillspace2 = []
	var _viewport = [1_000_000, 1_000_000, -10_000, -10_000] // x1, y1, x2, y2
	for (var _i = 0; _i < instance_number(obj_floor); _i += 1){
		var _inst = instance_find(obj_floor, _i)
		if _inst.cid = _id then array_push(_roomobjs, _inst)} // checks if id is same as input id, if so adds to array
	for (var _i = 0; _i < array_length(_roomobjs); _i += 1){
		var _inst = _roomobjs[_i]
		var _x2 = _inst.bbox_right
		var _y2 = _inst.bbox_bottom
		if _x2 > _viewport[2] then _viewport[2] = _x2
		if _y2 > _viewport[3] then _viewport[3] = _y2
		if _inst.bbox_left < _viewport[0] then _viewport[0] = _inst.bbox_left
		if _inst.bbox_top < _viewport[1] then _viewport[1] = _inst.bbox_top
	}
	array_push(_fillspace2, [0, 0, _viewport[0] - 16, room_height])
	array_push(_fillspace2, [room_width, 0, _viewport[2] + 16, room_height])
	array_push(_fillspace2, [0, 0, room_width, _viewport[1] - 24])
	array_push(_fillspace2, [0, room_height, room_width, _viewport[3] + 0])
	for (var _i = 0; _i < array_length(_roomobjs); _i += 1){
		var _inst = _roomobjs[_i]
		if _inst.bbox_left > _viewport[0] then array_push(_fillspace2, [0, 0, _inst.bbox_left - 16, _inst.bbox_bottom - 24])
		if _inst.bbox_right > _viewport[0] then array_push(_fillspace2, [room_width, 0, _inst.bbox_right + 16, _inst.bbox_bottom - 24]) // REMEMBER TO MAKE THIS BUT FOR THE BOTTOM OF ROOMS TOO
	}
	return [_viewport, _fillspace2]
}



function scr_light(_x, _y){
	for (var _i = 0; _i < 360; _i += 4.5){
		var _e = scr_lightbeam(_x, _y, _i)
	}
}

function scr_lightbeam(_x1, _y1, _a){
	draw_set_color(c_white)
	draw_set_alpha(.65)
	var _x2 = lengthdir_x(12.5, _a)
	var _y2 = lengthdir_y(12.5, _a)
	for (var _i = 0; _i < 72; _i += 1){
		var _pos = [_x1 + (_x2 * _i),  _y1 + (_y2 * _i)]
		if instance_place(_pos[0], _pos[1], global.cols){
			draw_line_width(_x1, _y1, _pos[0], _pos[1], _i / 1.5)
			break
		}
		if _i = 69 then draw_line_width(_x1, _y1, _pos[0], _pos[1], _i / 1.5)
	}
	draw_set_color(c_white)
	draw_set_alpha(1)
}



function scr_opendoor(_x, _y){
	var _door = instance_nearest(_x, _y, obj_doorway)
	if point_distance(_x, _y, _door.x, _door.y) < 125
	{
		if _door.locked != 0
		{
			
		}
		else
		{
			var _o = _door.open
			var _dx = _x - _door.x 
			var _dy = _y - _door.y
			if _o = 1 or _o = -1 then _door.open = 0
			else{
				if _dy < _dx and _door.x > _x then _door.open = 1
				else if _dy < _dx and _door.x < _x then _door.open = -1
				else if _dy > _dx and _door.y < _y then _door.open = 1
				else if _dy > _dx and _door.y > _y then _door.open = -1
			}
		}
	}
}

function scr_lightswitch(_x, _y, _cid, _obj)
{
	var _ls = 0
	for (var _i = 0; _i < instance_number(obj_lightswitch); _i += 1){
		var _tls = instance_find(obj_lightswitch, _i)
		if _tls.cid = _cid then _ls = _tls
	}
	var _dist = 10000
	if _obj = obj_player then _dist = 125
	if point_distance(_x, _y, _ls.x, _ls.y) < _dist
	{
		if _ls.on = false
		{
			_ls.on = true
			for (var _i = 0; _i < instance_number(obj_light); _i += 1){
				var _tlb = instance_find(obj_light, _i)
				if _tlb.cid = _ls.cid then _tlb.on = true
				audio_play_sound(lightswitch, 2, false)
			} 
		}
		else if _ls.on = true
		{
			_ls.on = false
			for (var _i = 0; _i < instance_number(obj_light); _i += 1){
				var _tlb = instance_find(obj_light, _i)
				if _tlb.cid = _ls.cid then _tlb.on = false
				audio_play_sound(lightswitch, 2, false)
			}
		}
	}
}

function scr_path_smooth(_path, _pts, _spd, _col){
	var _start = [path_get_point_x(_path, 1), path_get_point_y(_path, 1)]
	var _path2 = path_add()
	var _len = path_get_number(_path)
	for (var _i = 1; _i < _len; _i += 1){
		if _i mod(2) = 0 then path_delete_point(_path, _i)
	}
	for (var _i = 1; _i < _len; _i += 1){
		var _x1 = path_get_point_x(_path, _i - 1)
		var _y1 = path_get_point_y(_path, _i - 1)
		var _x2 = path_get_point_x(_path, _i)
		var _y2 = path_get_point_y(_path, _i)
		var _dir = point_direction(_x1, _y1, _x2, _y2)
		var _dist = point_distance(_x1, _y1, _x2, _y2) / _pts
		path_add_point(_path2, _x1, _y1, 1)
		for (var _q = 1; _q < _pts; _q += 1){
			var _x3 = lengthdir_x(_dist * _q, _dir) + _x1
			var _y3 = lengthdir_y(_dist * _q, _dir) + _y1
			path_add_point(_path2, _x3, _y3, 1)
		}
	}
	var _len2 = path_get_number(_path2)
	var _path3 = path_add()
	var _xsp = lengthdir_x(_spd / 2, dir)
	var _ysp = lengthdir_y(_spd / 2, dir)
	path_add_point(_path3, _xsp + x, _ysp + y, _spd)
	for (var _i = 1; _i < _len2 - 1; _i += 1){
		var _x1 = path_get_point_x(_path2, _i - 1)
		var _y1 = path_get_point_y(_path2, _i - 1)
		var _x2 = path_get_point_x(_path2, _i + 1)
		var _y2 = path_get_point_y(_path2, _i + 1)
		var _mp = [((_x2 - _x1) / 2) + _x1, ((_y2 - _y1) / 2) + _y1]
		var _x3 = path_get_point_x(_path2, _i + 1)
		var _y3 = path_get_point_y(_path2, _i + 1)
		var _mp2 = [((_x3 - _mp[0]) / 2) + _mp[0], ((_y3 - _mp[1]) / 2) + _mp[1]]
		if _col = true then _mp2 = scr_move_point(_mp2, [obj_enemy_wall, obj_window])
		path_add_point(_path3, _mp2[0], _mp2[1], _spd)
	}
	return _path3
}

function scr_move_point(_xy, _col){ // _xy = [x, y]
	var _np = [_xy[0], _xy[1]]
	if instance_place(_np[0], _np[1], obj_enemy_wall)
	{
		var _other = instance_place(_np[0], _np[1], obj_enemy_wall)
		var _mode = 0
		var _min = 100000
		
		if _np[0] - _other.bbox_left < _min{
			_min = _np[0] - _other.bbox_left
			_mode = 0
		}
		if _other.bbox_right - _np[0] < _min{
			_min = _other.bbox_right - _np[0]
			_mode = 1
		}
		if _np[1] - _other.bbox_top < _min{
			_min = _np[1] - _other.bbox_top
			_mode = 2
		}
		if _other.bbox_bottom - _np[1] < _min{
			_min = _other.bbox_bottom - _np[1]
			_mode = 3
		}
		
		var _off = 32
		if _mode = 0 then _np[0] = _other.bbox_left - _off
		if _mode = 1 then _np[0] = _other.bbox_right + _off
		if _mode = 2 then _np[1] = _other.bbox_top - _off
		if _mode = 3 then _np[1] = _other.bbox_bottom + _off
	}
	return _np
}

function restart(){
	global.room_ids = 0
	global.ready = false
	global.cols = [obj_wall, obj_doorway, obj_hiding_spot, obj_placeholder]
	global.col = [obj_wall, obj_hiding_spot, obj_doorway, obj_placeholder]
	global.stairnum = 0
	global.itemcount = 0
	global.items = []
	global.stairs = []
	game_restart()
}

function mvroom(_room){
	global.room_ids = 0
	//global.ready = false
	global.cols = [obj_wall, obj_doorway, obj_hiding_spot, obj_placeholder]
	global.col = [obj_wall, obj_hiding_spot, obj_doorway, obj_placeholder]
	global.stairnum = 0
	global.itemcount = 0
	global.items = []
	global.stairs = []
	room_goto(_room)
}