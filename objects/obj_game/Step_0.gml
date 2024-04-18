/// @description Insert description here
// You can write your code in this editor

if keyboard_check_pressed(ord("R")) {
	room_restart();	
}

// Check whether the level has been beaten
var beaten = true;
for (var i = 0; i < instance_number(obj_sponge); ++i)
{
    var sponge = instance_find(obj_sponge,i);
	if not sponge.suited {
		beaten = false;
		break;
	}
}

if beaten {
	room_goto_next();	
}

// Debug control
if keyboard_check_pressed(ord("A")) {
	room_goto_previous();
}
if keyboard_check_pressed(ord("D")) {
	room_goto_next();
}










