var _y = mouse_y - floor(mouse_y / FSH) * FSH
if interact = true
{
	draw_set_halign(true)
	draw_text_transformed(room_width / 4 + 12, 475, typed, 4.75, 4.75, 0)
	draw_set_halign(false)
	for (var c = 0; c < 3; c ++){
		for (var r = 0; r < 4; r ++){
			if cd[0] >= cd[1]{
				if !mouse_check_button(ev_left_button)
				{
					if mouse_x > (c * 112) + 920 and mouse_x < (c * 112) + 1016
					{
						if _y > (r * 80) + 568 and _y < (r * 80) + 632
						{
							draw_sprite_stretched_ext(spr_safe_buttons, (r * 3) + c, (c * 112) + 920, (r * 80) + 568, 96, 64, c_grey, 1)
							var _num = (r * 3) + c + 1
							if t = 6
							{
								var _str = string(_num)
								if _num = 11 then _str = "0"
								if _num != 10 and _num != 12 then typed = string_concat(typed, _str)
								if _num = 10 then typed = string_delete(typed, -1, 1)
								if typed = code and _num = 12{
									open = true
									interact = false
								}
							}
							t -= 1
							
						}
						else draw_sprite_stretched_ext(spr_safe_buttons, (r * 3) + c, (c * 112) + 920, (r * 80) + 568, 96, 64, c_white, 1)
					}
					else draw_sprite_stretched_ext(spr_safe_buttons, (r * 3) + c, (c * 112) + 920, (r * 80) + 568, 96, 64, c_white, 1)
				}
				else draw_sprite_stretched_ext(spr_safe_buttons, (r * 3) + c, (c * 112) + 920, (r * 80) + 568, 96, 64, c_white, 1)
			}
			else draw_sprite_stretched_ext(spr_safe_buttons, (r * 3) + c, (c * 112) + 920, (r * 80) + 568, 96, 64, c_white, 1)
		}
	}
}
if cd[0] < cd[1] then cd[0] ++
if t <= 0
{
	cd[0] = 0
	t = 6
}

if interact = false then typed = ""
//show_debug_message(typed)