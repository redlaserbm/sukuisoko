/// @description Insert description here
// You can write your code in this editor
if speed == 0 {
	old_x = x;
	old_y = y;
} else if ((x - old_x) % GRID_SIZE == 0) and ((y - old_y) % GRID_SIZE == 0) {
	// If the sponge's speed is not 0, try to stop it if its travelled by a grid-divisible amount.
	// I say "try" because this can be overrun by the obj_player's step event
	speed = 0;
}