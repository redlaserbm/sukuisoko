// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @param _text_id
function scr_dialogue(_text_id){
	
	switch(_text_id) {
		case "intro":
			scr_text("Hi, I'm squish, and I'm here to show you how to play the game! Is this your first time playing?", spr_squish);
			scr_option("Yes, it is!", "tut_yes");
			scr_option("No, it isn't.", "tut_no");
			break;
				
			case "tut_yes":
				scr_text("Cool, let me teach you how to play then!", spr_squish);
				scr_text("Sponges like me offer surges of electrical current that can be harnessed into electricity that can be used to power our society. Pretty cool right?", spr_squish);
				scr_text("To harness this source of energy, you need to move the sponges so that they lie perfectly on top of *power tiles* that placed throughout the map. Try it now!",spr_squish);
				break;
				
			case "tut_no":
				scr_text("Cool, uhh.... good luck broski.", spr_squish);
				obj_game.flags.tutorial = false; // Disables all further tutorial dialogue.
				break;
			
		
		// CUTSCENE DIALOGUE 
		
	}
}