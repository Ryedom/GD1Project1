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
		_char[0].setImage("assets/images/CutsceneAssets/kitchen_fridge.png", 408, 546);
		_char[0].setPosition(75, 0);
		_char[0].changeFloorHeight(205);
		
		_char[1] = new EventImage();
		_char[1].setImage("assets/images/CutsceneAssets/kitchen_mom.png", 457, 624);
		_char[1].setPosition(205+100, 0);
		_char[1].changeFloorHeight(205);
		
		_char[2] = new EventImage();
		_char[2].setImage("assets/images/CutsceneAssets/kitchen_bang.png", 330, 281);
		_char[2].setPosition(587-256+50+100, 0);
		_char[2].changeFloorHeight(515);
		
		_char[3] = new EventImage();
		_char[3].setImage("assets/images/CutsceneAssets/kitchen_son.png", 490, 546);
		_char[3].setPosition(Math.round((100+721 - 257) * (1280 / 1080)));
		_char[3].changeFloorHeight(85);
		
	
		_char[4] = new EventImage();
		_char[4].setImage("assets/images/CutsceneAssets/kitchen_daughter.png", 306, 624);
		_char[4].setPosition(Math.round((325+721 - 257) * (1280 / 1080)));
		_char[4].changeFloorHeight(85);		
		
		_char[5] = new EventImage();
		_char[5].setImage("assets/images/CutsceneAssets/kitchen_table.png", 510, 546);
		_char[5].setPosition(Math.round((190+721 - 257) * (1280 / 1080)));
		_char[5].changeFloorHeight(0);		
		
		_char[6] = new EventImage();
		_char[6].setImage("assets/images/CutsceneAssets/kitchen_dad.png", 510, 702);
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
