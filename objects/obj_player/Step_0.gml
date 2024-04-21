/// @description Insert description here
// You can write your code in this editor

// Only update player movement when the player is on the grid
if ((x - old_x) % GRID_SIZE == 0 and (y - old_y) % GRID_SIZE == 0) and (instance_number(obj_textbox) <= 0) {
	old_x = x
	old_y = y
	
	sponge = noone;
	pull_sponge = noone;
	
	var x_vec = keyboard_check(vk_right) - keyboard_check(vk_left);
	var y_vec = keyboard_check(vk_down) - keyboard_check(vk_up);
	var pull = keyboard_check(ord("Z"));
	
	if x_vec != 0 {
		// Only consider one direction at a time! If the x_vec has a nonzero value...
		// Make the y_vec value 0
		y_vec = 0;
	}
	
	speed = player_speed;
	if x_vec == 1 {
		direction = 0;
	} else if x_vec == -1 {
		direction = 180;
	} else if y_vec == 1 {
		direction = 270;
	} else if y_vec == -1 {
		direction = 90;
	} else {
		direction = 0;
		speed = 0;
	}
	
	// After setting speed and direction, decide if the player is able to move.
	var x_check = x + x_vec*GRID_SIZE
	var y_check = y + y_vec*GRID_SIZE
	
	// Wall check. Don't allow the player to move through walls!
	if position_meeting(x_check, y_check, obj_wall) {
		speed = 0	
	}
	
	var push_x = 0.5*GRID_SIZE*cos(pi*direction/180);
	var push_y = -0.5*GRID_SIZE*sin(pi*direction/180);
				
	var search_x = 0.5*GRID_SIZE*cos(pi*(direction+90)/180);
	var search_y = -0.5*GRID_SIZE*sin(pi*(direction+90)/180);
	
	// Push check. If the player is moving to where a sponge is...
	// see if they can push the sponge and move into the empty spot.
	if position_meeting(x_check, y_check, obj_sponge) and speed != 0 {
		// The player is moving to where a sponge is located.
		// At this point, we need to decide if the the sponge can be moved
		sponge = instance_position(x_check, y_check, obj_sponge)
		switch (sponge.state_var) {
			case 4:
				// In this case, the sponge can always be moved. 
				// We will simply move the sponge to the new location.
				sponge.direction = direction;
				sponge.speed = player_speed;
				break;
			case 3:
				// Are we pushing from the flat or crooked side?
				var num_blocks = scr_side_type(sponge.state_arr, direction);
				
				if num_blocks == 1 {
					// We are pushing a *crooked* side. Which end are we pushing from?
					// Are we pushing from the short end or the long end?
					var p1_x = x + 2*search_x;
					var p1_y = y + 2*search_y;
					
					var p2_x = x - 2*search_x;
					var p2_y = y - 2*search_y;
					
					var search_arr = [[p1_x,p1_y],[p2_x,p2_y]];
					
					var long_edge = true;
					for (var i = 0; i < array_length(search_arr); i++) {
						if position_meeting(search_arr[i][0],search_arr[i][1],sponge) {
							long_edge = false;
						}
					}
					
					// Is the block obstructed in *any* way in the push direction?
					var obstructed = false;
					
					var base_x = sponge.x + 3*push_x;
					var base_y = sponge.y + 3*push_y;
					
					p1_x = base_x + search_x; 
					p1_y = base_y + search_y;
					
					p2_x = base_x - search_x;
					p2_y = base_y - search_y;
					
					search_arr = [[p1_x,p1_y],[p2_x,p2_y]];
					
					for (var i = 0; i < array_length(search_arr); i++) {
						if position_meeting(search_arr[i][0],search_arr[i][1],obj_wall) or position_meeting(search_arr[i][0],search_arr[i][1],obj_sponge) {
							obstructed = true;
							break;
						}
					}
					
					// From here, we can conduct the movement logic based on the values of the booleans long_edge and obstructed...
					if (obstructed and long_edge) {
						// Keep the sponge stationary, but adjust its state array based on the direction we tried to push it in
						sponge.state_arr = scr_squish(sponge.state_arr, direction);
					} else if (not obstructed) {
						// Move the sponge
						sponge.direction = direction;
						sponge.speed = player_speed;
					} else if (obstructed and not long_edge) {
						// We cannot move the sponge
						speed = 0;
					}
					
				} else if num_blocks == 2 {
					// We are pushing a *flat* side	
					// Check if the short end is obstructed or not...
					
					// There are two points p1 and p2 to investigate, what are their coordinates?
					var base_x = sponge.x + push_x;
					var base_y = sponge.y + push_y;
					
					var p1_x = base_x + search_x;
					var p1_y = base_y + search_y;
					
					var p2_x = base_x - search_x;
					var p2_y = base_y - search_y;
					
					var search_arr = [[p1_x,p1_y],[p2_x,p2_y]];
					
					var tip_x = noone;
					var tip_y = noone;
					for (var i = 0; i < array_length(search_arr); i++) {
						// If either of the search points contains a wall or a portion of a different sponge, then we *cannot* move the player (or the box)
						if position_meeting(search_arr[i][0],search_arr[i][1],obj_wall) or (position_meeting(search_arr[i][0],search_arr[i][1],obj_sponge) and not position_meeting(search_arr[i][0],search_arr[i][1],sponge)) {
							speed = 0	
							break;
						}
						
						// Exactly *one* of the search points corresponds with the tip of the long edge. Identify and store its coordinates.
						if position_meeting(search_arr[i][0],search_arr[i][1],sponge) {
							tip_x = search_arr[i][0];
							tip_y = search_arr[i][1];
						}
					}
					
					// If we get to this point and the speed is not zero, then it's possible to move the box. 
					// We can simply move the sponge to the new location and allow its own collision logic to update its state array after the fact.
					if speed != 0 {
						sponge.direction = direction;
						sponge.speed = player_speed;
					}
				} else {
					// This *shouldn't* happen. Log a warning message in the console if it does.
					show_debug_message("Warning! Computed invalid number of blocks when computing push operation for a 3-block!");
				}
				break;
			case 2:
				var check_x = sponge.x + 2*push_x;
				var check_y = sponge.y + 2*push_y;
				var obstructed = false;
				with sponge {
					if place_meeting(check_x,check_y,obj_wall) or (place_meeting(check_x,check_y,obj_sponge) and not place_meeting(check_x,check_y,self)) {
						obstructed = true;	
					}
				}
				if obstructed {
					speed = 0;	
				} else {
					sponge.direction = direction;
					sponge.speed = player_speed;
				}
				break;
		}
		
	}
	
	// Pull check. If the player is holding down the *pull* button and they pass the wall and push checks, see if they can pull a sponge along with them.
	x_check = x - x_vec*GRID_SIZE;
	y_check = y - y_vec*GRID_SIZE;
	if position_meeting(x_check, y_check, obj_sponge) and speed != 0 and pull {
		pull_sponge = instance_position(x_check, y_check, obj_sponge);
		switch (pull_sponge.state_var) {
			case 4:
				// Remember, at this point we already know the player can move. 4-blocks can *always* be pulled, 
				// we just need to know if the pull will be obstructed or not
				pull_sponge.direction = direction;
				pull_sponge.speed = player_speed;
				break;
			case 3:
				// Are we puling from the flat side or the crooked side?
				var base_x = pull_sponge.x + push_x;
				var base_y = pull_sponge.y + push_y;
				
				var p1_x = base_x + search_x;
				var p1_y = base_y + search_y;
				
				var p2_x = base_x - search_x;
				var p2_y = base_y - search_y;
				
				var search_arr = [[p1_x,p1_y],[p2_x,p2_y]];
				
				var flat = true;
				for (var i = 0; i < array_length(search_arr); i++) {
					if not position_meeting(search_arr[i][0],search_arr[i][1],pull_sponge) {
						flat = false;
					}
				}
				
				if flat {
					// Is the pull obstructed? If so, don't perform it.	
					base_x = pull_sponge.x + 3*push_x;
					base_y = pull_sponge.y + 3*push_y;
					
					p1_x = base_x + search_x;
					p1_y = base_y + search_y;
				
					p2_x = base_x - search_x;
					p2_y = base_y - search_y;
				
					search_arr = [[p1_x,p1_y],[p2_x,p2_y]];
					var obstructed = false
					for (var i = 0; i < array_length(search_arr); i++) {
						if position_meeting(search_arr[i][0],search_arr[i][1], obj_wall) or (position_meeting(search_arr[i][0],search_arr[i][1], obj_sponge) and not position_meeting(search_arr[i][0],search_arr[i][1], pull_sponge)) {
							obstructed = true;
							break;
						}
					}
					
					if obstructed {
						speed = 0;	
					} else {
						pull_sponge.direction = direction;
						pull_sponge.speed = player_speed;	
					}
				} else {
					// Are we pulling the short end or the long end?
					var check_x = x - 4*push_x;
					var check_y = y - 4*push_y;
					
					var long_end = false;
					if position_meeting(check_x, check_y, pull_sponge) {
						long_end = true;
					}
					
					if not long_end {
						pull_sponge.state_arr = [[1,1],[1,1]];
					} else {
						// Check for an obstruction before pulling...
						base_x = pull_sponge.x + push_x;
						base_y = pull_sponge.y + push_y;
					
						p1_x = base_x + search_x;
						p1_y = base_y + search_y;
				
						p2_x = base_x - search_x;
						p2_y = base_y - search_y;
				
						search_arr = [[p1_x,p1_y],[p2_x,p2_y]];
						var obstructed = false
						for (var i = 0; i < array_length(search_arr); i++) {
							if position_meeting(search_arr[i][0],search_arr[i][1], obj_wall) or (position_meeting(search_arr[i][0],search_arr[i][1], obj_sponge) and not position_meeting(search_arr[i][0],search_arr[i][1], pull_sponge)) {
								obstructed = true;
								break;
							}
						}
						if obstructed {
							speed = 0;	
						} else {
							pull_sponge.direction = direction;
							pull_sponge.speed = player_speed;	
						}
						
					}
				}
				
				break;
			case 2:
				// Are we pulling the long end or the short end?
				x_check = x - 4*push_x;
				y_check = y - 4*push_y;
				var long_edge = false;
				if position_meeting(x_check, y_check, pull_sponge) {
					long_edge = true;
				}
				if long_edge {
					pull_sponge.direction = direction;
					pull_sponge.speed = player_speed;
				} else {
					if (direction == 0 or direction == 270) {
						pull_sponge.state_arr = [[1,1],[1,1]];
					} else if (direction == 90) {
						pull_sponge.y = pull_sponge.y - GRID_SIZE;
						pull_sponge.state_arr = [[1,1],[1,1]];
					} else if (direction == 180) {
						pull_sponge.x = pull_sponge.x - GRID_SIZE;
						pull_sponge.state_arr = [[1,1],[1,1]];	
					}
						
				}
				break;
		}
	}
	
}

