roomchange = 0

#region MOVEMENT
if hidden = false
{ 

	if keyboard_check_direct(ord("W")) or keyboard_check_direct(vk_up){
		if !place_meeting(x, y - spd, collisions) then y -= spd}
	if keyboard_check_direct(ord("A")) or keyboard_check_direct(vk_left){
		if !place_meeting(x - spd, y, collisions) then x -= spd}
	if keyboard_check_direct(ord("S")) or keyboard_check_direct(vk_down){
		if !place_meeting(x, y + spd, collisions) then y += spd}
	if keyboard_check_direct(ord("D")) or keyboard_check_direct(vk_right){
		if !place_meeting(x + spd, y, collisions) then x += spd}
		
	if keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right){
		audio_stop_sound(_sound)
		_sound = audio_play_sound(walking, 2, true)
	}
	if !keyboard_check_direct(ord("W")) and !keyboard_check_direct(vk_up) and !keyboard_check_direct(ord("A")) and !keyboard_check_direct(vk_left) and !keyboard_check_direct(ord("S")) and !keyboard_check_direct(vk_down) and !keyboard_check_direct(ord("D")) and !keyboard_check_direct(vk_right) then audio_stop_sound(_sound)
}
#endregion

#region HIDE SCRIPT
function scr_hide(){
	var _cols = [obj_wall, obj_window, obj_doorway, obj_placeholder]
	if hidden = false{
		var _near = instance_nearest(x, y, obj_hiding_spot)
		if point_distance(x, y, _near.x, _near.y) < 200{
			if collision_line(x, y, _near.x, _near.y, _cols, false, false) = noone{
				if _near.taken = false
				{
					lhp = [x, y]
					x = _near.x
					y = _near.y
					pos.x = _near.x
					pos.y = _near.y
					hidden = true
					_near.ptaken = true}
			}
		}
	}
	else if hidden = true{
		var _near = instance_nearest(x, y, obj_hiding_spot)
		hidden = false
		x = lhp[0]
		y = lhp[1]
		_near.ptaken = false
	}
}
#endregion

#region HIDE
if cd[4, 0] = cd[4, 1] {
	if keyboard_check_direct(ord("E")){
		var _door = instance_nearest(x, y, obj_doorway)
		var _hide = instance_nearest(x, y, obj_hiding_spot)
		if point_distance(x, y, _door.x, _door.y) > point_distance(x, y, _hide.x, _hide.y)
		{
			if _hide.taken = true {
				hp -= 1.5
				cd[6, 0] = 0
				cd[4, 0] = 0
			}
			else
			{
				scr_hide()
				cd[4, 0] = 0
			}
		}
	}
}
#endregion

#region SET POS
pos.x = x
pos.y = y
pos.z = floor(y / FSH)
cid = scr_cid(pos)
#endregion

#region GET ROOM VP
var _other = instance_place(x, y, obj_floor)
if roomchange = 0 then vp = scr_getroomsize(_other.cid, pos.z)
vp = scr_getroomsize(cid, pos.z)
#endregion

#region DOORS
if cd[1, 0] = cd[1, 1] {
	if keyboard_check_direct(ord("E")){
		var _col = [obj_wall, obj_window, obj_placeholder]
		var _door = instance_nearest(x, y, obj_doorway)
		var _hide = instance_nearest(x, y, obj_hiding_spot)
		if point_distance(x, y, _door.x, _door.y) < point_distance(x, y, _hide.x, _hide.y)
		{
			if collision_line(x, y, _door.x, _door.y, _col, false, false) = noone{
				if _door.locked = 0{
					scr_opendoor(x, y)
					audio_play_sound(opendoor, 1, false)
					cd[1, 0] = 0
				}
				else
				{
					if sel != 0 {
						if inv[sel - 1] = _door.locked
						{
							_door.locked = 0
							scr_opendoor(x, y)
							audio_play_sound(opendoor, 1, false)
							cd[1, 0] = 0
						}
					}
				}
			}
		}
	}
}
#endregion

