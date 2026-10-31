if filled <= 0{
	state = 1
}
if boiling > (obj_game.hourlen * .75){
	state = 2
}

if point_distance(stove.x, stove.y, x, y) < 25
{
	boiling += 1
}
//show_debug_message(state)
