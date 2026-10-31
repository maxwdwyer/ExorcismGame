if place_meeting(x, y, obj_salt_dirty){
	var _other = instance_place(x, y, obj_salt_dirty)
	instance_destroy(_other)
}