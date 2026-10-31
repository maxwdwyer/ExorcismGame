for (var _i = 0; _i < array_length(e); _i += 1){
	var _place = e[_i]
	if is_array(_place){
		if e[_i, 1] > 0 {
			e[_i, 1] -= 1}
		else{
			instance_destroy(e[_i, 0])
			array_delete(e, _i, 1)}
	}
}