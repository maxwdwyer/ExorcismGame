spd = 30
randomize()
alarm[0] = 1
path = path_add()
var height = irandom(1) + 2
path_add_point(path, 0, (height - 1) * FSH, 100)
path_add_point(path, room_width / 2, (height - 1) * FSH, 100)
path_add_point(path, room_width / 2, height * FSH, 100)
path_add_point(path, 0, height * FSH, 100)
path_set_closed(path, true)
path_start(path, 20, 1, 1)