turn += change
turn = clamp(turn, -1.5, 1.5)
change = random_range(-.15, .15)
dir += turn
image_angle = dir

bl = -24 + x//bbox_left
bt = -24 + y//bbox_top
br = 24 + x//bbox_right
bb = 24 + y//bbox_bottom


var _x = lengthdir_x(spd, dir)
var _y = lengthdir_y(spd, dir)
move_and_collide(_x, _y, collisions)

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




audio_emitter_position(emitter, x, y, obj_player.depth)

