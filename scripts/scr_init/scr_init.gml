// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
speaker = ds_map_create();
ds_map_add(speaker, spr_squish, "squish");

// Set loop points for music tracks as deemed necessary
audio_sound_loop_start(snd_think, 21.333);

// The maximum number of times the player can undo
max_states = 50;