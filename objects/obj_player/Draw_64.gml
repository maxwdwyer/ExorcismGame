draw_set_color(c_white)
draw_set_alpha(1)

var _h = 1376
var _w = 2176

var _nearshelf = find_near_shelf()

#region HURT
if cd[7, 0] < cd[7, 1]{
	draw_set_alpha(2.75 / cd[7, 0])
	draw_sprite_stretched(spr_hurt, 0, 0, 0, 2176, 1376)
	draw_set_alpha(1)
}
var _hp = (1 - (hp / 5))
draw_set_alpha(_hp / (10 - (_hp * 10)))
draw_sprite_stretched(spr_hurt, 0, 0, 0, 2176, 1376)
draw_set_alpha(1)
#endregion

#region CONTROLS
if keyboard_check_direct(vk_tab){
	draw_text_ext_transformed(16, 16 + (1 * 20), "WASD or arrow keys to move.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (2 * 20), "Press 1, 2, or 3 to switch inventory slot.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (3 * 20), "Most items need to be equiped to be used.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (4 * 20), "Click to use most items.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (5 * 20), "E and Q to interact, interactable items will tell you which to use.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (6 * 20), "Use Z to drop items.", 1, 9999, 1.5, 1.5, 0)
}
#endregion

#region ITEMS
if sel !=0
{
	if inv[sel - 1] = 8
	{
		if mouse_check_button(mb_left){
			draw_sprite_stretched(spr_note1, 0, (_w / 2) - 96, (_h / 2) - 96, 192, 192)
		}
	}
	if inv[sel - 1] = 9
	{
		if mouse_check_button(mb_left){
			draw_sprite_stretched(spr_note2, 0, (_w / 2) - 96, (_h / 2) - 96, 192, 192)
		}
	}
	if inv[sel - 1] = 12
	{
		if mouse_check_button(mb_left){
			draw_sprite_stretched(spr_note3, 0, (_w / 2) - 96, (_h / 2) - 96, 192, 192)
		}
	}
	if inv[sel - 1] = 20
	{
		if mouse_check_button(mb_left){
			draw_sprite_stretched(spr_note7, 0, (_w / 2) - 96, (_h / 2) - 96, 192, 192)
		}
	}
	if inv[sel - 1] = 19
	{
		if mouse_check_button(mb_left){
			draw_sprite_stretched(spr_note6, 0, (_w / 2) - 96, (_h / 2) - 96, 192, 192)
		}
	}
	if inv[sel - 1] = 18
	{
		if mouse_check_button(mb_left){
			draw_sprite_stretched(spr_note5, 0, (_w / 2) - 96, (_h / 2) - 96, 192, 192)
		}
	}
	if inv[sel - 1] = 17
	{
		if mouse_check_button(mb_left){
			draw_sprite_stretched(spr_note4, 0, (_w / 2) - 96, (_h / 2) - 96, 192, 192)
		}
	}
	
	if notebookarray[0] = 1 //NOTEBOOK
	{
		draw_sprite_stretched(spr_notebook_cover, 0, 20, 20, 768, 512)
		var _pagel = notebookarray[1] * 2 + 1
		var _pager = notebookarray[1] * 2
		if notebookarray[_pager + 0] = 0 then draw_sprite_stretched(spr_pages, _pager, 36, 32, 352, 468)
		if notebookarray[_pagel + 0] = 0 then draw_sprite_stretched(spr_pages, _pagel, 420, 36, 352, 468)
		if notebookarray[_pager + 0] = 1 then draw_sprite_stretched(spr_pages_unlocked, _pager, 36, 32, 352, 468)
		if notebookarray[_pagel + 0] = 1 then draw_sprite_stretched(spr_pages_unlocked, _pagel, 420, 36, 352, 468)
	}
	//PAGE AQUIRED NOTIFACTION----------------------------------
}
if cd[8, 0] < cd[8, 1]{
		draw_set_halign(true)
		draw_set_alpha(1 - (1 / (cd[8, 1] - cd[8, 0])))
		draw_text_ext_transformed(_w / 2 - 74, 120, cd[8, 2], 10, 9990, 1.5, 1.5, 0)
		draw_set_alpha(1)
		draw_set_halign(false)
	}
#endregion

#region HEALTH
var _hx = 16
var _hy = _h - 76
if hp = 0.5{
	draw_sprite_stretched(spr_heart, 1, _hx, _hy, 48, 48)
}
if hp = 1{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
}
if hp = 1.5{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
	draw_sprite_stretched(spr_heart, 1, _hx, _hy - 60, 48, 48)
}
if hp = 2{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 60, 48, 48)
}
if hp = 2.5{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 60, 48, 48)
	draw_sprite_stretched(spr_heart, 1, _hx, _hy - 120, 48, 48)
}
if hp = 3{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 60, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 120, 48, 48)
}
if hp = 3.5{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 60, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 120, 48, 48)
	draw_sprite_stretched(spr_heart, 1, _hx, _hy - 180, 48, 48)
}
if hp = 4{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 60, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 120, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 180, 48, 48)
}
if hp = 4.5{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 60, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 120, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 180, 48, 48)
	draw_sprite_stretched(spr_heart, 1, _hx, _hy - 240, 48, 48)
}
if hp = 5{
	draw_sprite_stretched(spr_heart, 0, _hx, _hy, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 60, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 120, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 180, 48, 48)
	draw_sprite_stretched(spr_heart, 0, _hx, _hy - 240, 48, 48)
}
#endregion

