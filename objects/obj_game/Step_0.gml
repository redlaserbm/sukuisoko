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

for (var i = 0; i < instance_number(obj_goal); ++i)
{
    var goal = instance_find(obj_goal,i);
	if not goal.collide {
		beaten = false;
		break;
	}
}

if beaten {
	room_goto_next();	
	room_number++;
} else {
	// Debug control
	if keyboard_check_pressed(ord("A")) and (room_exists(room_previous(room))) {
		room_goto_previous();
		room_number = room_number - 1;
	}
	if keyboard_check_pressed(ord("D")) and (room_exists(room_next(room))) {
		room_goto_next();
		room_number = room_number + 1;
	}
}

// Logic for determining whether to display textboxes or not...
if (room == rm_tutorial) and not flags.intro {
	scr_textbox_create("intro");
	flags.intro = true;
}