#region STAIRS
if cd[2, 0] = cd[2, 1] {
	if keyboard_check_direct(ord("R")){
		var _s = instance_nearest(x, y, obj_stair)
		if point_distance(x, y, _s.x, _s.y) < 300 and collision_line(x, y, _s.x, _s.y, collisions, false, false) = noone and collision_line(x, y, _s.x + 1, _s.y + 1, collisions, false, false) = noone{
			if _s.goesto != 1 
			{
				if _s.goesto = 0{ // UNLOCKS BASEMENT
					if inv[0] = 6 or inv[1] = 6 or inv[2] = 6 then lockedstairs[0] = 0
				}
				if _s.goesto = 2{ // UNLOCKS ATTIC
					if inv[0] = 7 or inv[1] = 7 or inv[2] = 7 then lockedstairs[1] = 0
				}
				if _s.goesto = 0 and lockedstairs[0] = 0{
					x = _s.connect.x
					y = _s.connect.y
					pos.z = floor(y / FSH)
					cd[2, 0] = 0
					camera_set_view_pos(view_camera[0], 0, pos.z * FSH)
					for (var _i = 0; _i < instance_number(obj_light); _i += 1){ 
						var _light = instance_find(obj_light, _i)
						if _light.pos.z = pos.z then _light.start = true
					}
				}
				if _s.goesto = 2 and lockedstairs[1] = 0{
					x = _s.connect.x
					y = _s.connect.y
					pos.z = floor(y / FSH)
					cd[2, 0] = 0
					camera_set_view_pos(view_camera[0], 0, pos.z * FSH)
					for (var _i = 0; _i < instance_number(obj_light); _i += 1){ 
						var _light = instance_find(obj_light, _i)
						if _light.pos.z = pos.z then _light.start = true
					}
				}
			}
			else
			{
				x = _s.connect.x
				y = _s.connect.y
				pos.z = floor(y / FSH)
				cd[2, 0] = 0
				camera_set_view_pos(view_camera[0], 0, pos.z * FSH)
				for (var _i = 0; _i < instance_number(obj_light); _i += 1){ 
					var _light = instance_find(obj_light, _i)
					if _light.pos.z = pos.z then _light.start = true
				}
			}
		}
	}
}
#endregion

#region LIGHTSWITCH
var _item = find_near_item()
var _lsn = instance_nearest(x, y, obj_lightswitch)
if cd[3, 0] = cd[3, 1] {
	if keyboard_check_direct(ord("Q")){
		if point_distance(_item.x, _item.y, x, y) > point_distance(_lsn.x, _lsn.y, x, y){
			scr_lightswitch(x, y, cid, obj_player)
			cd[3, 0] = 0
			if instance_exists(obj_enemy_6){
				for (var i = 0; i < instance_number(obj_enemy_6); i ++){
					var _enemy = instance_find(obj_enemy_6, i)
					if collision_line(x, y, _enemy.x, _enemy.y, obj_wall, false, false) = noone and collision_line(x, y, _enemy.x + 1, _enemy.y + 1, obj_wall, false, false) = noone
					{
						show_debug_message("attacking")
						_enemy.attacking = true
					}
				}
			}
		}
	}
}
#endregion

#region PICK UP ITEM
if keyboard_check_pressed(ord("Q")){
	var _shelf = find_near_shelf()
	var _useshelf = false
	if point_distance(x, y, _shelf.x, _shelf.y) < point_distance(_item.x, _item.y, x, y) then _useshelf = true
	var _itemtype = _item.num
	var _thing = _item
	if _useshelf = true then _itemtype = _shelf.item
	if _useshelf = true then _thing = _shelf
	if point_distance(_thing.x, _thing.y, x, y) < 125{
		if point_distance(_thing.x, _thing.y, x, y) < point_distance(_lsn.x, _lsn.y, x, y)
		{
			if sel != 0{
				if sel != 0 and inv[sel - 1] != 0
				{
					var _obj = global.items[inv[sel - 1] - 1, 0]
					var _newobj = instance_create_layer(x, y, "items", _obj)
					if _newobj.object_index = obj_pot {
						_newobj.filled = potstate[0]
						_newobj.boiling = potstate[1]
					}
				}
				inv[sel - 1] = _itemtype // _item.num
				if _itemtype = 16 
				{
					potstate =  [_item.filled, _item.boiling]
				}
				audio_play_sound(pickupitem, 1, false)
				if _useshelf = false then instance_destroy(_item)
				if _shelf.object_index = obj_safe then _shelf.crosstaken = true
			}
			else if sel == 0{// IF U PICK SMTH UP AND NO INVENTORY SLOT IS SELECTED
				if _itemtype = 16
				{
					potstate = [_item.filled, _item.boiling]
				}
				if inv[0] = 0{ 
					inv[0] = _itemtype
					audio_play_sound(pickupitem, 1, false)
					if _shelf.object_index = obj_safe then _shelf.crosstaken = true
					if _useshelf = false then instance_destroy(_item)
				}
				else if inv[1] = 0{
					inv[1] = _itemtype
					audio_play_sound(pickupitem, 1, false)
					if _shelf.object_index = obj_safe then _shelf.crosstaken = true
					if _useshelf = false then instance_destroy(_item)
				}
				else if inv[2] = 0{
					inv[2] = _itemtype
					audio_play_sound(pickupitem, 1, false)
					if _shelf.object_index = obj_safe then _shelf.crosstaken = true
					if _useshelf = false then instance_destroy(_item)
				}			
			}
		}
	}
}
//UNLOCKING NOTES------------------------------------------------------------
if keyboard_check_pressed(ord("Q")){
	if check_inventory(8) = true and notebookarray[2] = 0{
		notebookarray[2] = 1
		cd[8, 2] = "Note one added to notebook page one."
		cd[8, 0] = 0
	}
	if check_inventory(9) = true and notebookarray[3] = 0{
		notebookarray[3] = 1
		cd[8, 2] = "Note two added to notebook page two."
		cd[8, 0] = 0
	}
	if check_inventory(12) = true and notebookarray[4] = 0{
		notebookarray[4] = 1
		cd[8, 2] = "Note three added to notebook page three."
		cd[8, 0] = 0
	}
	if check_inventory(17) = true and notebookarray[5] = 0{
		notebookarray[5] = 1
		cd[8, 2] = "Note four added to notebook page four."
		cd[8, 0] = 0
	}
	if check_inventory(18) = true and notebookarray[6] = 0{
		notebookarray[6] = 1
		cd[8, 2] = "Note five added to notebook page five."
		cd[8, 0] = 0
	}
	if check_inventory(19) = true and notebookarray[7] = 0{
		notebookarray[7] = 1
		cd[8, 2] = "Note six added to notebook page six."
		cd[8, 0] = 0
	}
	if check_inventory(20) = true and notebookarray[8] = 0{
		notebookarray[8] = 1
		cd[8, 2] = "Note seven added to notebook page seven."
		cd[8, 0] = 0
	}
	if check_inventory(14) = true and notebookarray[9] = 0{
		notebookarray[9] = 1
		cd[8, 2] = "Note eight added to notebook page eight."
		cd[8, 0] = 0
	}
}
#endregion

