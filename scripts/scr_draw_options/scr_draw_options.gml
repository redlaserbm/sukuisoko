// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_draw_options(_xval, _yval, _options, _alignment = "center_center") {
	
	// _xval & _yval set by default the *center* point to draw the text from
	// To begin, we need to infer what that center point is by computing the height and width of the options_box...
	// 
	
	// This is for a drawing a textbox with clickable options that lead to other things...
	draw_sprite_ext(textbox_spr, textbox_img, _xval, _yval, option_width/textbox_spr_w, option_height/textbox_spr_h, 0, c_white, alpha);
	
		// Highlight the option currently being hovered over by the mouse, if such an option exists.
		var _mx = mouse_x;
		var _my = mouse_y;
		var _nudge = 0;
	
		// Draw each option available to the player. 
		// If that option is currently being hovered over by the mouse, *highlight* that option...
		var _hover_pos = noone;
		for (var _i = 0; _i < array_length(option); _i++) {
		
			var _x1 = _xval + 1.25*option_border_x;
			var _y1 =  _yval + option_border_y + _nudge;
			if point_in_rectangle(_mx, _my, _x1, _y1, _x1 + string_width(option[_i]), _y1 + string_height(option[_i])) {
				_hover_pos = _i;
				draw_sprite_stretched
				(
					spr_black,
					0,
					_x1, 
					_y1,
					string_width(option[_i]), //width
					string_height(option[_i]) //height
				);
				if accept_key {
					option_pos = _i;
				}
			}
		
			var _drawoption = option[_i];
			var _color = make_color_rgb(255,255,255);
			if _i == _hover_pos {
				draw_text_colour(_x1, _y1, _drawoption, _color, _color, _color, _color, 255);
			} else {
				draw_text_ext(_x1, _y1, _drawoption, line_sep, line_width);
			}
		
			_nudge += line_sep;
		}
}