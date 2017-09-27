package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.FlxG;

class SceneBetweenOne extends FlxState
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
		_bg.setBg("assets/images/CutsceneAssets/letter_bg.jpg");
		add(_bg);
		
		_char = new Array();

		_char[0] = new EventImage();
		_char[0].setImage("assets/images/CutsceneAssets/paper.png", 1280, 720);
		_char[0].setPosition(0, 0);
		_char[0].changeFloorHeight(0);

		_char[1] = new EventImage();
		_char[1].setImage("assets/images/CutsceneAssets/l_hand.png", 1280, 720);
		_char[1].setPosition(0, 0);
		_char[1].changeFloorHeight(0);

		_char[2] = new EventImage();
		_char[2].setImage("assets/images/CutsceneAssets/r_hand.png", 1280, 720);
		_char[2].setPosition(0, 0);
		_char[2].changeFloorHeight(0);

		_char[3] = new EventImage();
		_char[3].setImage("assets/images/CutsceneAssets/h_binary.png", 1280, 720);
		_char[3].setPosition(0, 0);
		_char[3].changeFloorHeight(0);

		_char[4] = new EventImage();
		_char[4].setImage("assets/images/CutsceneAssets/sig.png", 1280, 720);
		_char[4].setPosition(0, 0);
		_char[4].changeFloorHeight(0);

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
			FlxG.switchState(new MainGameStateTwo());
		}
	}
}
