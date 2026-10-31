
if ready == false
{
	global.room_ids ++
	cid = global.room_ids
	for (var _i = 0; _i < array_length(ctouching); _i += 1){
		if cid = ctouching[_i, 0] then cid = ctouching[_i, 1]}
	ready = true
}