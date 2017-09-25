package;

import flixel.FlxState;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;

enum Direction 
{
	North;
	South;
	East;
	West;
}

enum OilType 
{
	Red;
	Blue;
	Black;
}

class PlayState extends FlxState
{
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	// rename
	private var _data:Array<Array<Int>> = [for (i in 0...10) [for (j in 0...14) -1]];

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

	////////////
	///////////
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
				if (isPipe(i-1, j-3) || _mWalls.getTile(i, j) == 3)
				{
					_data[i-1][j-3] = _mWalls.getTile(i, j);
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
		_mWalls.setTile(2, 1, 0);
		add(_mWalls);
		mapToData();
		// Spawn player
		_player = new Player(0,0,_mWalls);
		// Spawn/place entities (see "placeEntities")
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		// if a piece is placed in the grid
		// mapToData();
		super.update(elapsed);
		FlxG.collide(_player, _mWalls);
	}
}
