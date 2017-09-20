package;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		// Mapping entities to game classes
		if (entityName == "player")
		{
			_player.x = x;
			_player.y = y;
		}
	}

	override public function create():Void
	{
		var newBgColor = new FlxColor(0x808080);
		FlxG.camera.bgColor = newBgColor;
		// Map Boilerplate
		//
		// MOVE LEVEL LOADER INTO ITS OWN CLASS LATER
		// (or something better than this)
		//
		_map = new FlxOgmoLoader(AssetPaths.testLevel__oel);
		_mWalls = _map.loadTilemap(AssetPaths.playArea__png, 128, 128, "walls");
		_mWalls.scale.set(0.5,0.5);
		_mWalls.follow();
		// Set wall collision properties
		//   This is indexed from left to right, continuing from new rows.
		//   Default tile collision seems to be FlxObject.ANY
		_mWalls.setTileProperties(0, FlxObject.NONE);
		_mWalls.setTileProperties(1, FlxObject.NONE);
		_mWalls.setTileProperties(2, FlxObject.NONE);
		_mWalls.setTileProperties(3, FlxObject.NONE);
		_mWalls.setTileProperties(4, FlxObject.NONE);
		_mWalls.setTileProperties(5, FlxObject.NONE);
		add(_mWalls);
		// Spawn player
		_player = new Player(0,0,_mWalls);
		// Spawn/place entities (see "placeEntities")
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);
	}
}
