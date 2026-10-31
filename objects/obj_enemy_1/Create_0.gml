col = [obj_wall, obj_hiding_spot, obj_enemy_wall, obj_placeholder]
state = 0 // 0 = wandering, 1 = searching, 2 = chasing
pathqueue = []
pathpos = 0
frozen = false

spdp = [x, y]
bl = bbox_left
bt = bbox_top
br = bbox_right
bb = bbox_bottom
off = 3
limbs = [[bl, bt, 0], [br, bt, off * 1], [bl, bb, off * 2], [br, bb, off * 3]]
dir = 0
soff = 0

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
			var ran = irandom(20)
			if ran = 1 then VecE = find_location(col)
			var _paths = scr_path(Pos, VecE)
			switch_queue(_paths)
			break
		case 1:
			var ran = irandom(3)
			if ran = 1 then VecE = find_location(col, obj_player.cid)
			var _paths = scr_path(Pos, VecE)
			switch_queue(_paths)
			break
		case 2:
			VecE = obj_player.pos
			var _paths = scr_path(Pos, VecE)
			switch_queue(_paths)
			break
		case 3:
			var _meat = instance_nearest(x, y, obj_meat)
			VecE = new vec3(_meat.x, _meat.y, floor(_meat.y / FSH))
			var _paths = scr_path(Pos, VecE)
			switch_queue(_paths)
			break
	}
	path_start(pathqueue[0], random_range(2.75, 3.75), path_action_stop, false)
}

path()

alarm[0] = irandom_range(10, 30)


emitter = audio_emitter_create()
audio_falloff_set_model(audio_falloff_inverse_distance)