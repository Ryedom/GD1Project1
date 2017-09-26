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

enum Direction
{
	North;
	West;
	East;
	South;
}

enum OilType
{
	Red;
	Blue;
	Black;
}

class GameMap {
    public var _map : FlxOgmoLoader;
	private var _lastMapPath : String;
	public var _mWalls : FlxTilemap;
    public var _mPipes : FlxTilemap;
    public var _mEntities : FlxGroup;
	public var _Player : Player;

	private var _data:Array<Array<Int>> = [for (i in 0...10) [for (j in 0...14) -1]];


	///////////
	////////////
	///////////

	// Resets all numbers in _data to -1
	private function clearData():Void
	{
		for (i in 0...10)
		{
			for (j in 0...14)
			{
				_data[i][j] = -1;
			}
		}
	}

	// Copies tile information from _mWalls to _data
	// Needs changing to account for different oil sprites (not just default)
	private function mapToData():Void
	{
		for (i in 1...11)
		{
			for (j in 3...17) 
			{
				if (_mPipes.getTile(i, j) != -1)
				{
					_data[i-1][j-3] = _mPipes.getTile(i, j);
				}
			}
		}
	}

	// NEEDS ADJUSTING
	// see pipe implementation
	// also will have to account for diff pipe colors???
	private function pipesConnect(x:Int, y:Int, dir:Direction):Bool
	{
		switch(dir) 
		{
			case North: // return if pipe at x, y north is true,
			case South: // above except south
			case East: // above except east
			case West: // above except west
		}
		return false;
	}

	// Obsolete?
	// IMPORTANT!!!!
	// This will need to be edited to account for all pipe varieties
	// That if statement is gonna be loooooooong
	private function isPipe(x:Int, y:Int):Bool
	{
		var tile = _data[x][y];
		if (tile == 0 || tile == 2 || tile == 4 || tile == 5)
		{
			return true;
		}
		return false;
	}

	// Obsolete?
	// Checks if _data[i][j] has a pipe in it
	private function hasPipe(x:Int, y:Int):Int
	{
		if (x < 0 || y < 0 || x > 9 || y > 13)
		{
			return 0;
		}
		else if (isPipe(x, y))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}


	// Checks _data to see if all the oil has 1 pipe attached to it
	private function allOilUsed():Bool
	{
		var pipesAttached = 0;
		for (i in 0...10)
		{
			for (j in 0...14) 
			{
				if (_data[i][j] == 3) 
				{
					pipesAttached += hasPipe(i, j-1);
					pipesAttached += hasPipe(i-1, j);
					pipesAttached += hasPipe(i+1, j);
					pipesAttached += hasPipe(i, j+1);
					// testing
					//_mWalls.setTile(i, j-1, 2);
					//_mWalls.setTile(i-1, j, 2);
					//_mWalls.setTile(i+1, j, 2);
					//_mWalls.setTile(i, j+1, 2);
					if (pipesAttached != 1)
					{
						return false;
					}
				}
			}
		}
		return true;
	}

	private function checkPipe(x:Int, y:Int, dir:Direction, oil:OilType):Bool
	{
		if (x < 0 || y < 0 || x > 9 || y > 13)
		{
			return false;
		}
		// needs changing
		// need to know # of oil on spritesheet
		if (_data[x][y] == 3)
		{
			// needs changing
			// need to know # of oil on spritesheet
			if (_data[x][y] == 3)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		if (!isPipe(x, y))
		{
			return false;
		}
		else
		{
			if (!pipesConnect(x, y, dir))
			{
				return false;
			}
			else
			{
				switch(dir)
				{
					case(North):
					case(West):
					case(East):
					case(South):
				}
			return false;
			}
		}
	}

	// Calls recursive function starting from given starting points
	private function checkSolution():Bool
	{
		var complete = false;
		// the 2 lists will be vals of initial start spaces
		var tempXList = 0;
		// these are where you start placing, y+1 underneath starter pipe
		var tempYList = [4, 5, 10];

		for (y in tempYList)
		{
			if (!isPipe(0, y))
			{
				return false;
			}
			else
			{
				var temp = true;
				/////// see pipe implementation
				if (temp == false)
				{
					return false;
				}
			}
		}
	
		return allOilUsed();
	}

	///////////////////
	/////////////////
	//////////////////




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

		mapToData();
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
			_data[_oil.getX()][_oil.getY()] = 100;
			_mEntities.add(_oil);
		}
	}

    public function new(mapPath : String, ?mapType : MapTypeEnum) {
		loadMap(mapPath, mapType);
	}
}