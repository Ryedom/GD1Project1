package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.FlxG;

class SceneTwo extends FlxState
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
		_bg.setBg("assets/images/CutsceneAssets/leavingforworksetup_background.png");
		add(_bg);
		
		_char = new Array();
		
		_char[0] = new EventImage();
		_char[0].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[0].setPosition(92, 0);
		_char[0].changeFloorHeight(720-400);
		
		_char[1] = new EventImage();
		_char[1].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[1].setPosition(183, 0);
		_char[1].changeFloorHeight(720-330);
		
		_char[2] = new EventImage();
		_char[2].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[2].setPosition(416, 0);
		_char[2].changeFloorHeight(720 - 350);
		
		_char[3] = new EventImage();
		_char[3].setImage("assets/images/CutsceneAssets/leavingforworksetup_house.png", 510, 390);
		_char[3].setPosition(1025-510/2, 0);
		_char[3].changeFloorHeight(720 - 325);
		
		_char[4] = new EventImage();
		_char[4].setImage("assets/images/CutsceneAssets/leavingforworksetup_father.png", 343, 562);
		_char[4].setPosition(643, 0);
		_char[4].changeFloorHeight(50);
		
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
			FlxG.switchState(new SceneThree());
		}
	}
}
