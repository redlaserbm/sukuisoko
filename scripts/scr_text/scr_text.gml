// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// @param _text
// @param _character_info
// @param _bg

function scr_text(_text, _sprite = noone, _image = 0, _bg = noone, _snd = noone, _visible = true){

	text[page_number] = _text;
	portrait[page_number] = _sprite;
	image[page_number] = _image;
	bg[page_number] = _bg;
	sound[page_number] = _snd;
	is_visible[page_number] = _visible;
	
	page_number++;
}