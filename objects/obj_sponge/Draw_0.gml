/// @description Insert description here
// You can write your code in this editor

var val = scr_convert(state_arr)
var ind = 0;
switch(val) {
	// Area 4 cases
	case 15: //[[1,1][1,1]]
		ind = 0;
		break;
		
	// Area 3 cases
	case 13: //[[1,0],[1,1]]
		ind = 4;
		break;
	case 14: //[[0,1][1,1]]
		ind = 3;
		break;
	case 11: //[[1,1],[0,1]]
		ind = 2;
		break;
	case 7: //[[1,1],[1,0]]
		ind = 1;	
		break;
		
	// Area 2 cases
	case 3: //[[1,1],[0,0]]
		ind = 6;
		break;
	case 5: //[[1,0],[1,0]]
		ind = 7;
		break;
	case 12: //[[0,0][1,1]]
		ind = 8;
		break;
	case 10: //[[0,1],[0,1]]
		ind = 5;
		break;
}

draw_sprite(spr_sponge, ind, x, y);










