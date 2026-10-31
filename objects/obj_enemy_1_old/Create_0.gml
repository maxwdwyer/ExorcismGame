randomise()
path = path_add()
cid = 1
spd = 3
spdp = [x, y]
target = obj_player
off = 5
dir = 0
m = 0
olddir = 0
bl = -24 + x//bbox_left
bt = -24 + y//bbox_top
br = 24 + x//bbox_right
bb = 24 + y//bbox_bottom
limbs = [[bl, bt, 0], [br, bt, off * 1], [bl, bb, off * 2], [br, bb, off * 3]]
alarm[0] = 1
alarm[1] = 1
soff = [0, 0]