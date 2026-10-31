alarm[1] = 5
if point_distance(x, y, spdp[0], spdp[1]) == 0 then alarm[0] = 1
dir = point_direction(x, y, spdp[0], spdp[1]) + 180
spdp = [x,y]
/*if target != obj_player{
if is_array(target) then mp_grid_path(global.grid, path, x, y, target[0], target[1], true) else mp_grid_path(global.grid, path, x, y, target.x, target.y, true)
//path = scr_path_smooth(path, 1, 3, false)
//path = scr_path_smooth(path, 1, 2, false)
//path = scr_path_smooth(path, 1, 2, true)
path_start(path, spd, 3, 1)}
