package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import flixel.math.*;

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
	public var _mConstantPipes : FlxTilemap;
    public var _mEntities : FlxGroup;
	public var _Player : Player;
	public var _pipeDisplay : HUD.PipeDisplay;
	public var _pipeAmounts : Array<Int>;
	public var winCondition : Bool = false;

	private var _offset : FlxPoint;
	
	private var _data:Array<Array<Int>> = [for (i in 0...10) [for (j in 0...10) -1]];


	///////////
	////////////
	///////////

	// Adds oil sources into _data
	private function addOil(x:Int, y:Int, color:OilSource.OilColor):Void
	{
		switch(color)
		{
			case Red: _data[y][x] = 200;
			case Blue: _data[y][x] = 300;
			case Black: _data[y][x] = 400;
			default: _data[y][x] = -1;
		}
	}

	public function addPipe(x:Int, y:Int, tile:Int):Void
	{
		_data[y][x] = tile;

	}

	// Adds VictoryPipes into _data
	private function addVPipe(x:Int, y:Int, color:OilSource.OilColor):Void
	{
		switch(color)
		{
			case Red: _data[y][x] = 22;
			case Blue: _data[y][x] = 33;
			case Black: _data[y][x] = 44;
			default: _data[y][x] = -1;
		}	
	}

	// HC ISSUE?
	// Checks _data to see if all the oil has 1 pipe attached to it
	private function allOilUsed():Bool
	{
		for (i in 0...10)
		{
			for (j in 0...10) 
			{
				var pipesAttached = 0;
				if (isOilSource(i, j)) 
				{
					
					if (onlyOneConnection(i, j) != 1)
					{
						return false;
					}
				}
			}
		}
		return true;
	}

	// HC ISSUE?
	// Recursive function, checking for path to oil source
	private function checkPipe(x:Int, y:Int, dir:Direction, oil:OilSource.OilColor):Bool
	{
		// If x and y are out of bounds, return false
		if (x < 0 || y < 0 || x > 9 || y > 9)
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
							temp = (checkPipe(x-1, y, NORTH, oil) && temp);
						}
						if (getWest(pipe) == true) {
							temp = (checkPipe(x, y-1, WEST, oil) && temp);
						}
						if (getEast(pipe) == true) {
							temp = (checkPipe(x, y+1, EAST, oil) && temp);
						}
						return temp;
					case(WEST):
						var temp:Bool = true;
						if (getNorth(pipe) == true) {
							temp = (checkPipe(x-1, y, NORTH, oil) && temp);
						}
						if (getWest(pipe) == true) {
							temp = (checkPipe(x, y-1, WEST, oil) && temp);
						}
						if (getSouth(pipe) == true) {
							temp = (checkPipe(x+1, y, SOUTH, oil) && temp);
						}
						return temp;
					case(EAST):
						var temp:Bool = true;
						if (getNorth(pipe) == true) {
							temp = (checkPipe(x-1, y, NORTH, oil) && temp);
						}
						if (getSouth(pipe) == true) {
							temp = (checkPipe(x+1, y, SOUTH, oil) && temp);
						}
						if (getEast(pipe) == true) {
							temp = (checkPipe(x, y+1, EAST, oil) && temp);
						}
						return temp;
					case(SOUTH):
						var temp:Bool = true;
						if (getSouth(pipe) == true) {
							temp = (checkPipe(x+1, y, SOUTH, oil) && temp);
						}
						if (getWest(pipe) == true) {
							temp = (checkPipe(x, y-1, WEST, oil) && temp);
						}
						if (getEast(pipe) == true) {
							temp = (checkPipe(x, y+1, EAST, oil) && temp);
						}
						return temp;
					default: return false;
				}
			}
		}
	}

	// Calls recursive function starting from given starting points
	public function checkSolution():Bool
	{
		var yList = vPipeCoords();

		for (y in yList)
		{
			if (!isPipe(0, y))
			{
				return false;
			}
			else
			{
				var pipe = _data[0][y];
				var color:OilSource.OilColor;
				if (pipe == 22)
				{
					color = Red;
				}
				else if (pipe == 33)
				{
					color = Blue;
				}
				else
				{
					color = Black;
				}
				var temp = true;
				var color: OilSource.OilColor;
				if (pipe == 22){
					color = Red;
				}
				else if (pipe == 33){
					color = Blue;
				}
				else {
					color = Black;
				}
				if (!getNorth(pipe))
				{
					return false;
				}
				if (getWest(pipe) == true) {
					temp = (checkPipe(0, y-1, WEST, color) && temp);
				}
				if (getSouth(pipe) == true) {
					temp = (checkPipe(1, y, SOUTH, color) && temp);
				}
				if (getEast(pipe) == true) {
					temp = (checkPipe(0, y+1, EAST, color) && temp);
				}
				if (temp == false)
				{
					return false;
				}
			}
		}
		return allOilUsed();
	}


	// HC ISSUE?
	// Resets all numbers in _data to -1
	private function clearData():Void
	{
		for (i in 0...10)
		{
			for (j in 0...10)
			{
				_data[i][j] = -1;
			}
		}
	}

	// HC ISSUE?
	// Finds the y coordinate of VictoryPipes (x is always 0)
	private function vPipeCoords():Array<Int>
	{
		var _array = new Array();
		for (y in 0...10)
		{
			if (isVPipe(0, y))
			{
				_array.push(y);
			}
		}
		return _array;
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

		22, 33, and 44 are VictoryPipes: straight vertical pipes
	*/


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
			case(22): return false;
			case(33): return false;
			case(44): return false;
			default: return false;
		}
	}

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
			case(22): return true;
			case(33): return true;
			case(44): return true;
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
			case(22): return true;
			case(33): return true;
			case(44): return true;
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
			case(22): return false;
			case(33): return false;
			case(44): return false;
			default: return false;
		}
	}

	// HC ISSUE?
	// Returns 1 if  _data[i][j] has a pipe in it, 0 if none
	private function hasPipe(x:Int, y:Int) : Bool
	{
		if (x < 0 || y < 0 || x > 9 || y > 9)
		{
			return false;
		}
		else if (isPipe(x, y))
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	// Checks if _data[x][y] is an oil source
	private function isOilSource(x:Int, y:Int):Bool
	{
		if (_data[x][y] == 200 || _data[x][y] == 300 || _data[x][y] == 400)
		{
			return true;
		}
		return false;
	}

	// Checks if _data[x][y] is a pipe
	private function isPipe(x:Int, y:Int):Bool
	{
		if (_data[x][y] > 0 && _data[x][y] < 10)
		{
			return true;
		}
		else if (_data[x][y] == 22 || _data[x][y] == 33 || _data[x][y] == 44)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	// Checks if _data[x][y] is a VictoryPipe
	private function isVPipe(x:Int, y:Int):Bool
	{
		if (_data[x][y] == 22 || _data[x][y] == 33 || _data[x][y] == 44)
		{
			return true;
		}
		return false;
	}

	// HC ISSUE?
	// Copies tile information from _mPipes to _data
	private function mapToData():Void
	{
		for (i in 0...10)
		{
			for (j in 0...10)
			{
				var pipetile:Int = _mPipes.getTile(j, i);
				if (pipetile != -1 && !isOilSource(i, j) && !isVPipe(i, j))
				{
					_data[i][j] = _mPipes.getTile(j, i);
				}
				//var p = _data[i][j];
				//trace('$p ');
			}
			//trace(_data[i].toString());
		}
	}

	// Checks if the oil at _data[x][y] matches the pipe it should go to
	private function oilMatchesSource(x:Int, y:Int, color:OilSource.OilColor):Bool
	{
		switch(color)
		{
			case(Red): return (_data[x][y] == 200);
			case(Blue): return (_data[x][y] == 300);
			case(Black): return (_data[x][y] == 400);
			default: return false;
		}
	}

	// Returns number of connected pipes to the oil source at x, y
	private function onlyOneConnection(x:Int, y:Int):Int
	{
		var pipesAttached = 0;
		if (hasPipe(x-1, y) && getSouth(_data[x-1][y]))
		{
			pipesAttached += 1;
		}
		if (hasPipe(x+1, y) && getNorth(_data[x+1][y]))
		{
			pipesAttached += 1;
		}
		if (hasPipe(x, y-1) && getEast(_data[x][y-1]))
		{
			pipesAttached += 1;
		}
		if (hasPipe(x, y+1) && getWest(_data[x][y+1]))
		{
			pipesAttached += 1;
		}
		return pipesAttached;
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

	// Removes the pipe at (x, y)
	public function removePipe(x:Int, y:Int):Void
	{
		_data[y][x] = 0;
		/*for (i in 0...10)
		{
		}*/
	}


	///////////////////
	/////////////////
	//////////////////


    public function loadMap(mapPath : String, ?mapType : MapTypeEnum, ?offset : FlxPoint, ?pipeAmounts : Array<Int>):Void  {
		_lastMapPath = mapPath;
		_map = new FlxOgmoLoader(mapPath);
		_mEntities = new FlxGroup(64);
		if (offset != null)
			_offset = offset;
		else _offset = new FlxPoint(0,0);

		_pipeDisplay = new HUD.PipeDisplay(32,128,pipeAmounts);
		_pipeAmounts = pipeAmounts;

        // Load walls layer
		_mWalls = _map.loadTilemap(AssetPaths.playArea__png, 128, 128, "walls");
		_mWalls.setPosition(_offset.x,_offset.y);
		_mWalls.scale.set(0.5,0.5);

        // Load pipes layer
        _mPipes = _map.loadTilemap(AssetPaths.pipe_ss__png, 128, 128, "pipes");
		_mPipes.setPosition(_offset.x,_offset.y);
        _mPipes.scale.set(0.5,0.5);

		// Load constant pipes layer
		_mConstantPipes = _map.loadTilemap(AssetPaths.cpipe_ss__png, 128, 128, "constantpipes");
		_mConstantPipes.setPosition(_offset.x,_offset.y);
        _mConstantPipes.scale.set(0.5,0.5);
        
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

		// Constant Pipes
		_mConstantPipes.setTileProperties(1, FlxObject.ANY);
		_mConstantPipes.setTileProperties(2, FlxObject.ANY);
		_mConstantPipes.setTileProperties(3, FlxObject.ANY);
		_mConstantPipes.setTileProperties(4, FlxObject.ANY);
		_mConstantPipes.setTileProperties(5, FlxObject.ANY);
		_mConstantPipes.setTileProperties(6, FlxObject.ANY);
		_mConstantPipes.setTileProperties(7, FlxObject.ANY);
		_mConstantPipes.setTileProperties(8, FlxObject.ANY);
		_mConstantPipes.setTileProperties(9, FlxObject.ANY);
		_mConstantPipes.setTileProperties(10, FlxObject.ANY);
		_mConstantPipes.setTileProperties(11, FlxObject.ANY);

		// Spawn/place entities (see "placeEntities")
		_map.loadEntities(placeEntities, "entities");

		mapToData();
    }

	public function update(elapsed:Float) {
		_mEntities.update(elapsed);
		//mapToData();
	}

	public function draw() {
		_mWalls.draw();
		_mConstantPipes.draw();
		_mPipes.draw();
		_mEntities.draw();
		_pipeDisplay.draw();
	}

	public function reload() {
		loadMap(_lastMapPath);
	}

    public function placeEntities(entityName:String, entityData:Xml):Void {
		// Parse entity position
		var x:Int = Std.parseInt(entityData.get("x")) + cast _offset.x;
		var y:Int = Std.parseInt(entityData.get("y")) + cast _offset.y;
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
			_oil.setX(x-cast _offset.x);
			_oil.setY(y-cast _offset.y);
			addOil(_oil.getX(), _oil.getY(), color);
			_mEntities.add(_oil);
		}
		if (entityName == "VictoryPipe") {
			var _pipe : VictoryPipe = new VictoryPipe(x,y,color);
			_pipe.setX(x-cast _offset.x);
			_pipe.setY(y-cast _offset.y);
			addVPipe(_pipe.getX(), _pipe.getY(), color);
			_mEntities.add(_pipe);
		}
	}

    public function new(mapPath : String, ?mapType : MapTypeEnum, ?offset : FlxPoint, ?pipeAmounts : Array<Int>) {
		loadMap(mapPath, mapType, offset,pipeAmounts);
	}
}