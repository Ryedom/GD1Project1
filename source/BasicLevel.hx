package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;

class BasicLevel extends FlxState
{
	var background = new FlxSprite();
	var oil1 = new FlxSprite();
	var _nextLevel:FlxButton;
	
	override public function create():Void
	{
		super.create();
		background.loadGraphic("assets/images/playspace.jpg",true,1280,720);
		add(background);
		oil1.loadGraphic("assets/images/base_oil_block_halo.jpg",true,128,128);
		oil1.origin.set(0,0);
		oil1.scale.set(5/3,5/3);
		oil1.x = 350 + (1/3 * 640);	
		oil1.y = 81 + (2/3 * 640);
		add(oil1);
		
		_nextLevel = new FlxButton(10,10,"Next level", clickPlay);
		add(_nextLevel);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void{
		FlxG.switchState(new LevelOne());
	}
}
