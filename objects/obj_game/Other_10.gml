var _total = 0
var _enemytype = obj_enemy_5
for (var _i = 0; _i < array_length(el); _i += 1){
	_total += el[_i, 1]}
	//show_debug_message(_total)
var _ran = irandom(_total)
//show_debug_message(_ran)
var _last = 0
//show_debug_message(el)
for (var _i = 0; _i < array_length(el); _i += 1){
	if _ran > _last and _ran < el[_i, 1]{
		_enemytype = el[_i, 0]
		//show_debug_message([_enemytype, el])
		break
	}
	_last = el[_i, 1]
}

var _num = irandom(instance_number(obj_floor) - 1)
var VecP = find_location(global.col, _num)
//if _targetrm.cid = obj_player.cid {
//	instance_find(obj_floor, _num )
	//if _num + 2 < instance_number(obj_floor) - 1 then _num += 2 else _num -= 2
	//_targetrm = instance_find(obj_floor, _num)
//}
if _enemytype != obj_enemy_2 and _enemytype != obj_enemy_3{
	var _enemy = instance_create_layer(VecP.x, VecP.y, "enemies", _enemytype)
}
else if _enemytype == obj_enemy_3{
	var _enemy = instance_create_layer(1600, 960, "enemies", _enemytype)
}
else
{
	var _enemy = instance_create_layer(VecP.x, VecP.y, "enemy2", _enemytype)
}
var _life = 3 // enemy life in hours
if _enemytype = obj_enemy_2 then _life = 5.5
if _enemytype = obj_enemy_3 then _life = .9
if _enemytype = obj_enemy_5 then _life = 4.6
array_push(e, [_enemy, hourlen * _life])