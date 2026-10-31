global.itemcount = 0
global.items = []
function scr_add_item(_obj){
	array_push(global.items, [_obj, object_get_sprite(_obj), string_delete(object_get_name(_obj), 0, 4), global.itemcount])
	global.itemcount += 1
}

function scr_find_item_num(_obj){
	var _num = 0
	for (var _i = 0; _i < array_length(global.items); _i += 1){
		if global.items[_i, 0] == _obj then _num = global.items[_i, 3]
	}
	return _num + 1
}

function scr_ready_items(){
	scr_add_item(obj_cup) // 1
	scr_add_item(obj_dirtysalt) // 2
	scr_add_item(obj_cross) // 3
	scr_add_item(obj_knife) // 4
	scr_add_item(obj_candle) // 5
	scr_add_item(obj_basementkey) // 6
	scr_add_item(obj_attickey) // 7
	scr_add_item(obj_note1) // 8
	scr_add_item(obj_note2) // 9
	scr_add_item(obj_clock) // 10
	scr_add_item(obj_book) // 11
	scr_add_item(obj_note3) // 12
	scr_add_item(obj_medicine) // 13
	scr_add_item(obj_meat) // 14
	scr_add_item(obj_watercup) // 15
	scr_add_item(obj_pot) // 16
	scr_add_item(obj_note4) // 17
	scr_add_item(obj_note5) // 18
	scr_add_item(obj_note6) // 19
	scr_add_item(obj_note7) // 20
	scr_add_item(obj_purifiedsalt) // 21
	scr_add_item(obj_notebook) // 22
}
