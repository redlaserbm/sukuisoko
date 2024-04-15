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