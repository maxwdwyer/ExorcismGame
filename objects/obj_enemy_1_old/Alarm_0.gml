alarm[0] = irandom_range(200, 750)
var _num = irandom(instance_number(obj_floor) - 1)
if cid != obj_player.cid or obj_player.hidden = true
{
	targetrm = instance_find(obj_floor, _num)
	do{
	target = [irandom_range(targetrm.bbox_left, targetrm.bbox_right), irandom_range(targetrm.bbox_top, targetrm.bbox_bottom)]
	}until !place_meeting(target[0], target[1], obj_hiding_spot)
}
if is_array(target) then mp_grid_path(global.grid, path, x, y, target[0], target[1], false) else mp_grid_path(global.grid, path, x, y, target.x, target.y, true)
path_start(path, spd + 2.5, 3, 1)
