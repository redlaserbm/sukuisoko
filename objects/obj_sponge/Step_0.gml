/// @description Insert description here
// You can write your code in this editor

// Update the area of the sponge
state_var = scr_arr2d_sum(state_arr)

var ne_col = scr_collision(x + GRID_SIZE/2 , y - GRID_SIZE/2);
var nw_col = scr_collision(x - GRID_SIZE/2 , y - GRID_SIZE/2);
var sw_col = scr_collision(x - GRID_SIZE/2 , y + GRID_SIZE/2);
var se_col = scr_collision(x + GRID_SIZE/2 , y + GRID_SIZE/2);
		
if ne_col {state_arr[0][1] = 0;}
if nw_col {state_arr[0][0] = 0;}
if sw_col {state_arr[1][0] = 0;}
if se_col {state_arr[1][1] = 0;}

// There are certain state arrays I want to avoid in order to have uniqueness of representation

var test = state_arr == [[0,1],[0,1]];
if array_equals(state_arr,[[0,1],[0,1]]) {
	x = x + GRID_SIZE;
	state_arr = [[1,0],[1,0]];
}
if array_equals(state_arr, [[0,0],[1,1]]) {
	y = y + GRID_SIZE;
	state_arr = [[1,1],[0,0]];
}










