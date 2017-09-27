package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.FlxG;

class SceneBetweenThree extends FlxState
{
	var _bg:BackgroundImage;
	
	private var _char:Array<EventImage>;
	var _totNum:Int;
	var _curNum:Int;
	var timer:FlxTimer;
	var _timerDelay:Float;
	var _delayUntilGo:FlxTimer;
	
	override public function create():Void
	{
		_timerDelay = 0.2;
		super.create();
		timer = new FlxTimer();
		timer.start(_timerDelay);
		
		_delayUntilGo = new FlxTimer();
		_delayUntilGo.start(99999);
		
		_bg = new BackgroundImage();
		_bg.setBg("assets/images/CutsceneAssets/plv2_bg.png");
		add(_bg);
		
		_char = new Array();
		
		_char[0] = new EventImage();
		_char[0].setImage("assets/images/CutsceneAssets/plv2_mom.png", 1280, 720);
		_char[0].setPosition(0, 0);
		_char[0].changeFloorHeight(0);	
				
		_char[1] = new EventImage();
		_char[1].setImage("assets/images/CutsceneAssets/plv2_son.png", 1280, 720);
		_char[1].setPosition(0, 0);
		_char[1].changeFloorHeight(0);	
				
		_char[2] = new EventImage();
		_char[2].setImage("assets/images/CutsceneAssets/plv2_daughter.png", 1280, 720);
		_char[2].setPosition(0, 0);
		_char[2].changeFloorHeight(0);	
				
		_char[3] = new EventImage();
		_char[3].setImage("assets/images/CutsceneAssets/plv2_table.png", 1280, 720);
		_char[3].setPosition(0, 0);
		_char[3].changeFloorHeight(0);	
				
		_char[4] = new EventImage();
		_char[4].setImage("assets/images/CutsceneAssets/plv2_can5.png", 1280, 720);
		_char[4].setPosition(0, 0);
		_char[4].changeFloorHeight(0);	
			
		_char[5] = new EventImage();
		_char[5].setImage("assets/images/CutsceneAssets/plv2_can4.png", 1280, 720);
		_char[5].setPosition(0, 0);
		_char[5].changeFloorHeight(0);	
				
		_char[6] = new EventImage();
		_char[6].setImage("assets/images/CutsceneAssets/plv2_can3.png", 1280, 720);
		_char[6].setPosition(0, 0);
		_char[6].changeFloorHeight(0);	
				
		_char[7] = new EventImage();
		_char[7].setImage("assets/images/CutsceneAssets/plv2_can2.png", 1280, 720);
		_char[7].setPosition(0, 0);
		_char[7].changeFloorHeight(0);	
				
		_char[8] = new EventImage();
		_char[8].setImage("assets/images/CutsceneAssets/plv2_can1.png", 1280, 720);
		_char[8].setPosition(0, 0);
		_char[8].changeFloorHeight(0);	
	
		
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
		if (FlxG.keys.pressed.ANY && _delayUntilGo.elapsedTime > 2)
		{
			//FlxG.switchState(new SceneTwo());
		}
	}
}
