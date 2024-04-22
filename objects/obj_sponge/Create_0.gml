/// @description Insert description here
// You can write your code in this editor

depth = -2;

// Default state array
state_arr = [
	[1,1],
	[1,1]
];

// Set the state array based on the starting sprite
switch (image_index) {
	case 0:
		state_arr = [[1,1],[1,1]];
		break;
	case 1:
		state_arr = [[1,1],[1,0]];
		break;
	case 2:
		state_arr = [[1,1],[0,1]];
		break;
	case 3:
		state_arr = [[0,1],[1,1]];
		break;
	case 4:
		state_arr = [[1,0],[1,1]];
		break;
	case 5:
		state_arr = [[0,1],[0,1]];
		break;
	case 6:
		state_arr = [[1,1],[0,0]];
		break;
	case 7:
		state_arr = [[1,0],[1,0]];
		break;
	case 8:
		state_arr = [[0,0],[1,1]];
		break;
		
}

// Tracks the area of the sponge 
state_var = 4;

old_x = x;
old_y = y;

// Tracks whether all portions of the sponge lie on obj_goal or not
suited = false;

current_state = 0;
state = {
	xpos : x,
	ypos : y,
	arr: state_arr
}
scr_update_state(self, state);










