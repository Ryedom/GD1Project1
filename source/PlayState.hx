package;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxG;

import flixel.math.FlxPoint;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxSprite;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	private var _map : GameMap;
	private var _mapPath : String = AssetPaths.testLevel__oel;
	private var timerText: FlxText = new FlxText(10,10,300,"30",36);
	private var timer: Float = 30;

	override public function create() : Void {
		_map = new GameMap(_mapPath);
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
		_map.draw();
		super.draw();
	}
	
	
	
	//https://gist.github.com/db/2657389
	public static function fixedFloat(v:Float, ?precision:Int = 2):Float
	{
		return Math.round( v * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
}
