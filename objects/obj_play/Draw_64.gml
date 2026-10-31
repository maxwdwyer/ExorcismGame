draw_text_ext_transformed(16, 16, "Press tab for controls.", 1, 9999, 1.5, 1.5, 0)
if keyboard_check_direct(vk_tab){
	draw_text_ext_transformed(16, 16 + (1 * 20), "WASD or arrow keys to move.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (2 * 20), "Press 1, 2, or 3 to switch inventory slot.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (3 * 20), "Most items need to be equiped to be used.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (4 * 20), "Click to use most items.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (5 * 20), "E and Q to interact, interactable items will tell you which to use.", 1, 9999, 1.5, 1.5, 0)
	draw_text_ext_transformed(16, 16 + (6 * 20), "Use Z to drop items.", 1, 9999, 1.5, 1.5, 0)
	//draw_text_ext_transformed(16, 20 + (7 * 20), "Note, this game is meant to be an information based roguelite", 1, 9999, 1.5, 1.5, 0)
}