alarm[0] = irandom_range(5, 15)
if state = 1 and path_position = 0 or path_position >= .98 path()
if state = 2 then path()


audio_falloff_set_model(audio_falloff_inverse_distance)
audio_emitter_falloff(emitter, .75, 1500, 5);
audio_play_sound_on(emitter, bugcrawl, true, 10, 100);

