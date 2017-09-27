package;

import flixel.FlxState;
import flixel.addons.ui.FlxUIState;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.addons.transition.*;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileSquare;
import flixel.addons.transition.TransitionData.TransitionType;

class InstructionScene extends TransitionSetup
{
	var _bg:BackgroundImage;
	
	override public function create():Void
	{
		
		super.create();
		
		_bg = new BackgroundImage();
		_bg.setBg("assets/images/CutsceneAssets/instructions.png");
		add(_bg);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.pressed.ANY)
		{
			FlxG.switchState(new MenuState());
		}
	}
}
