package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.FlxG;

class InstructionScene extends FlxState
{
	var _bg:BackgroundImage;
	

	
	override public function create():Void
	{
		_bg = new BackgroundImage();
		_bg.setBg("assets/images/CutsceneAssets/kitchen_bkgrnd.png");
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
