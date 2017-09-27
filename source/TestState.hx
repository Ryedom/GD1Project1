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
	private var _mapPath : String = AssetPaths.levelOne__oel;
	private var _background : FlxSprite;
	private var timerText: FlxText = new FlxText(10,10,300,"30",36);
	private var timer: Float = 30;

	override public function create() : Void {
		var offset : FlxPoint = new FlxPoint(350,81);
		_map = new GameMap(_mapPath,GameMap.MapTypeEnum.Playfield,offset);
		_background = new FlxSprite(0,0,AssetPaths.fin_playspace__jpg);
		FlxG.sound.playMusic(AssetPaths.underground__ogg,1,true);
		add(timerText);
	}

	override public function update(elapsed:Float) : Void {
		_map.update(elapsed);
		super.update(elapsed);
		timer -= elapsed;
		timer = fixedFloat(timer,4);
		timerText.text = '$timer';
		if (timer <= 0){
			FlxG.switchState(new SceneBEOne());
		}
	}

	override public function draw() : Void {
		_background.draw();
		_map.draw();
		super.draw();
	}
	
	//https://gist.github.com/db/2657389
	public static function fixedFloat(v:Float, ?precision:Int = 2):Float
	{
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
}