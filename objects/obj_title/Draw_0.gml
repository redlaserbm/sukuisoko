/// @description Insert description here
// You can write your code in this editor

var _drawtext = "PRESS Z KEY";

var _sw = string_width(_drawtext);
var _sh = string_height(_drawtext);

var _text_x = camera_get_view_x(view_camera[0]);
var _text_y = camera_get_view_y(view_camera[0]);

draw_set_font(fnt_terminus);

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_color(make_color_rgb(0,0,0));

if (alarm[0] > 0 and (((alarm[0] - 1) % 30) >= 20)) or (alarm[0] <= 0) {
	draw_text_ext(_text_x + room_width/2 - _sw/2, _text_y + 300 - _sh/2, _drawtext, 0, room_width);
}