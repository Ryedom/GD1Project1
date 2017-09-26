package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxObject;

enum Direction {
	North;
	West;
	East;
	South;
}

class Pipe extends FlxSprite{

	private var _type:Int;
	private var _amount:Int;
	private var pipe = new FlxSprite();

    public function new(type:Int,amount:Int){
	super(type,amount);
		_type = type;
		_amount = amount;
    }
	
	public function getType():Int{
		return _type;
	}
	public function getAmount():Int{
		return _amount;
	}
	public function reduceAmount():Void{
		_amount = _amount - 1;
	}
	public function changeStuff(x:Int, y:Int):FlxSprite{
		if (_type == 1){
			pipe.loadGraphic("assets/images/base_straight_pipe.png",true, 128,128);
			pipe.origin.set(0,0);
			pipe.scale.set(.25,.25);
			pipe.x = x;
			pipe.y = y;
		}
		return pipe;
	}
	
	


    override public function update(elapsed:Float):Void {
        super.update(elapsed);
    }
}