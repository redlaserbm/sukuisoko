// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_change_music(new_bg){
	// Run with obj_game. Instantly stops the current bg music and plays new_bg music.
	if new_bg != asset_get_index(audio_get_name(bg_music)) {
		audio_stop_sound(bg_music);
		bg_music = audio_play_sound(new_bg,0,true); 
	}
}