#region HOTBAR
if sel != 1 then draw_sprite_stretched(spr_hotbar, 0, 104, _h - 104, 80, 80) else draw_sprite_stretched(spr_hotbar, 1, 104 - 5, _h - 109, 90, 90)
if sel != 2 then draw_sprite_stretched(spr_hotbar, 0, 104 * 2, _h - 104, 80, 80) else draw_sprite_stretched(spr_hotbar, 1, 104 * 2 - 5, _h - 109, 90, 90)
if sel != 3 then draw_sprite_stretched(spr_hotbar, 0, 104 * 3, _h - 104, 80, 80) else draw_sprite_stretched(spr_hotbar, 1, 104 * 3 - 5, _h - 109, 90, 90)

if sel != 0 and inv[sel - 1] = 10
{
	draw_text_transformed(0, 0, "The time is ", 1.8, 1.8, 0)
	draw_text_transformed(200, 0, [obj_game.hour, obj_game.minute], 1.8, 1.8, 0)
}
var _state = 0
if potstate[0] <= 0{
	_state = 1
}
if potstate[1] > 500{
	_state = 2
}
draw_set_halign(true)
if inv[0] != 0{
	draw_sprite_stretched(global.items[inv[0] - 1, 1], _state, 104 + 8, _h - 104 + 8, 64, 64)
	draw_text( 104 + 40, _h - 124, global.items[inv[0] - 1, 2])
}
if inv[1] != 0{
	draw_sprite_stretched(global.items[inv[1] - 1, 1], _state, 104 * 2 + 8, _h - 104 + 8, 64, 64)
	draw_text( 104 * 2 + 40, _h - 124, global.items[inv[1] - 1, 2])
}
if inv[2] != 0{
	draw_sprite_stretched(global.items[inv[2] - 1, 1], _state, 104 * 3 + 8, _h - 104 + 8, 64, 64)
	draw_text( 104 * 3 + 40, _h - 124, global.items[inv[2] - 1, 2])
}
draw_set_halign(false)
#endregion

#region NEAREST
var _door = instance_nearest(x, y, obj_doorway)
var _hide = instance_nearest(x, y, obj_hiding_spot)
var _switch = instance_nearest(x, y, obj_lightswitch)
var _stair = instance_nearest(x, y, obj_stair)
var _sink = instance_nearest(x, y, obj_kitchensink)
var _pot = instance_nearest(x, y, obj_pot)
var _stove = instance_nearest(x, y, obj_stove)
var _safe = instance_nearest(x, y, obj_safe)
var _shelf = find_near_shelf()
var _shelfname = string_delete(object_get_name(_shelf.object_index), 0, 4)

var _item = find_near_item()
var _near = 0
var _nearest = point_distance(x, y, _door.x, _door.y)
if point_distance(x, y, _hide.x, _hide.y) < _nearest{
	_near = 1
	_nearest = point_distance(x, y, _hide.x, _hide.y)
}
if point_distance(x, y, _switch.x, _switch.y) < _nearest{
	_near = 2
	_nearest = point_distance(x, y, _switch.x, _switch.y)
}
if point_distance(x, y, _stair.x, _stair.y) < _nearest{
	_near = 3
	_nearest = point_distance(x, y, _stair.x, _stair.y)
}
if point_distance(x, y, _item.x, _item.y) < _nearest{
	_near = 4
	_nearest = point_distance(x, y, _item.x, _item.y)
}
if point_distance(x, y, _shelf.x, _shelf.y) < _nearest{
	_near = 5
	_nearest = point_distance(x, y, _shelf.x, _shelf.y)
}
if point_distance(x, y, _sink.x, _sink.y) < _nearest{
	_near = 6
	_nearest = point_distance(x, y, _sink.x, _sink.y)
}
if point_distance(x, y, _safe.x, _safe.y) < _nearest{
	_near = 7
	_nearest = point_distance(x, y, _safe.x, _safe.y)
}
if sel != 0 and inv[sel - 1] = 16 and potstate[0] = 0
{
	if point_distance(x, y, _stove.x, _stove.y) < _nearest{
		_near = 8
		_nearest = point_distance(x, y, _stove.x, _stove.y)
	}
}
#endregion

#region MISC
draw_set_color(c_white)
var _col = [obj_wall, obj_window]//, obj_placeholder]
#endregion

