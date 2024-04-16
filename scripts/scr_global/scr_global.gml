// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

#macro GRID_SIZE 32

function scr_arr2d_sum(arr2d){
	var N = array_length(arr2d[0]);
	var M = array_length(arr2d);
	
	var val = 0;
	for (var i = 0; i < M; i++) {
		for (var j = 0; j < N; j++) {
			val = val + arr2d[i][j]
		}
	}
	
	return val;
}

function scr_convert(arr2d) {
	var pow = 0;
	var val = 0;
	for (var i = 0; i < 2; i++) {
		for (var j = 0; j < 2; j++) {
			val = val + arr2d[i][j]*power(2,pow);
			pow++;
		}
	}
	return val;
}

function scr_side_type(state_arr, dir) {
	// Returns 1 if we're pushing a crooked edge and a 2 if we're pushing a flat edge
	// Return -1 in case of bad argument...
	var val = 0;
	if (dir == 0) {
		val = state_arr[0][0] + state_arr[1][0];
	} else if (dir == 90) {
		val = state_arr[1][0] + state_arr[1][1];
	} else if (dir == 180) {
		val = state_arr[0][1] + state_arr[1][1];
	} else if (dir == 270) {
		val = state_arr[0][0] + state_arr[0][1];
	} else {
		val = -1;
	}
	return val;
}

function scr_squish(state_arr, dir) {
	// Helper function for handling obstructed movement of 3-blocks	
	// Returns a full state array in case of bad argument
	if (dir == 0) {
		state_arr[0][0] = 0;
		state_arr[1][0] = 0;	
	} else if (dir == 90) {
		state_arr[1][0] = 0; 
		state_arr[1][1] = 0;
	} else if (dir == 180) {
		state_arr[0][1] = 0;
		state_arr[1][1] = 0;
	} else if (dir == 270) {
		state_arr[0][0] = 0;
		state_arr[0][1] = 0;
	} else {
		state_arr = [[1,1],[1,1]];
	}
	
	return state_arr
}