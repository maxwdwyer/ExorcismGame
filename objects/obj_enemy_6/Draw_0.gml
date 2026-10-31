#region shadow
draw_set_color(c_black)
draw_set_alpha(.15)
var _test = sin(current_time / 75) * 3
m = matrix_build(
x + soff[0], y + soff[1], 0,
0, 0, dir,
.8, .8, .8)
matrix_set(matrix_world, m)

draw_ellipse(-12, -10, 12, 10, false) // body
draw_ellipse(-3, -7.5, -25, 7.5, false) // body
draw_ellipse(-12, -8, -23, 8, false) // hip
draw_ellipse(-20, -5, -37, 5, false) // tail
draw_ellipse(-15, -6, -28, 6, false) // tail
draw_ellipse(-27, -3.5, -48, 3.5, false) // tail

draw_ellipse(18 + 5, 7, 10 + 5, -7, false)
draw_ellipse(21 + 5, 6, 7 + 5, -6, false)
draw_ellipse(25 + 5, 5, 2 + 5, -5, false)

m = matrix_build(
x + soff[0], y + soff[1], 0,
0, 0, 0,
1.7, 1.7, 1.7)
matrix_set(matrix_world, m)
for (var _i = 0; _i < array_length(limbs); _i += 1){
	var _dist = point_distance(x, y, limbs[_i, 0] - soff[0], limbs[_i, 1] - soff[1])
	var _dir = point_direction(x, y, limbs[_i, 0] - soff[0], limbs[_i, 1] - soff[1])
	if _dist > 5 then draw_set_alpha(0)
	var _dirx = lengthdir_x(_dist / 6, _dir)
	var _diry = lengthdir_y(_dist / 6, _dir)
	for (var _q = 0; _q < 9; _q += 1){
		var _width = clamp((10 / (_q * (_q / 2.5))) * 1.5, .3, 6)
		draw_line_width(0 + (_dirx * (_q - 1)), 0 + (_diry * (_q - 1)), 0 + (_dirx * _q), 0 + (_diry * _q), _width)
	}
	if _dist > 5 then draw_set_alpha(1)
}

m = matrix_build(
x + soff[0], y + soff[1], 0,
0, 0, dir,
1.3, 1.3, 1.3)
matrix_set(matrix_world, m)
draw_sprite_ext(spr_wing, 1, 0, -12, 1.3, 2, 25 - 90 + _test, c_white, 1)
draw_sprite_ext(spr_wing, 1, 0, 12, -1.3, 2, -25 - 90 - _test, c_white, 1)
draw_set_alpha(1)

matrix_set(matrix_world, matrix_build_identity())

draw_set_color(c_white)

#endregion

#region body

draw_set_color(c_black)
var _test = sin(current_time / 75) * 3
m = matrix_build(
x, y, 0,
0, 0, dir,
1.3, 1.3, 1.3)
matrix_set(matrix_world, m)

draw_ellipse(-12, -10, 12, 10, false) // body
draw_ellipse(-3, -7.5, -25, 7.5, false) // body
draw_ellipse(-12, -8, -23, 8, false) // hip
draw_ellipse(-20, -5, -37, 5, false) // tail
draw_ellipse(-15, -6, -28, 6, false) // tail
draw_ellipse(-27, -3.5, -48, 3.5, false) // tail

draw_ellipse(22, 10, 15, -10, false)
draw_ellipse(32, 7, 0, -7, false)
draw_ellipse(32, -5, 7, -5, false)

for (var _i = 0; _i < array_length(limbs); _i += 1){
	m = matrix_build(
	x, y, 0,
	0, 0, 0,
	1, 1, 1)
	matrix_set(matrix_world, m)
	var _dist = point_distance(x, y, limbs[_i, 0], limbs[_i, 1])
	var _dir = point_direction(x, y, limbs[_i, 0], limbs[_i, 1])
	if _dist > 128 then draw_set_alpha(0)
	var _dirx = lengthdir_x(_dist / 6, _dir)
	var _diry = lengthdir_y(_dist / 6, _dir)
	for (var _q = 0; _q < 9; _q += 1){
		var _width = clamp((10 / (_q * (_q / 2.5))) * 1.5, .3, 6)
		draw_line_width(0 + (_dirx * (_q - 1)), 0 + (_diry * (_q - 1)), 0 + (_dirx * _q), 0 + (_diry * _q), _width)
	}
	if _dist > 128 then draw_set_alpha(1)
}

m = matrix_build(
x, y, 0,
0, 0, dir,
1.3, 1.3, 1.3)
matrix_set(matrix_world, m)
draw_set_alpha(.8)
draw_sprite_ext(spr_wing, 1, 0, -12, 1.3, 2, 25 - 90 + _test, c_white, 1)
draw_sprite_ext(spr_wing, 1, 0, 12, -1.3, 2, -25 - 90 - _test, c_white, 1)
draw_set_alpha(1)

draw_sprite_ext(spr_eye, 0, 28, 0, 1.25, 1.25, -90, c_white, 1)

matrix_set(matrix_world, matrix_build_identity())
draw_set_color(c_white)
#endregion