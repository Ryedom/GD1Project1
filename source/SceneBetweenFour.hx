package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import flixel.util.FlxTimer;
import flixel.FlxG;

class SceneBetweenFour extends FlxState
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
		_bg.setBg("assets/images/CutsceneAssets/plv3_0016_bg.png");
		add(_bg);
		
		_char = new Array();
		
		_char[0] = new EventImage();
		_char[0].setImage("assets/images/CutsceneAssets/plv3_0015_fridge.png", 1280, 720);
		_char[0].setPosition(0, 0);
		_char[0].changeFloorHeight(0);	
				
		_char[1] = new EventImage();
		_char[1].setImage("assets/images/CutsceneAssets/plv3_0010_fridge_cans.png", 1280, 720);
		_char[1].setPosition(0, 0);
		_char[1].changeFloorHeight(0);	
				
		_char[2] = new EventImage();
		_char[2].setImage("assets/images/CutsceneAssets/plv3_0013_mom.png", 1280, 720);
		_char[2].setPosition(0, 0);
		_char[2].changeFloorHeight(0);	
				
		_char[3] = new EventImage();
		_char[3].setImage("assets/images/CutsceneAssets/plv3_0012_son.png", 1280, 720);
		_char[3].setPosition(0, 0);
		_char[3].changeFloorHeight(0);	
				
		_char[4] = new EventImage();
		_char[4].setImage("assets/images/CutsceneAssets/plv3_0014_daughter.png", 1280, 720);
		_char[4].setPosition(0, 0);
		_char[4].changeFloorHeight(0);	
			
		_char[5] = new EventImage();
		_char[5].setImage("assets/images/CutsceneAssets/plv3_0011_table.png", 1280, 720);
		_char[5].setPosition(0, 0);
		_char[5].changeFloorHeight(0);	
				
		_char[9] = new EventImage();
		_char[9].setImage("assets/images/CutsceneAssets/plv3_0009_Layer 22.png", 1280, 720);
		_char[9].setPosition(0, 0);
		_char[9].changeFloorHeight(0);	
				
		_char[7] = new EventImage();
		_char[7].setImage("assets/images/CutsceneAssets/plv3_0004_Layer 17.png", 1280, 720);
		_char[7].setPosition(0, 0);
		_char[7].changeFloorHeight(0);	
				
		_char[8] = new EventImage();
		_char[8].setImage("assets/images/CutsceneAssets/plv3_0003_Layer 18.png", 1280, 720);
		_char[8].setPosition(0, 0);
		_char[8].changeFloorHeight(0);	
					
		_char[10] = new EventImage();
		_char[10].setImage("assets/images/CutsceneAssets/plv3_0002_Layer 19.png", 1280, 720);
		_char[10].setPosition(0, 0);
		_char[10].changeFloorHeight(0);	
				
		_char[6] = new EventImage();
		_char[6].setImage("assets/images/CutsceneAssets/plv3_0005_Layer 16.png", 1280, 720);
		_char[6].setPosition(0, 0);
		_char[6].changeFloorHeight(0);	
				
		_char[11] = new EventImage();
		_char[11].setImage("assets/images/CutsceneAssets/plv3_0000_Layer 21.png", 1280, 720);
		_char[11].setPosition(0, 0);
		_char[11].changeFloorHeight(0);	
				
		_char[12] = new EventImage();
		_char[12].setImage("assets/images/CutsceneAssets/plv3_0001_Layer 20.png", 1280, 720);
		_char[12].setPosition(0, 0);
		_char[12].changeFloorHeight(0);	
				
		_char[13] = new EventImage();
		_char[13].setImage("assets/images/CutsceneAssets/plv3_0008_Layer 23.png", 1280, 720);
		_char[13].setPosition(0, 0);
		_char[13].changeFloorHeight(0);	
					
		_char[14] = new EventImage();
		_char[14].setImage("assets/images/CutsceneAssets/plv3_0007_Layer 24.png", 1280, 720);
		_char[14].setPosition(0, 0);
		_char[14].changeFloorHeight(0);	
				
		_char[15] = new EventImage();
		_char[15].setImage("assets/images/CutsceneAssets/plv3_0006_Layer 25.png", 1280, 720);
		_char[15].setPosition(0, 0);
		_char[15].changeFloorHeight(0);	
	
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
