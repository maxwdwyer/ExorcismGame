var _other = instance_place(x, y, obj_floor)
cid = _other.cid // PROBLEM IN BEDROOM
/*if instance_place(x, y, obj_enemy_wall) = true
{
	var _other2 = instance_place(x, y, obj_enemy_wall) else var _other2 = 0
if _other2 != 0{*/
	if is_array(target) then mp_grid_path(global.grid, path, x, y, target[0], target[1], false) else mp_grid_path(global.grid, path, x, y, target.x, target.y, true)
	//path = scr_path_smooth(path, 1, 3, false)
	path_start(path, spd, 3, 1)
//}

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

bl = -24 + x//bbox_left
bt = -24 + y//bbox_top
br = 24 + x//bbox_right
bb = 24 + y//bbox_bottom
//if point_distance(x, y, spdp[0], spdp[1]) == 0 move_towards_point(_other.x, _other.y, 3)
if point_distance(x, y, spdp[0], spdp[1]) == 0 then alarm[0] = 1

spdp = [x,y]

if cid = obj_player.cid and obj_player.hidden = false then target = obj_player
var _point = path_get_number(path) - 1
var _x = path_get_point_x(path, _point)
var _y = path_get_point_y(path, _point)
if x = _x and y = _y then alarm[0] = 1

if instance_place(x, y, obj_doorway){
	var _door = instance_place(x, y, obj_doorway)
	if _door.open = 0 then scr_opendoor(x, y)
}

var _addx = lengthdir_x(6.5 * spd, dir)
var _addy = lengthdir_y(6.5 * spd, dir)
for (var _i = 0; _i < array_length(limbs); _i += 1){
	limbs[_i, 2] -= 1
	if limbs[_i, 2] < 0{
		if _i = 0 then limbs[0] = [bl + _addx, bt + _addy, off * 4]
		if _i = 1 then limbs[1] = [br + _addx, bt + _addy, off * 4]
		if _i = 2 then limbs[2] = [bl + _addx, bb + _addy, off * 4]
		if _i = 3 then limbs[3] = [br + _addx, bb + _addy, off * 4]
	}
}