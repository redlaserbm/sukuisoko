/// @description Insert description here
// You can write your code in this editor

if !init_setup {
	init_setup = true;
}

// Check whether the level has been beaten
var beaten = true;
for (var i = 0; i < instance_number(obj_sponge); ++i)
{
    var sponge = instance_find(obj_sponge,i);
	if (not sponge.suited) or (sponge.speed != 0) {
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
	if instance_number(obj_level_complete) < 1 {
		audio_play_sound(snd_success,0,false, 0.25);
		instance_create_depth(0,0,-16000,obj_level_complete);
	}
} else {
	// Debug control
	if keyboard_check_pressed(ord("A")) and (room_exists(room_previous(room))) {
		for (var _i = 0; _i < instance_number(obj_textbox); _i++) {
			var _textbox = instance_find(obj_textbox, _i);
			_textbox.force_destroy = true;
		}
		instance_destroy(obj_textbox);
		room_goto_previous();
		room_number = room_number - 1;
	}
	if keyboard_check_pressed(ord("D")) and (room_exists(room_next(room))) {
		for (var _i = 0; _i < instance_number(obj_textbox); _i++) {
			var _textbox = instance_find(obj_textbox, _i);
			_textbox.force_destroy = true;
		}
		instance_destroy(obj_textbox);
		room_goto_next();
		room_number = room_number + 1;
	}
}

if keyboard_check_pressed(ord("R")) {
	room_restart();	
}

// Logic for determining whether to display textboxes or not...
if (room == rm_tut1) and not flags.intro {
	scr_textbox_create("intro");
	flags.intro = true;
}

if (room == rm_tut2) and flags.tutorial and not flags.tut2 {
	scr_textbox_create("pulling");
	flags.tut2 = true;
}

if (room == rm_tut3) and flags.tutorial and not flags.tut3 {
	scr_textbox_create("squishing");
	flags.tut3 = true;
}

// Undo feature
if (obj_player.current_state > 0 and keyboard_check_pressed(ord("X"))) and (instance_number(obj_level_complete) < 1) {
	var _obj_arr = [obj_player, obj_sponge];
	for (var _i = 0; _i < array_length(_obj_arr); _i++) {
		for (var _j = 0; _j < instance_number(_obj_arr[_i]); _j++) {
			var _obj = instance_find(_obj_arr[_i], _j);
			
			var _state = scr_revert_state(_obj);
		
			// For both object types, revert the position
			_obj.x = _state.xpos;
			_obj.y = _state.ypos;
			
			if (_i == 1) {
				// If the object IS a sponge
				_obj.state_arr = _state.arr;
			}
		}
	}
}









