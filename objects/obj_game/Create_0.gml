gpu_set_cullmode(false)
application_surface_enable(true)
scr_start()
randomize()
if global.ready = false then alarm[2] = 4
el = [[obj_enemy_1, 88], [obj_enemy_2, 100], [obj_enemy_3, 125], [obj_enemy_4, 161], [obj_enemy_5, 24], [obj_enemy_6, 1550]] // enemies list
ae = [0, 0, 0, 0, 0, 0] // active enemiese
e = [] // enemies
difficulty = -1
minute = 0
hour = 0
if difficulty = -1{
	hourlen = 5400 / 5
	minutelen = hourlen / 60}
if difficulty = 0{
	hourlen = 54000 / 8
	minutelen = hourlen / 60}
if difficulty = 1{
	hourlen = 54000 / 4
	minutelen = hourlen / 60}
if difficulty = 2{
	hourlen = 54000 / 2
	minutelen = hourlen / 60}

alarm[0] = 3
alarm[1] = minutelen

audio_play_sound(ambient, 4, true)


//30 = 1 sec
//1800 = 1 min
//108000 = 1 hour
//54000 = 30 min, game length

