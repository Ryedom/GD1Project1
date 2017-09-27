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
	private var _mapPath : String = AssetPaths.testLevel__oel;
	private var _background : FlxSprite;

	override public function create() : Void {
		var offset : FlxPoint = new FlxPoint(350,81);
		_map = new GameMap(_mapPath,GameMap.MapTypeEnum.Playfield,offset);
		_background = new FlxSprite(0,0,AssetPaths.fin_playspace__jpg);
		FlxG.sound.playMusic(AssetPaths.underground__ogg,1,true);
	}

	override public function update(elapsed:Float) : Void {
		_map.update(elapsed);
		super.update(elapsed);
	}

	override public function draw() : Void {
		_background.draw();
		_map.draw();
		super.draw();
	}
}