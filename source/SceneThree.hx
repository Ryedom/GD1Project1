package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;

class SceneThree extends FlxState
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
		_bg.setBg("assets/images/CutsceneAssets/jobsetup_background.png");
		add(_bg);
		
		_char = new Array();

		_char[0] = new EventImage();
		_char[0].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[0].setPosition(130, 0);
		_char[0].changeFloorHeight(720-325);

				
		_char[1] = new EventImage();
		_char[1].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[1].setPosition(250, 0);
		_char[1].changeFloorHeight(720-345);
		
		_char[2] = new EventImage();
		_char[2].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[2].setPosition(375, 0);
		_char[2].changeFloorHeight(720-315);
	
		_char[3] = new EventImage();
		_char[3].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[3].setPosition(524, 0);
		_char[3].changeFloorHeight(720 - 332);
		
		_char[4] = new EventImage();
		_char[4].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[4].setPosition(634, 0);
		_char[4].changeFloorHeight(720-342);
		
		_char[5] = new EventImage();
		_char[5].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[5].setPosition(782, 0);
		_char[5].changeFloorHeight(720 - 352);
		
		
		_char[6] = new EventImage();
		_char[6].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[6].setPosition(912, 0);
		_char[6].changeFloorHeight(720 - 356);
		
		
		_char[7] = new EventImage();
		_char[7].setImage("assets/images/CutsceneAssets/leavingforworksetup_oiltowers.png", 204, 390);
		_char[7].setPosition(982, 0);
		_char[7].changeFloorHeight(720 - 366);
				
		_char[8] = new EventImage();
		_char[8].setImage("assets/images/CutsceneAssets/jobsetup_boss.png", 498, 612);
		_char[8].setPosition(180, 0);
		_char[8].changeFloorHeight(30);
	
		_char[9] = new EventImage();
		_char[9].setImage("assets/images/CutsceneAssets/jobsetup_player.png", 392, 490);
		_char[9].setPosition(670, 0);
		_char[9].changeFloorHeight(60);
				
		
		
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
	}
}
