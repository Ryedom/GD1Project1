package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;

class LevelTwo extends FlxState{
	var background = new FlxSprite();
	var oil1 = new FlxSprite();
	var oil2 = new FlxSprite();
	var _nextLevel:FlxButton;
	var _topRightX: Int = 350;
	var _topRightY: Int = 81;
	
	override public function create():Void
	{
		super.create();
		background.loadGraphic("assets/images/playspace.jpg",true,1280,720);
		add(background);
		
		oil1.loadGraphic("assets/images/base_oil_block_halo.jpg",true,128,128);
		oil1.origin.set(0,0);
		oil1.scale.set(1.25,1.25);
		oil1.x = _topRightX;
		oil1.y = _topRightY + 3/4*640;
		add(oil1);
		
		oil2.loadGraphic("assets/images/base_oil_block_halo.jpg",true,128,128);
		oil2.origin.set(0,0);
		oil2.scale.set(1.25,1.25);
		oil2.x = _topRightX + 3/4*640;
		oil2.y = _topRightY + 3/4*640;
		add(oil2);
		
		_nextLevel = new FlxButton(10,10,"Next level", clickPlay);
		add(_nextLevel);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void{
		FlxG.switchState(new LevelThree());
	}
}
