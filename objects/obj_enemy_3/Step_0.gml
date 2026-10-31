Pos.x = x
Pos.y = y
Pos.z = floor(Pos.y / FSH)
path_follow(Pos, pathqueue, 9)

traila[0, 0] = x
traila[0, 1] = y
trail(traila, 38)

cid = scr_cid(Pos)

if collision_line(x, y, obj_player.x, obj_player.y, col, false, false) = noone{
	//alarm[1] = 480
	state = 2
}
else if state != 0 then state = 1

if instance_place(x, y, obj_doorway){
	var _door = instance_place(x, y, obj_doorway)
	if _door.open = 0 then scr_opendoor(x, y)
}

	audio_emitter_position(emitter, x, y, obj_player.depth)