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
				
		case "pulling":
			scr_text("Sponges like me can be pushed *and* pulled! When moving, hold the \"Z\" key to pull a sponge. Try pulling the sponge towards the power tiles.", spr_squish);
			break;
			
		case "squishing":
			scr_text("Ok, one last thing. Sponges like me are quite squishy! Try pushing sponges into walls or other sponges to squish them and make them smaller. If you need to, you can *pull* sponges back into their original shape.", spr_squish);
			break;
			
		case "level_complete":
			scr_text("Level complete!", noone);
			
		
		// CUTSCENE DIALOGUE 
		
	}
}