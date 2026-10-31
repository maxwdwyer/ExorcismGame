target.taken = false
alarm[0] = irandom_range(100, 1500)
var _num = irandom(instance_number(obj_hiding_spot) - 1)
do{
	 _num = irandom(instance_number(obj_hiding_spot) - 1)
	target = instance_find(obj_hiding_spot, _num)
	x = target.x
	y = target.y
} until target.ptaken = false and target.taken = false
target.taken = true