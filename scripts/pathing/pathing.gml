function scr_path(Start, End){
	var bigPath = [Start, End]
	var paths = []
	var stairs = [new vec2(1728, 608), new vec2(1408, 2032), new vec2(1536, 1712), new vec2(1600, 3440)]
	if Start.z != End.z {
		var _casea = [Start.z, End.z]
		var _case = 0
		
		if _casea[0] = 0 and _casea[1] = 1 then _case = 0 // [0, 1]
		if _casea[0] = 1 and _casea[1] = 2 then _case = 1 // [1, 2]
		if _casea[0] = 0 and _casea[1] = 2 then _case = 2 // [0, 2]
		if _casea[0] = 1 and _casea[1] = 0 then _case = 3 // [1, 0]
		if _casea[0] = 2 and _casea[1] = 0 then _case = 4 // [2, 0]
		if _casea[0] = 2 and _casea[1] = 1 then _case = 5 // [2, 1]
		
		switch(_case){
			case 0: // [0, 1]
				array_insert(bigPath, 1, stairs[0], stairs[1])
				break
			case 1: // [1, 2]
				array_insert(bigPath, 1, stairs[2], stairs[3])
				break
			case 2: // [0, 2]
				array_insert(bigPath, 1, stairs[0], stairs[1], stairs[2], stairs[3])
				break
			case 3: // [1, 0]
				array_insert(bigPath, 1, stairs[1], stairs[0])
				break
			case 4: // [2, 0]
				array_insert(bigPath, 1, stairs[3], stairs[2], stairs[1], stairs[0])
				break
			case 5: // [2, 1]
				array_insert(bigPath, 1, stairs[3], stairs[2])
				break
		}
	}
	
	for (var i = 0; i < array_length(bigPath); i += 2){
		var tPath = path_add()
		mp_grid_path(global.grid, tPath, bigPath[i].x, bigPath[i].y, bigPath[i + 1].x, bigPath[i + 1].y, 1)
		array_push(paths, tPath)
	}
	return paths
}

function find_location(col, _rm = -1){
	var TPos = new vec2(0, 0)
	var _buf = 50
	var _floor = 0
	do {
		if _rm = -1{
			var _num = irandom(instance_number(obj_floor) - 1)
			_floor = instance_find(obj_floor, _num)}
		else{
			_floor = instance_find(obj_floor, _rm)}
		TPos.x = irandom_range(_floor.bbox_left +  _buf, _floor.bbox_right - _buf)
		TPos.y = irandom_range(_floor.bbox_top + _buf, _floor.bbox_bottom - _buf)
	} until !instance_place(TPos.x, TPos.y, col)
	return new vec3(TPos.x, TPos.y, floor(TPos.y / FSH))
}

function path_follow(Pos, pathqueue, spd = 1.75){
	var _pathpos = path_position
	var _end = path_get_number(pathqueue[0])
	var VecPE = new vec2(path_get_point_x(pathqueue[0], _end), path_get_point_y(pathqueue[0], _end))
	var _dist = distance(Pos, VecPE)
	var _e = 0
	if _pathpos > .985 or _dist < 24{
		if array_length(pathqueue) > 1
		{
			_e = 1
			var _path = pathqueue[0]
			array_delete(pathqueue, 0, 1)
			path_delete(_path)
		
			Pos.x = path_get_point_x(pathqueue[0], 0)
			Pos.y = path_get_point_y(pathqueue[0], 0)
		
			x = Pos.x
			y = Pos.y
			Pos.z = floor(Pos.y / FSH)
		
			_pathpos = 0
			_dist = 50
			//show_debug_message([array_length(pathqueue), pathqueue, instance_id_get(self)])
			path_start(pathqueue[0], random_range(spd - .5, spd + .5), path_action_stop, false)
		}
	}
	return _e
}