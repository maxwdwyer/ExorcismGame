alarm[0] = irandom_range(10, 40)
if irandom(8) == 1 then scr_lightswitch(x, y, cid, obj_player)
if irandom(8) == 1 then attacking = false
path()

audio_falloff_set_model(audio_falloff_inverse_distance)
audio_emitter_falloff(emitter, .75, 1500, 5);
audio_play_sound_on(emitter, bugcrawl, true, 10, 90);