#region PROMPT SWITCH
switch(_near){
	case 0: // DOOR
		if point_distance(x, y, _door.x, _door.y) < 125{
			//if collision_line(x, y, _door.x, _door.y, _col, false, false) = noone{
			if _door.locked != 0{
				if sel != 0 and inv[sel - 1] = _door.locked{
					draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Press    to unlock the door.", 10, 9990, 1.5, 1.5, 0)
					draw_sprite_stretched(spr_letters, 0, _w / 2, _h - 120, 40, 40)
				}
				else draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "This door is locked.", 10, 9990, 1.5, 1.5, 0)
			}
			else
			{
				draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Press    to open the door.", 10, 9990, 1.5, 1.5, 0)
				draw_sprite_stretched(spr_letters, 0, _w / 2, _h - 120, 40, 40)
			}
			//}
		}
		break
	case 1: // HIDING SPOT
		if point_distance(x, y, _hide.x, _hide.y) < 125{
			if collision_line(x, y, _hide.x, _hide.y, _col, false, false) = noone{
				draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Press    to hide.", 10, 9990, 1.5, 1.5, 0)
				draw_sprite_stretched(spr_letters, 0, _w / 2, _h - 120, 40, 40)
			}
		}
		break
	case 2: // LIGHT SWITCH
		if point_distance(x, y, _switch.x, _switch.y) < 125{
			if collision_line(x, y, _switch.x, _switch.y, _col, false, false) = noone{
				draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Press    to turn on the light.", 10, 9990, 1.5, 1.5, 0)
				draw_sprite_stretched(spr_letters, 1, _w / 2, _h - 120, 40, 40)
			}
		}
		break
	case 3: // STAIRS
		if point_distance(x, y, _stair.x, _stair.y) < 325{
			if collision_line(x, y, _stair.x, _stair.y, _col, false, false) = noone{
				draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Press    to go to another floor.", 10, 9990, 1.5, 1.5, 0)
				draw_sprite_stretched(spr_letters, 2, _w / 2, _h - 120, 40, 40)
			}
		}
		break
	case 4: // ITEM
		if point_distance(x, y, _item.x, _item.y) < 125{
			if collision_line(x, y, _item.x, _item.y, obj_wall, false, false) = noone{
				if sel != 0 and inv[sel - 1] = 15 and _item.object_index = obj_pot
				{
					draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Click to pour into pot.", 10, 9990, 1.5, 1.5, 0)
				}
				if sel != 0 and inv[sel - 1] = 2 and _item.object_index = obj_pot and _item.boiling > (obj_game.hourlen * .75)
				{
					draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Click to purify salt.", 10, 9990, 1.5, 1.5, 0)
				}
				else
				{
					draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Press    to pick up item.", 10, 9990, 1.5, 1.5, 0)
					draw_sprite_stretched(spr_letters, 1, _w / 2, _h - 120, 40, 40)
				}
			}
		}
		break
	case 5: // SHELF
		if point_distance(x, y, _shelf.x, _shelf.y) < 125{
			//if collision_line(x, y, _shelf.x, _shelf.y, obj_wall, false, false) = noone{
			var _text = string_concat("Press    to search ", _shelfname, ".")
			draw_text_ext_transformed(_w / 2 - 74,  _h - 120, _text, 10, 9990, 1.5, 1.5, 0)
			draw_sprite_stretched(spr_letters, 1, _w / 2, _h - 120, 40, 40)
			//}
		}
		break
	case 6:
		if point_distance(x, y, _sink.x, _sink.y) < 125{
			if sel != 0 and inv[sel - 1] = 1 then draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Click to fill cup with water.", 10, 9990, 1.5, 1.5, 0)
		}
		break
	case 7: // SAFE
		if point_distance(x, y, _safe.x, _safe.y) < 125{
			if collision_line(x, y, _safe.x, _safe.y, _col, false, false) = noone{
				draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Press    to go to interact with safe.", 10, 9990, 1.5, 1.5, 0)
				draw_sprite_stretched(spr_letters, 0, _w / 2, _h - 120, 40, 40)
				if keyboard_check_pressed(ord("E"))
				{
					if _safe.open = false
					{
						if _safe.interact = false then _safe.interact = true else _safe.interact = false
					}
					else
					{
						_safe.interact = false
					}
				}
			}
		}
		break
	case 8: // STOVE
		if point_distance(x, y, _stove.x, _stove.y) < 150{
			draw_text_ext_transformed(_w / 2 - 74,  _h - 120, "Press    to drop pot on stove.", 10, 9990, 1.5, 1.5, 0)
			draw_sprite_stretched(spr_letters, 3, _w / 2, _h - 120, 40, 40)
		}
		break
}
#endregion

#region GAME END
if win[0] = 1
{
	draw_set_alpha((200 - win[1]) / 200)
	draw_set_color(c_white)
	draw_rectangle(0, 0, room_width, room_height, false)
	draw_set_alpha(1)
}
#endregion