/// @description Insert description here
// You can write your code in this editor

// Only update player movement when the player is on the grid
if ((x - old_x) % GRID_SIZE == 0 and (y - old_y) % GRID_SIZE == 0) {
	old_x = x
	old_y = y
	
	var x_vec = keyboard_check(vk_right) - keyboard_check(vk_left);
	var y_vec = keyboard_check(vk_down) - keyboard_check(vk_up);
	
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
	if place_meeting(x_check, y_check, obj_wall) {
		// Don't allow the player to move through walls!
		speed = 0	
	}
	if instance_place(x_check, y_check, obj_sponge) != noone {
		// The player is moving to where a sponge is located.
		// At this point, we need to decide if the the sponge can be moved
		var sponge = instance_place(x_check, y_check, obj_sponge)
		switch (sponge.state_var) {
			case 4:
				// In this case, the sponge can always be moved. 
				// We will simply move the sponge to the new location.
				sponge.x = sponge.x + x_vec*GRID_SIZE
				sponge.y = sponge.y + y_vec*GRID_SIZE
			case 3:
				// In this case, 
		}
		
	}
}

