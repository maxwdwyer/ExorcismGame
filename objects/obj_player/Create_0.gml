scr_ready_items()
pos = VecCreate()
cid = 0//scr_cid(pos)
spd = 6
ready = false
collisions = [obj_wall, obj_window, obj_doorway, obj_placeholder, obj_hiding_spot, obj_box]
vp = 0
roomchange = 0
lockedstairs = [0, 0] // 0 = basement, 1 = attic
hidden = false
lhp = [0, 0] // last hiding position
hp = 5
saltlastpos = [mouse_x, mouse_y]
safeinteract = false

win = [0, 240]

testpath = path_add()
path = []

cd = [[0, 20], [0, 20], [0, 20], [0, 20], [0, 20], [0, 7], [0, 46], [16, 16], [45, 45, ""]]
camera_set_view_pos(view_camera[0], 0, pos.z * FSH)

potstate = [0, 0]
inv = [22, 0, 0]
sel = 1 // selected
notebookarray = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

function check_inventory(_num){
	var _has = false
	if inv[0] = _num then _has = true
	if inv[1] = _num then _has = true
	if inv[2] = _num then _has = true
	return _has
}

function find_near_item(){
	var _neari = [0, 100000]
	for (var i = 0; i < array_length(global.items); i ++){
		if instance_number(global.items[i, 0]) = 0 then continue
		var _itemt = instance_nearest(x, y, global.items[i, 0])
		var _dist = point_distance(x, y, _itemt.x, _itemt.y)
		if _dist < _neari[1]{
			_neari[0] = _itemt
			_neari[1] = _dist
		}
	}
	var _item = _neari[0]
	return _item
}

function find_near_shelf(){
	var _neari = [0, 100000]
	var _shelfs = [obj_shelf, obj_fridge, obj_safe, obj_box]
	for (var i = 0; i < array_length(_shelfs); i ++){
		if instance_number(_shelfs[i]) = 0 then continue
		var _shelft = instance_nearest(x, y, _shelfs[i])
		if _shelfs[i] = obj_safe and _shelft.open = false then continue
		if _shelfs[i] = obj_safe and _shelft.crosstaken = true then continue
		var _dist = point_distance(x, y, _shelft.x, _shelft.y)
		if _dist < _neari[1]{
			_neari[0] = _shelft
			_neari[1] = _dist
		}
	}
	var _shelf = _neari[0]
	return _shelf
}

function find_near_enemy(){
	var _neari = [0, 100000]
	var _enemies = [obj_enemy_1, obj_enemy_2, obj_enemy_3, obj_enemy_4, obj_enemy_5, obj_enemy_6]
	for (var i = 0; i < array_length(_enemies); i ++){
		if instance_number(_enemies[i]) = 0 then continue
		var _enemyt = instance_nearest(x, y, _enemies[i])
		var _dist = point_distance(x, y, _enemyt.x, _enemyt.y)
		if _dist < _neari[1]{
			_neari[0] = _enemyt
			_neari[1] = _dist
		}
	}
	var _enemy = _neari[0]
	return _enemy
}

audio_listener_orientation(0,0,1,0,-1,0)

_sound = 1