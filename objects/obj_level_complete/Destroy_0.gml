/// @description Insert description here
// You can write your code in this editor
if room_exists(room_next(room)) {
	obj_game.room_number += 1;
	room_goto_next();	
}