#region DROP ITEM
	if keyboard_check(ord("Z")){
		if sel != 0 and inv[sel - 1] != 0
		{
			audio_play_sound(setdownitem, 1, false, 2.5)
			var _obj = global.items[inv[sel - 1] - 1, 0]
			var _newobj = instance_create_layer(x, y, "items", _obj)
			if inv[sel - 1] = 16 
			{
				_newobj.filled = potstate[0]
				_newobj.boiling = potstate[1]
				var _stove = instance_nearest(x, y, obj_stove)
				if point_distance(_stove.x, _stove.y, x, y) < 125
				{
					if potstate[0] <= 0
					{
						_newobj.x = _stove.x
						_newobj.y = _stove.y
					}
				}
			}
			inv[sel - 1] = 0
		}
	}
#endregion

#region SWITCH INV SLOT
if keyboard_check_pressed(ord("1")){
	if sel != 1 then sel = 1 else sel = 0}
if keyboard_check_pressed(ord("2")){
	if sel != 2 then sel = 2 else sel = 0}
if keyboard_check_pressed(ord("3")){
	if sel != 3 then sel = 3 else sel = 0}
#endregion

#region DAMAGE
if cd[6, 0] = cd[6, 1]{
	if place_meeting(x, y, obj_enemy_1){
		hp -= 1
		cd[6, 0] = 0
		cd[7, 0] = 0
		audio_play_sound(bugattack, 2, false, 1)
	}
	if place_meeting(x, y, obj_enemy_3){
		hp -= 1.5
		cd[6, 0] = 0
		cd[7, 0] = 0
		audio_play_sound(bugattack, 2, false, 1.5)
	}
	if place_meeting(x, y, obj_enemy_5){
		hp -= .5
		cd[6, 0] = 0
		cd[7, 0] = 0
		audio_play_sound(bugattack, 2, false, .75)
	}
	if instance_exists(obj_enemy_2){
		var _enemy = instance_nearest(x, y, obj_enemy_2)
		if point_distance(x, y, _enemy.x, _enemy.y) < 900
		{
			if collision_line(x, y, _enemy.x, _enemy.y, global.cols, false, false) == noone{
				if collision_line(x, y, _enemy.x + 1, _enemy.y + 1, global.cols, false, false) == noone{
					if collision_line(x + 1, y + 1, _enemy.x, _enemy.y, global.cols, false, false) == noone{
						hp -= .5
						cd[6, 0] = 0
						cd[7, 0] = 0
						audio_play_sound(bugattack, 2, false, .8)
					}
				}
			}
		}
	}
	if place_meeting(x, y, obj_enemy_6){
		if instance_nearest(x, y, obj_enemy_6).attacking = true{
			audio_play_sound(bugattack, 2, false, 1.3)
			hp -= 1
			cd[6, 0] = 0
			cd[7, 0] = 0
		}
	}
}
if hp <= 0 then restart()
#endregion

