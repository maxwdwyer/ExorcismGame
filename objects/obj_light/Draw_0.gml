//draw_self()

var _w = backvp[2] - backvp[0]
var _h = backvp[3] - backvp[1]

if start = true then background = sprite_create_from_surface(application_surface, backvp[0], backvp[1] - camera_get_view_y(view_camera[0]), _w, _h, false, false, 0, 0)

if start = true then lightspr = scr_draw_lights(lights, pos, backvp)
if start = true then start = false

shader_set(shd_lighting3)
var _back = shader_get_sampler_index(shd_lighting3, "background")
var _spr = sprite_get_texture(background, 0)
texture_set_stage(_back, _spr)

if start = false and on = true then draw_sprite(lightspr, 0, backvp[0], backvp[1])

shader_reset()
