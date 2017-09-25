package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;

enum MapTypeEnum {
	Playfield;
	Background;
}

class GameMap {
    public var _map : FlxOgmoLoader;
	private var _lastMapPath : String;
	public var _mWalls : FlxTilemap;
    public var _mPipes : FlxTilemap;
    public var _mEntities : FlxGroup;
	public var _Player : Player;

    public function loadMap(mapPath : String, ?mapType : MapTypeEnum):Void  {
		_lastMapPath = mapPath;
		_map = new FlxOgmoLoader(mapPath);
		_mEntities = new FlxGroup(64);

        // Load walls layer
		_mWalls = _map.loadTilemap(AssetPaths.playArea__png, 128, 128, "walls");
		_mWalls.scale.set(0.5,0.5);

        // Load pipes layer
        _mPipes = _map.loadTilemap(AssetPaths.testPipeTileset__png, 128, 128, "pipes");
        _mPipes.scale.set(0.5,0.5);
        
		// Set wall collision properties
		//   This is indexed from left to right, continuing from new rows.
		//   Default tile collision seems to be FlxObject.ANY(?)

		// Walls
		_mWalls.setTileProperties(1, FlxObject.ANY);
		_mWalls.setTileProperties(2, FlxObject.ANY);
		_mWalls.setTileProperties(3, FlxObject.ANY);
		_mWalls.setTileProperties(4, FlxObject.ANY);
		_mWalls.setTileProperties(5, FlxObject.ANY);

		// Pipes
		_mPipes.setTileProperties(1, FlxObject.ANY);
		_mPipes.setTileProperties(2, FlxObject.ANY);
		_mPipes.setTileProperties(3, FlxObject.ANY);
		_mPipes.setTileProperties(4, FlxObject.ANY);
		_mPipes.setTileProperties(5, FlxObject.ANY);
		_mPipes.setTileProperties(6, FlxObject.ANY);
		_mPipes.setTileProperties(7, FlxObject.ANY);
		_mPipes.setTileProperties(8, FlxObject.ANY);
		_mPipes.setTileProperties(9, FlxObject.ANY);
		_mPipes.setTileProperties(10, FlxObject.ANY);
		_mPipes.setTileProperties(11, FlxObject.ANY);
		_mPipes.setTileProperties(12, FlxObject.ANY);

		// Spawn/place entities (see "placeEntities")
		_map.loadEntities(placeEntities, "entities");
    }

	public function update(elapsed:Float) {
		_mEntities.update(elapsed);
	}

	public function draw() {
		_mWalls.draw();
		_mPipes.draw();
		_mEntities.draw();
	}

	public function reload() {
		loadMap(_lastMapPath);
	}

    public function placeEntities(entityName:String, entityData:Xml):Void {
		// Parse entity position
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		// Parse optional entity data (initialized to defaults)
		var color:OilSource.OilColor = OilSource.OilColor.Black;
		if (entityData.exists("Color"))
			color = Type.createEnum(OilSource.OilColor,entityData.get("Color"));
		// Map entities to game classes
		if (entityName == "Player") {
            var _player : Player = new Player(x,y,this);
			_mEntities.add(_player);
		}
		if (entityName == "OilSource") {
			var _oil : OilSource = new OilSource(x,y,color);
			_mEntities.add(_oil);
		}
	}

    public function new(mapPath : String, ?mapType : MapTypeEnum) {
		loadMap(mapPath, mapType);
	}
}