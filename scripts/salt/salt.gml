function salt(_obj){
	if instance_number(_obj) >= 3{
		//GROUPING----------------------------------------------------
		var _allarrays = []
		var _array = []
		var _last = instance_find(_obj, 0)
		array_push(_array, _last)
		for (var _i = 1; _i < instance_number(_obj); _i += 1){
			var _inst = instance_find(_obj, _i)
			draw_set_color(c_green)
			if point_distance(_last.x, _last.y, _inst.x, _inst.y) < 70
			{
				//draw_line_width(_last.x, _last.y, _inst.x, _inst.y, 5)
			}
			else {
				array_push(_allarrays, _array)
				_array = []
			}
		_last = _inst
		array_push(_array, _inst)
		}
		array_push(_allarrays, _array)
		//CHECK FOR ROUNDNESS-----------------------------------------
		var _goodcircles = []
		for (var _e = 0; _e < array_length(_allarrays); _e += 1){
			var _circle = true
			_array = _allarrays[_e]
			var _mid = [0, 0]
			for (var _i = 0; _i < array_length(_array); _i += 1){
				var _inst = _array[ _i]
				_mid[0] += _inst.x
				_mid[1] += _inst.y
			}
			_mid[0] = _mid[0] / array_length(_array)
			_mid[1] = _mid[1] / array_length(_array)
			var _len = array_length(_array)
			if _len > 5 {
				var _dist = (point_distance(_mid[0], _mid[1], _array[1].x, _array[1].y) + point_distance(_mid[0], _mid[1], _array[floor(_len / 1.5)].x, _array[floor(_len / 1.5)].y) + point_distance(_mid[0], _mid[1], _array[floor(_len / 3)].x, _array[floor(_len / 3)].y)) / 3}
			else{
				var _dist = point_distance(_mid[0], _mid[1], _array[0].x, _array[0].y)
			}
			for (var _i = 0; _i < array_length(_array); _i += 1){
				var _w = 17.5 * clamp(_dist / 100, .5, 5) - abs((_dist - point_distance(_mid[0], _mid[1], _array[_i].x, _array[_i].y)) / 2)
				if _w < 0 or _w > 50 then _circle = false
				//draw_line_width(_mid[0], _mid[1], _array[_i].x, _array[_i].y, _w)
			}
			if _circle = true then array_push(_goodcircles, [_mid, _dist])
		}
		//show_debug_message(_goodcircles)
		//CHECK FOR GAME END---------------------------------------------
		var _f0c = false
		var _f1c = false
		for (var _i = 0; _i < array_length(_goodcircles); _i += 1){
			var _circle = _goodcircles[_i]
			{
				var _floor = floor(_circle[0, 1] / FSH)
				if _floor = 0{
					var _cnum = instance_number(obj_candle)
					var _closecandlenum = 0
					if _cnum > 0{
						for (var _q = 0; _q < _cnum; _q += 1){
							var _tcan = instance_find(obj_candle, _q)
							if point_distance(_circle[0, 0], _circle[0, 1], _tcan.x, _tcan.y) < _circle[1] + 16{
								_closecandlenum += 1
							}
						}
						
					if instance_number(obj_enemy_1) > 0{ 
						var _bug = instance_nearest(_circle[0, 0], _circle[0, 1], obj_enemy_1)
						//show_debug_message(["candles: ", _closecandlenum])
						if _closecandlenum = 3 and point_distance(_circle[0, 0], _circle[0, 1], _bug.x, _bug.y) < _circle[1] - 24
						{
							_f0c = true
							_bug.frozen = true
						}
						}
					}
				}
				if _floor = 1{
					if instance_number(obj_cross) > 0{ 
						var _cross = instance_nearest(_circle[0, 0], _circle[0, 1], obj_cross)
						if point_distance(_circle[0, 0], _circle[0, 1], _cross.x, _cross.y) < _circle[1] + 24 then _f1c = true
					}
				}
			}
		}
		//show_debug_message(["FLOOR 1 CIRCLE: ", _f0c])
		//show_debug_message(["FLOOR 2 CIRCLE: ", _f1c])
		if _f0c = true and _f1c = true then obj_player.win[0] = 1
	}
	draw_set_color(c_white)
}