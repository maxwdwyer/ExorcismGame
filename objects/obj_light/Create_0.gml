pos = VecCreate()
cid = scr_cid(pos)

var _other = instance_place(x, y, obj_floor)
lights = scr_calc_lights()
backvp = scr_calc_size(lights)

background = 0
lightspr = 0
start = true

on = false
alarm[0] = 2
alarm[1] = 5
alarm[1] = 6