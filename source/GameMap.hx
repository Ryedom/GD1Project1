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
	NORTH;
	WEST;
	EAST;
	SOUTH;
}

class GameMap {
    public var _map : FlxOgmoLoader;
	private var _lastMapPath : String;
	public var _mWalls : FlxTilemap;
    public var _mPipes : FlxTilemap;
    public var _mEntities : FlxGroup;
	public var _Player : Player;

	////////////////////////////// NO HARDCODING SIZE OF ARRAY
	////////////////////////////// ALL OTHER HARDCODED SIZES WILL ALSO HAVE TO BE CHANGED
	private var _data:Array<Array<Int>> = [for (i in 0...10) [for (j in 0...14) -1]];


	///////////
	////////////
	///////////

	// HC ISSUE?
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

	// HC ISSUE?
	// Copies tile information from _mPipes to _data
	private function mapToData():Void
	{
		for (i in 0...10)
		{
			for (j in 0...14)
			{
				if (_mPipes.getTile(i, j) != -1)
				{
					_data[i][j] = _mPipes.getTile(i, j);
				}
			}
		}
	}

	/*
		Assuming a path down from refinery, which last passed through
		a pipe in the given direction, checks if the pipe at (x, y)
		connects to the last pipe
	*/
	private function pipesConnect(x:Int, y:Int, dir:Direction):Bool
	{
		switch(dir) 
		{
			case NORTH: return getSouth(_data[x][y]);
			case SOUTH: return getNorth(_data[x][y]);
			case EAST: return getWest(_data[x][y]);
			case WEST: return getEast(_data[x][y]);
		}
		return false;
	}

	// NEEDS ADJUSTING FOR ACTUAL VALUES OF OILS
	// Adds oil sources into _data
	private function addOil(x:Int, y:Int, oil:OilColor):Void
	{
		switch(color)
		{
			case Red: _data[x][y] = 100;
			case Blue: _data[x][y] = 200;
			case Black: _data[x][y] = 300;
			default: _data[x][y] = -1;
		}
	}

	// Checks if _data[x][y] is a pipe
	private function isPipe(x:Int, y:Int):Bool
	{
		if (_data[x][y] > 0 && _data[x][y] < 11)
		{
			return true;
		}
		return false;
	}

	// HC ISSUE?
	// Returns 1 if  _data[i][j] has a pipe in it, 0 if none
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

	// HC ISSUE?
	// Checks _data to see if all the oil has 1 pipe attached to it
	private function allOilUsed():Bool
	{
		for (i in 0...10)
		{
			for (j in 0...14) 
			{
				var pipesAttached = 0;
				if (_data[i][j] > 99) 
				{
					pipesAttached += hasPipe(i, j-1);
					pipesAttached += hasPipe(i-1, j);
					pipesAttached += hasPipe(i+1, j);
					pipesAttached += hasPipe(i, j+1);
					if (pipesAttached != 1)
					{
						return false;
					}
				}
			}
		}
		return true;
	}

	// Checks if the oil at _data[x][y] matches the pipe it should go to
	private function oilMatchesSource(x:Int, y:Int, color:Color):Bool
	{
		switch(color)
		{
			case(Red): return (_data[x][y] == 100);
			case(Blue): return (_data[x][y] == 200);
			case(Black): return (_data[x][y] == 300);
			default: return false;
		}
	}

	/*
		The following 4 functions follow this key:

		1 = I-pipe, vertical
		2 = I-pipe, horizontal
		3 = L-pipe
		4 = upside-down L-pipe
		5 = upside-down backwards L-pipe
		6 = backwards L-pipe
		7 = T-pipe (no left side)
		8 = T-pipe (no up side)
		9 = T-pipe (no right side)
		10 = T-pipe (no down side)
	*/

	// Checks if the give pipe can connect north
	private function getNorth(pipe:Int):Bool
	{
		switch(pipe)
		{
			case(1): return true;
			case(2): return false;
			case(3): return true;
			case(4): return false;
			case(5): return false;
			case(6): return true;
			case(7): return true;
			case(8): return false;
			case(9): return true;
			case(10): return true;
			default: return false;
		}
	}

	// Checks if the give pipe can connect west
	private function getWest(pipe:Int):Bool
	{
		switch(pipe)
		{
			case(1): return false;
			case(2): return true;
			case(3): return false;
			case(4): return false;
			case(5): return true;
			case(6): return true;
			case(7): return false;
			case(8): return true;
			case(9): return true;
			case(10): return true;
			default: return false;
		}
	}

