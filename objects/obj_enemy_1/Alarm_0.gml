if frozen = false
{
	alarm[0] = irandom_range(10, 30)
	path()
}

audio_falloff_set_model(audio_falloff_inverse_distance)
audio_emitter_falloff(emitter, .75, 1500, 5);
audio_play_sound_on(emitter, bugcrawl, true, 10, 69);
