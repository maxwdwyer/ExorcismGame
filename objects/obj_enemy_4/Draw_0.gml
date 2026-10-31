function draw_leg(VecS, VecE, det = 8, md = 24){
	var dir = Vdir(VecS, VecE)
	var dist = md / det
	var VecA = lengthdir_vec(dist, dir)
	var VecNS = VecS
	for (var i = 0; i < det; i ++){
		DLV(VecNS, VA(VecNS, VecA), (det - i) / 1.8 + .2)
		VecNS = VA(VecNS, VecA)
	}
}



draw_set_color(c_black)
draw_set_alpha(1)

var _tm = [clamp(target.image_xscale / 1.35, 1, 2.25), clamp(target.image_yscale / 1.35, 1, 2.25), target.image_angle]

var _m = matrix_build(
x, y, 0,
0, 0, _tm[2],
1, 1, 1
)
matrix_set(matrix_world, _m)

draw_circle(0, 0, 18, false)
draw_circle(21, 21, 4.5, false)
draw_circle(21, -21, 4.5, false)
draw_circle(-21, 21, 4.5, false)
draw_circle(-21, -21, 4.5, false)

var _1 = new vec2(22.6, 22.6)
var _2 = new vec2(target.bbox_right - x, target.bbox_bottom - y)
draw_leg(_1, _2, 9, distance(_1, _2))

var _1 = new vec2(22.6, -22.6)
var _2 = new vec2(target.bbox_right - x, target.bbox_top - y)
draw_leg(_1, _2, 9, distance(_1, _2))

var _1 = new vec2(-22.6, 22.6)
var _2 = new vec2(target.bbox_left - x, target.bbox_bottom - y)
draw_leg(_1, _2, 9, distance(_1, _2))

var _1 = new vec2(-22.6, -22.6)
var _2 = new vec2(target.bbox_left - x, target.bbox_top - y)
draw_leg(_1, _2, 9, distance(_1, _2))

/*var _x = 0
var _y = 0
if round(_tm[2] / 90) = 0{
	_x = -6
	_y = 12
}
if round(_tm[2] / 90) = 1{
	_x = 12
	_y = -6
}
if round(_tm[2] / 90) = 2{
	_x = 6
	_y = -12
}
if round(_tm[2] / 90) = 3{
	_x = -12
	_y = 6
}

draw_sprite(spr_mouth, 0, -1 * _x, _y)
draw_sprite_ext(spr_mouth, 0, _x, _y, -1, 1, _tm[2], 0, 1)*/
var _rot = (sin(current_time / (175 * mspd)) * 6) - 6
draw_sprite_ext(spr_mouth, 0, -6, -10, 1, 1, -1 * _rot, c_white, 1)
draw_sprite_ext(spr_mouth, 0, 6, -10, -1, 1, _rot, c_white, 1)

var _m = matrix_build(
x, y, 0,
0, 0, 45 + _tm[2],
1, 1, 1
)
matrix_set(matrix_world, _m)
draw_ellipse(-24, -11, 24, 11, false)
draw_ellipse(-32, -6, 32, 6, false)

draw_ellipse(-11, -24, 11, 24, false)
draw_ellipse(-6, -32, 6, 32, false)


matrix_set(matrix_world, matrix_build_identity())
draw_set_color(c_white)
draw_set_alpha(1)