package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.FlxG;

class SceneOne extends FlxState
{
	var _bg:BackgroundImage;
	
	private var _char:Array<EventImage>;
	var _totNum:Int;
	var _curNum:Int;
	var timer:FlxTimer;
	var _timerDelay:Float;
	
	override public function create():Void
	{
		_timerDelay = 0.2;
		super.create();
		timer = new FlxTimer();
		timer.start(_timerDelay);
		
		_bg = new BackgroundImage();
		add(_bg);
		
		_char = new Array();
		
		_char[0] = new EventImage();
		_char[0].setImage("assets/images/CutsceneAssets/kitchen_fridge_new.png", 1280, 720);
		_char[0].setPosition(0, 0);
		_char[0].changeFloorHeight(0);
		
		_char[1] = new EventImage();
		_char[1].setImage("assets/images/CutsceneAssets/kitchen_mom_new.png", 1280, 720);
		_char[1].setPosition(0, 0);
		_char[1].changeFloorHeight(0);
		
		_char[2] = new EventImage();
		_char[2].setImage("assets/images/CutsceneAssets/kitchen_bang_new.png", 1280, 720);
		_char[2].setPosition(0, 0);
		_char[2].changeFloorHeight(0);
		
		_char[3] = new EventImage();
		_char[3].setImage("assets/images/CutsceneAssets/kitchen_son_new.png", 1280, 720);
		_char[3].setPosition(0, 0);
		_char[3].changeFloorHeight(0);
		
	
		_char[4] = new EventImage();
		_char[4].setImage("assets/images/CutsceneAssets/kitchen_daughter_new.png", 1280, 720);
		_char[4].setPosition(0, 0);
		_char[4].changeFloorHeight(0);		
		
		_char[5] = new EventImage();
		_char[5].setImage("assets/images/CutsceneAssets/kitchen_table_new.png", 1280, 720);
		_char[5].setPosition(0, 0);
		_char[5].changeFloorHeight(0);		
		
		_char[6] = new EventImage();
		_char[6].setImage("assets/images/CutsceneAssets/kitchen_dad_new.png", 1280, 720);
		_char[6].setPosition(0,0);
		_char[6].changeFloorHeight(0);	
		
		_totNum = _char.length;
		_curNum = 0;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (_curNum < _totNum && timer.timeLeft <0.1)
		{
			add(_char[_curNum]);
			_curNum++;
			timer.start(_timerDelay);
		}
		if (FlxG.keys.pressed.UP)
		{
			FlxG.switchState(new SceneTwo());
		}
	}
}
