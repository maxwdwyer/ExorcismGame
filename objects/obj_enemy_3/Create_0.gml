col = [obj_wall, obj_hiding_spot, obj_enemy_wall, obj_placeholder]
state = 0 // 0 = outside, 1 = running, 2 = chasing
pathqueue = []
pathpos = 0
win = []
traila = [[x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y]]

randomize()

VecE = find_location(col)
Pos = VecCreate()
cid = scr_cid(Pos)

function switch_queue(paths){
	for (var i = 0; i < array_length(pathqueue); i ++){
		var _path = pathqueue[i]
		pathqueue[i] = 0
		path_delete(_path)
	}
	pathqueue = paths
}

function path(){
	switch(state){
		case 0:
			var _paths = [path_add()]
			path_add_point(_paths[0], 0, 0, 0)
			switch_queue(_paths)
			break
		case 1:
			var _num = instance_number(obj_e3_pos)
			if path_position < .95 or path_position > .99
			{
				win[0] = instance_find(obj_e3_pos, irandom_range(1, _num - 1))
				win[1] = instance_find(obj_e3_pos, irandom_range(1, _num - 1))
				do{
					win[1] = instance_find(obj_e3_pos, irandom_range(1, _num - 1))
				} until win[0] != win[1]
			}
			x = win[0].x
			y = win[0].y
			Pos.x = win[0].x
			Pos.y = win[0].y
			Pos.z = floor(win[0].y / FSH)
			traila = [[x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y], [x, y]]
			var _paths = scr_path(Pos, new vec3(win[1].x, win[1].y, floor(win[1].y / FSH)))
			switch_queue(_paths)
			break
		case 2:
			path_end()
			VecE = obj_player.pos
			var _paths = scr_path(Pos, VecE)
			switch_queue(_paths)
			break
	}
	path_start(pathqueue[0], random_range(12, 16), path_action_stop, false)
}

path()


function trail(_array, _dist){
	for (var _i = 1; _i < array_length(_array); _i += 1){
		if point_distance(_array[_i - 1, 0], _array[_i - 1, 1], _array[_i, 0], _array[_i, 1]) > _dist{
			var _dir = point_direction(_array[_i - 1, 0], _array[_i - 1, 1], _array[_i, 0], _array[_i, 1])
			var _x = lengthdir_x(_dist - 1, _dir)
			var _y = lengthdir_y(_dist - 1, _dir)
			var _grid = 2
			_array[_i, 0] = floor((_x + _array[_i - 1, 0]) / _grid) * _grid
			_array[_i, 1] = floor((_y + _array[_i - 1, 1]) / _grid) * _grid
		}
	}
}

alarm[0] = irandom_range(10, 30)
alarm[1] = irandom_range(150, 500)


emitter = audio_emitter_create()
audio_falloff_set_model(audio_falloff_inverse_distance)