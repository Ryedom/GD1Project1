package;

import flixel.FlxState;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	
	var _player:Player;
	
	override public function create():Void
	{
		super.create();
		add(new FlxText(10, 10, 300, "hi there!"));
		_player = new Player();
		add(_player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
