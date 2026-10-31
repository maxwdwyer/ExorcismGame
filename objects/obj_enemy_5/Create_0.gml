randomize()
num = irandom(instance_number(obj_floor) - 1)
target2 = instance_find(obj_window, num)
collisions = [obj_doorway, obj_wall, obj_window, obj_hiding_spot]
dir = random(180)
turn = random_range(-1.5, 1.5)
change = random_range(-.15, .15)
spd = .5
off = 9
dir = 0
m = 0
bl = -24 + x//bbox_left
bt = -24 + y//bbox_top
br = 24 + x//bbox_right
bb = 24 + y//bbox_bottom
limbs = [[bl, bt, 0], [br, bt, off * 1], [bl, bb, off * 2], [br, bb, off * 3]]

alarm[0] = 1

emitter = audio_emitter_create()
audio_falloff_set_model(audio_falloff_inverse_distance)