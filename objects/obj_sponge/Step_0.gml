/// @description Insert description here
// You can write your code in this editor

// Update the area of the sponge
state_var = scr_arr2d_sum(state_arr)

switch (state_var) {
	case 4:
		var ne_col = position_meeting(x + GRID_SIZE/2 , y - GRID_SIZE/2, obj_wall);
		var nw_col = position_meeting(x - GRID_SIZE/2 , y - GRID_SIZE/2, obj_wall);
		var sw_col = position_meeting(x - GRID_SIZE/2 , y + GRID_SIZE/2, obj_wall);
		var se_col = position_meeting(x + GRID_SIZE/2 , y + GRID_SIZE/2, obj_wall);
		
		if ne_col {state_arr[0][1] = 0;}
		if nw_col {state_arr[0][0] = 0;}
		if sw_col {state_arr[1][0] = 0;}
		if se_col {state_arr[1][1] = 0;}
		break;
}










