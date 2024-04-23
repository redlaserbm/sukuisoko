/// @description Insert description here
// You can write your code in this editor

accept_key = keyboard_check_pressed(ord("Z"));
skip_key = false;

var _textbox_x = camera_get_view_x(view_camera[0]);
var _textbox_y = camera_get_view_y(view_camera[0]);

// Additional setup
if !setup {
	setup = true;
	
	draw_set_font(fnt_terminus);
	
	// When we set a point to draw text from, we will be setting the TOP-LEFT most point of that text
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	for(var _p = 0; _p < page_number; _p++) {
		
		// Determine the length (in characters) of the text to be displayed for each page
		text_length[_p] = string_length(text[_p]);	
	}
	
	option_number = array_length(option);
	for(var _p = 0; _p < option_number; _p++) {
		// Determine the width of the textbox that will host the dialogue options
		if string_width(option[_p]) > option_width {
			option_width = string_width(option[_p]);
		}
	}
	// Don't forget to give the text some breathing room!
	option_width += 2.0*option_border_x + cursor_spacing + cursor_spr_w;
	
	// How high should the options textbox be?
	option_height = 2*option_border_y + line_sep*(array_length(option)-1) + string_height(option[array_length(option)-1]);
}

// Typewriter effect
// Don't draw text while a transition between scenes is occuring...
if draw_char < text_length[page] && obj_game.fade_time == 0 {
	draw_char += text_speed;
	draw_char = clamp(draw_char, 0, text_length[page]); 
}

var _lay_id = layer_get_id("Background");
var _back_id = layer_background_get_id(_lay_id);

// Change the background (if needed)
// The purpose of this weird flag setup is to avoid a weird visual glitch where sprites that are only intended to show after a fade transition has ended...
// also show up for the very first frame of the fade transition before disappearing
var _flag = true;
if bg[page] != noone {
	if obj_game.bg_new != bg[page] {
		_flag = false;
		obj_game.bg_new = bg[page];
	}
}

if is_visible[page] {
	invisible_offset = 0;	
} else {
	invisible_offset = 10000;	
}

// Change the music (if needed)
if sound[page] != noone {
	obj_game.bg_music_new = sound[page];	
}

// CODE FOR DRAWING TEXT AND CHARACTER SPEAKING 
if obj_game.bg_current == obj_game.bg_new {
	// General overview of procedure:
	// 1. DRAW THE PLAYER
	// 2. DRAW THE OPTIONS TEXTBOX (if necessary)
	// 3. DRAW THE NAMEPLATE
	// 4. DRAW THE REGULAR TEXTBOX
	
	// Values used for drawing the options textbox in the correct location
	var _xval = _textbox_x + textbox_x_offset + textbox_width - option_width;
	var _yval = _textbox_y + textbox_y_offset - option_height + invisible_offset;
	
	// Values used for drawing the portrait in the correct location in the presence of dialogue options
	var _portrait_x_target = 0.4*(room_width - _xval);
	var	_portrait_y_target = 0 + invisible_offset;
	
	// Draw the character that is speaking
	
	// If that character is squish, we'll have them float up and down a bit
	var _float = 0;
	if portrait[page] != noone and portrait[page] == spr_squish {
		_float = 10*sin(2*pi*(obj_game.timer/240));
	}
	
	if portrait[page] != noone {
			draw_sprite_ext(portrait[page], image[page], 640 - 175, 175 + _float + invisible_offset, 1.0, 1.0, 0, c_white, 1);	
	}
	
	// Options
	var _display_options = (page == page_number - 1) && (draw_char == text_length[page]) && option_link_id[0] != noone;
	if _display_options {
		draw_sprite_ext(textbox_spr, textbox_img, _xval, _yval, option_width/textbox_spr_w, option_height/textbox_spr_h, 0, c_white, alpha);
	
		// Use the arrow keys to allow us to scroll through options
		var _vert = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);
		var _nudge = 0;
	
		// Draw each option available to the player. 
		// Draw an arrow pointing at the option currently in focus.
		option_pos += _vert;
		option_pos = clamp(option_pos, 0, array_length(option)-1);
	
		for (var _i = 0; _i < array_length(option); _i++) {
		
			var _x1 = _xval + option_border_x + cursor_spr_w + cursor_spacing;
			var _y1 = _yval + option_border_y + _nudge;
		
			var _drawoption = option[_i];
			var _color = make_color_rgb(255,255,255);
			draw_text_ext(_x1, _y1, _drawoption, line_sep, line_width);
		
			if _i == option_pos {
				draw_sprite_ext(spr_cursor, 0, _x1 - cursor_spr_w - cursor_spacing, _y1 + 3, 1,1,0,_color, 1);
			}
			_nudge += line_sep;
		}
	}
	
	// Draw the nameplate and the name of the person speaking, provided that such a person exists
	var _drawtext = ds_map_find_value(global.speaker, portrait[page]);
	if !is_undefined(_drawtext) {
		textbox_img += textbox_img_speed;
		textbox_spr_w = sprite_get_width(textbox_spr);
		textbox_spr_h = sprite_get_height(textbox_spr);
		draw_sprite_ext(textbox_spr, textbox_img, _textbox_x + nameplate_x_offset, _textbox_y + nameplate_y_offset + invisible_offset, (string_width(_drawtext) + 2*text_border_x)/textbox_spr_w, nameplate_height/textbox_spr_h, 0, c_white, alpha);

		// Draw the name of the person speaking
		draw_text_ext(_textbox_x + nameplate_x_offset + text_border_x, _textbox_y + nameplate_y_offset + nameplate_border_y + invisible_offset, _drawtext, line_sep, line_width);
	}
	
	// Draw the textbox
	draw_sprite_ext(textbox_spr, textbox_img, _textbox_x + textbox_x_offset, _textbox_y + textbox_y_offset + invisible_offset, textbox_width/textbox_spr_w, textbox_height/textbox_spr_h, 0, c_white, alpha);

	// Draw the text on the textbox
	_drawtext = string_copy(text[page], 1, draw_char);
	draw_set_color(make_color_rgb(255,255,255));
	draw_text_ext(_textbox_x + textbox_x_offset + text_border_x, _textbox_y +  textbox_y_offset + text_border_y + invisible_offset, _drawtext, line_sep, line_width);
	
	// CODE FOR PAGE FLIPPING

	// If options dialogue is NOT present, advance the dialogue upon clicking.
	// If options dialogue is present, advance the dialogue provided that we click on an option.
	// For presentation's sake, do not allow the player to advance dialogue while the game is transitioning from background to background.
	if ((accept_key && !_display_options) || (accept_key && _display_options && option_pos != noone)) && timer > 2 && obj_game.fade_time == 0 {
		// Has all the text for the current page displayed yet?
		if draw_char < text_length[page] {
			// No. This skips the typing effect and writes out all the text immediately
			draw_char = text_length[page];
		}
		else {
			// Yes! Is there still more pages of text to display?
			if page < page_number - 1 {
				// Yes, there is!
				page++;
				draw_char = 0;
			} else {
				instance_destroy();

			}
		}
	}

	if skip_key {
		// Are there dialogue options the player needs to choose from?
		if option_link_id[0] == noone {
			// No, there aren't, we can end the textbox dialogue right away
			instance_destroy();
		} else {
			// Yes, there are!
			// Immediately display the last page of text
			page = page_number - 1;
			draw_char = text_length[page];
			
		}
	}
}


//draw_text(50, 250, timer);
//draw_text(50,300,draw_char);
//draw_text(50,200,invisible_offset);





