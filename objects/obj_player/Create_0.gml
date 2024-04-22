/// @description Insert description here
// You can write your code in this editor

player_speed = 2;

depth = -2;

old_x = x;
old_y = y;

sponge = noone;
pull_sponge = noone;

current_state = 0;
state = {
	xpos : x,
	ypos : y
}
scr_update_state(self, state);