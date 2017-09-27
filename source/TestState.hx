package;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxG;

import flixel.math.FlxPoint;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxSprite;
import flixel.text.FlxText;

class TestState extends FlxState
{
	private var _map : GameMap;
	private var _mapPath : String = AssetPaths.levelTwo__oel;
	private var _background : FlxSprite;
	private var _pipeDisplay : HUD.PipeDisplay;
	private var _pipeAmounts : Array<Int> = [1,1,1,1,1];
	private var timerText: FlxText = new FlxText(10,10,300,"300",36);
	private var timer: Float = 300;
	
	public var wonLevel: Bool = false;

	override public function create() : Void {
		var offset : FlxPoint = new FlxPoint(350,81);
		_pipeDisplay = new HUD.PipeDisplay(32,128,_pipeAmounts);
		_map = new GameMap(_mapPath,GameMap.MapTypeEnum.Playfield,offset);
		_background = new FlxSprite(0,0,AssetPaths.fin_playspace__jpg);
		FlxG.sound.playMusic(AssetPaths.underground__ogg,1,true);
		add(timerText);
	}

	override public function update(elapsed:Float) : Void {
		_map.update(elapsed);
		_pipeDisplay.RotateRight();
		super.update(elapsed);
		if (!_map.winCondition){
			timer -= elapsed;
			timer = fixedFloat(timer,4);
			timerText.text = '$timer';
			if (timer <= 0){
				FlxG.switchState(new SceneBEOne());
			}
		}
		else{
			add(new FlxText(1280/2-200,720/2-100,600,"Level Complete!",72));
		}
	}

	override public function draw() : Void {
		_background.draw();
		_map.draw();
		_pipeDisplay.draw();
		super.draw();
	}
	
	//https://gist.github.com/db/2657389
	public static function fixedFloat(v:Float, ?precision:Int = 2):Float
	{
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
}