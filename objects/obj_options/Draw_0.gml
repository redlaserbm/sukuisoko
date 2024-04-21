/// @description Insert description here
// You can write your code in this editor

accept_key = mouse_check_button_pressed(mb_left);

var _textbox_x = camera_get_view_x(view_camera[0]);
var _textbox_y = camera_get_view_y(view_camera[0]);

// Additional setup
if !setup {
	setup = true;
	
	// draw_set_font(global.font_main);
	draw_set_font(fnt_babydoll);
	
	// When we set a point to draw text from, we will be setting the TOP-LEFT most point of that text
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	option_number = array_length(option);
	for(var _p = 0; _p < option_number; _p++) {
		// Determine the width of the textbox that will host the dialogue options
		if string_width(option[_p]) > option_width {
			option_width = string_width(option[_p]);
		}
	}
	// Don't forget to give the text some breathing room!
	option_width += 2*option_border_x + cursor_space;
	
	// How high should the options textbox be?
	option_height = 2*option_border_y + line_sep*(array_length(option)-1) + string_height(option[array_length(option)-1]);
}












