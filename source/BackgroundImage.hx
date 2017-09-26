package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxPrerotatedAnimation;
import flixel.math.FlxPoint;
import flixel.FlxObject;

class BackgroundImage extends FlxSprite{
	
	public function new(){
		super();
		loadGraphic("assets/images/CutsceneAssets/kitchen_background.png", false, 1280, 720);
		//hardcoded the size rn
	}
	
	public function setBg(background:String)
	{
		loadGraphic(background, true, 1280, 720);
	}
	
	override public function update(elapsed:Float):Void{
		super.update(elapsed);

	}

}
