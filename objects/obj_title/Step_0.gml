/// @description Insert description here
// You can write your code in this editor

if keyboard_check_pressed(ord("Z")) {
	audio_play_sound(snd_start, 0, false, 0.5);
	alarm[0] = 120;
}

timer += 1;