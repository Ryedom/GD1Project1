package;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxG;

import flixel.math.FlxPoint;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxSprite;
import flixel.text.FlxText;

class MainGameStateThree extends TransitionSetup
{
	private var _map : GameMap;
	private var _mapPath : String = AssetPaths.levelThree__oel;
	private var _background : FlxSprite;
	private var _pipeAmounts : Array<Int> = [7,5,2,1];
	private var _timerText: FlxText;
	private var _timer: Float = 300;
	private var intNum: Int=0;
	
	public var wonLevel: Bool = false;

	override public function create() : Void {
		super.create();
		var offset : FlxPoint = new FlxPoint(350,81);
		_map = new GameMap(_mapPath,GameMap.MapTypeEnum.Playfield,offset,_pipeAmounts);
		_background = new FlxSprite(0,0,AssetPaths.fin_playspace__jpg);
		FlxG.sound.playMusic(AssetPaths.underground__ogg,1,true);
		_timerText = new FlxText(10, 10);
        _timerText.size = 48;
	}

	override public function update(elapsed:Float) : Void {
		_map.update(elapsed);
		super.update(elapsed);
		if (!_map.winCondition){
			_timer -= elapsed;
			_timer = fixedFloat(_timer,2);
			_timerText.text = Std.string(_timer);
			if (_timer <= 0){
				FlxG.switchState(new SceneBEOne());
			}
		}
		else{
			add(new FlxText(1280/2-200,720/2-100,600,"Level Complete!",72));
			if(FlxG.keys.pressed.ANY)
				FlxG.switchState(new SceneBetweenFour());
		}
	}

	override public function draw() : Void {
		_background.draw();
		_map.draw();
		_timerText.draw();
		super.draw();
	}
	
	// https://gist.github.com/db/2657389
	public static function fixedFloat(v:Float, ?precision:Int = 2) : Float {
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
}