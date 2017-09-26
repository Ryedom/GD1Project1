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

	override public function create() : Void {
		_map = new GameMap(_mapPath);
	}

	override public function update(elapsed:Float) : Void {
		_map.update(elapsed);
		super.update(elapsed);
	}

	override public function draw() : Void {
		_map.draw();
		super.draw();
	}
}