#region COOLDOWNS
for (var _i = 0; _i < array_length(cd); _i += 1){
	if cd[_i, 0] < cd[_i, 1] then cd[_i, 0] += 1}
if win[0] = 1 then win[1] -= 1
#endregion

#region USING ITEMS
if sel != 0 {
	#region SALT
	if inv[sel - 1] = 2 // DIRTY
	{
		if mouse_check_button(mb_left){
			if point_distance(mouse_x, mouse_y, saltlastpos[0], saltlastpos[1]) > 1.5{
				if point_distance(mouse_x, mouse_y, x, y) < 400{
				instance_create_layer(mouse_x, mouse_y, "salt", obj_salt_dirty)
				instance_create_layer(mouse_x, mouse_y, "salt", obj_salt_dirty)
				instance_create_layer(mouse_x, mouse_y, "salt", obj_salt_dirty)
				}
			}
		}
	}
	if inv[sel - 1] = 21 // PURIFIED
	{
		if mouse_check_button(mb_left){
			if point_distance(mouse_x, mouse_y, saltlastpos[0], saltlastpos[1]) > 1.5{
				if point_distance(mouse_x, mouse_y, x, y) < 400{
				instance_create_layer(mouse_x, mouse_y, "salt", obj_salt)
				instance_create_layer(mouse_x, mouse_y, "salt", obj_salt)
				instance_create_layer(mouse_x, mouse_y, "salt", obj_salt)
				}
			}
		}
	}
	#endregion
	#region KNIFE
	if inv[sel - 1] = 4
	{
		if mouse_check_button(mb_left){
			var _enemy = find_near_enemy()
			if point_distance(x, y, _enemy.x, _enemy.y) < 72{
				inv[sel - 1] = 0
				instance_destroy(_enemy)
			}
		}
	}
	#endregion
	#region MEDICINE
	if inv[sel - 1] = 13
	{
		if mouse_check_button(mb_left){
			if hp != 5 then inv[sel - 1] = 0
			if hp < 4.5 then hp += 1
			if hp = 4.5 then hp = 5
		}
	}
	#endregion 
	#region FILL CUP
	if inv[sel - 1] = 1
	{
		if mouse_check_button(mb_left){
			var _sink = instance_nearest(x, y, obj_kitchensink)
			if point_distance(x, y, _sink.x, _sink.y) < 125 then inv[sel - 1] = 15
		}
	}
	#endregion 
	#region FILL POT
	if inv[sel - 1] = 15
	{
		if mouse_check_button(mb_left){
			if instance_exists(obj_pot)
			{
				var _pot = instance_nearest(x, y, obj_pot)
				if point_distance(x, y, _pot.x, _pot.y) < 125
				{
					inv[sel - 1] = 1
					_pot.filled -= 1
				}
			}
		}
	}
	if inv[sel - 1] = 2
	{
		if mouse_check_button(mb_left){
			if instance_exists(obj_pot)
			{
				var _pot = instance_nearest(x, y, obj_pot)
				if point_distance(x, y, _pot.x, _pot.y) < 125
				{
					if _pot.boiling > (obj_game.hourlen * .75) then inv[sel - 1] = 21
				}
			}
		}
	}
	#endregion 
	#region NOTEBOOK
	if inv[sel - 1] = 22
	{
		if mouse_check_button_pressed(mb_left){
			if notebookarray[0] = 1 and mouse_x > 36 and mouse_x < 388 and mouse_y > 32 + pos.z * FSH and mouse_y < 500 + pos.z * FSH and notebookarray[1] > 0 then notebookarray[1] --
			else if notebookarray[0] = 1 and mouse_x > 420 and mouse_x < 772 and mouse_y > 36 + pos.z * FSH and mouse_y < 500 + pos.z * FSH and notebookarray[1] < 4 then notebookarray[1] ++
			else if notebookarray[0] = 1 then notebookarray[0] = 0 else notebookarray[0] = 1
		}
		if notebookarray[0] = 1
		{
			if keyboard_check_pressed(ord("R")) and notebookarray[1] > 0 then notebookarray[1] --
			if keyboard_check_pressed(ord("T")) and notebookarray[1] < 4 then notebookarray[1] ++
		}
	}
	else
	{
		notebookarray[0] = 0
	}
	#endregion
}
#endregion

 
saltlastpos = [mouse_x, mouse_y]
if win[1] <= 0 then mvroom(rm_end)
if win[0] = 1 then instance_create_layer(0, 0, "game", obj_star)
if win[0] = 1 then instance_create_layer(0, 0, "game", obj_star)


audio_listener_position(x, y, depth)