	// Checks if the give pipe can connect east
	private function getEast(pipe:Int):Bool
	{
		switch(pipe)
		{
			case(1): return false;
			case(2): return true;
			case(3): return true;
			case(4): return true;
			case(5): return false;
			case(6): return false;
			case(7): return true;
			case(8): return true;
			case(9): return false;
			case(10): return true;
			default: return false;
		}
	}

	// Checks if the give pipe can connect south
	private function getSouth(pipe:Int):Bool
	{
		switch(pipe)
		{
			case(1): return true;
			case(2): return false;
			case(3): return false;
			case(4): return true;
			case(5): return true;
			case(6): return false;
			case(7): return true;
			case(8): return true;
			case(9): return true;
			case(10): return false;
			default: return false;
		}
	}

	// Recursive function, checking for path to oil source
	private function checkPipe(x:Int, y:Int, dir:Direction, oil:Color):Bool
	{
		// If x and y are out of bounds, return false
		if (x < 0 || y < 0 || x > 9 || y > 13)
		{
			return false;
		}
		// If _data[x][y] is an oil source and it matches with the start pipe, return true
		if (_data[x][y] > 99)
		{
			if (oilMatchesSource(x, y, oil))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		// If there is no pipe at _data[x][y], return false
		if (!isPipe(x, y))
		{
			return false;
		}
		else
		{
			// If the current pipe does not connect to the previous pipe, return false
			if (!pipesConnect(x, y, dir))
			{
				return false;
			}
			else
			{
				var pipe = _data[x][y];
				switch(dir)
				{
					// Check all spaces around current pipe except for previous pipe
					case(NORTH):
						var temp:Bool = true;
						if (getNorth(pipe) == true) {
							temp = (checkPipe(x-1, y, NORTH, Black) && temp);
						}
						if (getWest(pipe) == true) {
							temp = (checkPipe(x, y-1, WEST, Black) && temp);
						}
						if (getEast(pipe) == true) {
							temp = (checkPipe(x, y+1, EAST, Black) && temp);
						}
						return temp;
					case(WEST):
						var temp:Bool = true;
						if (getNorth(pipe) == true) {
							temp = (checkPipe(x-1, y, NORTH, Black) && temp);
						}
						if (getWest(pipe) == true) {
							temp = (checkPipe(x, y-1, WEST, Black) && temp);
						}
						if (getSouth(pipe) == true) {
							temp = (checkPipe(x+1, y, SOUTH, Black) && temp);
						}
						return temp;
					case(EAST):
						var temp:Bool = true;
						if (getNorth(pipe) == true) {
							temp = (checkPipe(x-1, y, NORTH, Black) && temp);
						}
						if (getSouth(pipe) == true) {
							temp = (checkPipe(x+1, y, SOUTH, Black) && temp);
						}
						if (getEast(pipe) == true) {
							temp = (checkPipe(x, y+1, EAST, Black) && temp);
						}
						return temp;
					case(SOUTH):
						var temp:Bool = true;
						if (getSouth(pipe) == true) {
							temp = (checkPipe(x+1, y, SOUTH, Black) && temp);
						}
						if (getWest(pipe) == true) {
							temp = (checkPipe(x, y-1, WEST, Black) && temp);
						}
						if (getEast(pipe) == true) {
							temp = (checkPipe(x, y+1, EAST, Black) && temp);
						}
						return temp;
					default: return false;
				}
			}
		}
	}

	// Calls recursive function starting from given starting points
	private function checkSolution():Bool
	{
		var complete = false;
		// these are where you start placing, x+1 underneath starter pipe
		var tempYList = [4, 5, 10];

		for (y in tempYList)
		{
			if (!isPipe(0, y))
			{
				return false;
			}
			else
			{
				var pipe = _data[x][y];
				var temp = true;
				if (!getNorth(pipe))
				{
					return false;
				}
				////////////////////how to check oil at beginning???
				if (getWest(pipe) == true) {
					temp = (checkPipe(x, y-1, WEST, Black) && temp);
				}
				if (getSouth(pipe) == true) {
					temp = (checkPipe(x+1, y, SOUTH, Black) && temp);
				}
				if (getEast(pipe) == true) {
					temp = (checkPipe(x, y+1, EAST, Black) && temp);
				}
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
        _mPipes = _map.loadTilemap(AssetPaths.pipe_ss__png, 128, 128, "pipes");
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
			addOil(_oil.getX(), _oil.getY(), color);
			_mEntities.add(_oil);
		}
	}

    public function new(mapPath : String, ?mapType : MapTypeEnum) {
		loadMap(mapPath, mapType);
	}
}