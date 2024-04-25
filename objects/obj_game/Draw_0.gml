/// @description Insert description here
// You can write your code in this editor

// Show which level we're on, which is uh cool for people who get stuck on stuff

var _drawtext = string_concat("LEVEL ", room_number);

var _sw = string_width(_drawtext);
var _sh = string_height(_drawtext);

var _text_x = camera_get_view_x(view_camera[0]);
var _text_y = camera_get_view_y(view_camera[0]);

draw_set_font(fnt_terminus);

draw_set_valign(fa_top);
draw_set_halign(fa_left);

draw_set_color(make_color_rgb(255,255,255));
if room != rm_final {
	draw_text_ext(_text_x + 16, _text_y + 16, _drawtext, 0, room_width);
}

if room = rm_final {
	var _total_seconds = timer/60;
	var _seconds_part = _total_seconds % 60;
	var _minutes_part = floor(_total_seconds/60);
	
	var _drawtext2 = noone;
	if _seconds_part >= 10 {
		_drawtext2 = string_concat("Congratulations! You beat the game in ", _minutes_part, ":", _seconds_part);
	} else {
		_drawtext2 = string_concat("Congratulations! You beat the game in ", _minutes_part, ":0", _seconds_part);
	}
	_sw = string_width(_drawtext2);
	_sh = string_height(_drawtext2);
	
	draw_text_ext(_text_x + room_width/2 - _sw/2, _text_y + room_height/2 - _sh/2, _drawtext2, 0, room_width);	
}