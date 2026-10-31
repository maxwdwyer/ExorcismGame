if hidden = false then draw_self()

salt(obj_salt)

#region DRAW ROOM VP
if ready = true
{
	draw_set_color(c_black)
	for (var _i = 0; _i < array_length(vp[1]); _i += 1){
		var _cur = vp[1, _i]
		draw_rectangle(_cur[0], _cur[1], _cur[2], _cur[3] + 10, false)
	}
	draw_set_color(c_white)
	draw_set_alpha(0.3);
	draw_set_alpha(1);
}
#endregion

#region DRAW HIDDEN SHADOWS
if hidden = true
{
	var _other = instance_place(x, y, obj_hiding_spot)
	for (var _i = 0; _i < 7; _i ++){
		scr_hiding_shadow(_other, _i)
	}
}
#endregion

ready = true