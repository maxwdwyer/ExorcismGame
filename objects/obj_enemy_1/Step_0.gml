if frozen = false
{
	Pos.x = x
	Pos.y = y
	Pos.z = floor(Pos.y / FSH)
	if path_follow(Pos, pathqueue) = 1 
	{
		//show_debug_message("jgdjasghdajhsgdads")
		var _addx = lengthdir_x(6.5 * 2, dir)
		var _addy = lengthdir_y(6.5 * 2, dir)
		limbs[0] = [bl + _addx, bt + _addy, off * 4]
		limbs[1] = [br + _addx, bt + _addy, off * 4]
		limbs[2] = [bl + _addx, bb + _addy, off * 4]
		limbs[3] = [br + _addx, bb + _addy, off * 4]
	}

	cid = scr_cid(Pos)


	if collision_line(x, y, obj_player.x, obj_player.y, col, false, false) = noone{
		alarm[1] = 480
		state = 2
	}
	else if state != 0 then state = 1

	if instance_exists(obj_meat){
		if collision_line(x, y, obj_player.x, obj_player.y, col, false, false) = noone{
			state = 3
		}
	}

	if instance_place(x, y, obj_doorway){
		var _door = instance_place(x, y, obj_doorway)
		if _door.open = 0 then scr_opendoor(x, y)
	}

	if collision_point(x, y, obj_enemy_wall, true, false) != noone{
		var _other = instance_place(x, y, obj_enemy_wall)
		path_end()
		move_towards_point(_other.x, _other.y, -1)
	}

	#region move from nearest
	
	#endregion

	//DRAWING-----------------------------------------------------------------------------------------------------

	var _lights = [[0, 0]]
	var _lp = [0, 0] // light point

	for (var _i = 0; _i < instance_number(obj_light); _i += 1){
		var _tlb = instance_find(obj_light, _i)
		if _tlb.cid = cid then array_push(_lights, [_tlb.x, _tlb.y])
	}

	var _len = array_length(_lights)
	if _len > 1 {
		for (var _i = 0; _i < _len; _i += 1){
			_lp[0] += _lights[_i, 0]
			_lp[1] += _lights[_i, 1]
		}
		_lp[0] = _lp[0] / _len
		_lp[1] = _lp[1] / _len
	}
	else _lp = _lights[0]

	var _sdir = point_direction(x, y, _lp[0], _lp[1])//shadow direction
	var _sdist = point_direction(x, y, _lp[0], _lp[1]) / 15 //shadow distance
	var _xso = lengthdir_x(_sdist, _sdir + 180)
	var _yso = lengthdir_y(_sdist, _sdir + 180)
	soff = [_xso, _yso]

	bl = -24 + x
	bt = -24 + y
	br = 24 + x
	bb = 24 + y
	var _spd = point_distance(x, y, spdp[0], spdp[1])
	if _spd != 0 then dir = point_direction(x, y, spdp[0], spdp[1]) + 180

	var _addx = lengthdir_x(6.5 * 2, dir)
	var _addy = lengthdir_y(6.5 * 2, dir)
	for (var _i = 0; _i < array_length(limbs); _i += 1){
		limbs[_i, 2] -= 1
		if limbs[_i, 2] < 0{
			if _i = 0 then limbs[0] = [bl + _addx, bt + _addy, off * 4]
			if _i = 1 then limbs[1] = [br + _addx, bt + _addy, off * 4]
			if _i = 2 then limbs[2] = [bl + _addx, bb + _addy, off * 4]
			if _i = 3 then limbs[3] = [br + _addx, bb + _addy, off * 4]
		}
	}

	spdp = [x, y]
}
else
{
	path_end()
}

audio_emitter_position(emitter, x, y, obj_player.depth)