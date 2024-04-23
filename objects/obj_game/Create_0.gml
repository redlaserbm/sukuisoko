/// @description Insert description here
// You can write your code in this editor
room_number = 1;

// Flags
flags = {
	tutorial: true,
	// Starts off as true, switches to false if the player chooses to
	// skip the tutorial dialogue.
	
	intro: false,
	// Triggers when the intro dialogue is called.
	
	tut2: false,
	tut3: false
}

// Unused variable
fade_time = 0;
bg_current = noone;
bg_new = noone;

bg_music = noone;
init_setup = false;

alarm[0] = 60;
timer = 0;