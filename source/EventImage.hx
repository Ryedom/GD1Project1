package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxPrerotatedAnimation;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.util.FlxTimer;

class EventImage extends FlxSprite{
	
	var _curHeight:Int;
	var _expand:Bool;
	var _shrink:Int;
	var _temp:Bool;
	var _curTime:Float;
	var _floorPos:Int;
	
	public function new(){
		super();
		loadGraphic("data/images/testingImage2.png", true, 60, 120);
		this.scale.set(1, 2);
		setGraphicSize();
		updateHitbox();
		_curHeight = Math.round( -this.height * 2);
		_floorPos = FlxG.height;
		
		_expand = false;
		_temp = false;
		_shrink = 3;
		_curTime = 0;
	}
	
	public function setImage(filename:String, xSize:Int, ySize:Int){
		loadGraphic(filename, true, xSize, ySize);
	}
	
	public function changeFloorHeight(Int)
	{
		_floorPos = Math.round(_floorPos - Int);
	}
	
	override public function update(elapsed:Float):Void{
		super.update(elapsed);
		
		if (!_temp)
		{	
			this.setPosition(this.getPosition().x, _curHeight);
			_temp = true;
		}
		{
			if (!_expand)
			{
				_curHeight += Math.round((_floorPos / 20) + this.height / 2);
				this.setPosition(this.getPosition().x, _curHeight);

			}
			if (_curHeight > _floorPos || _expand)
			{
				if (_shrink > 0)
				{
					if (_shrink == 3)
						scale.set(1, 0.75);
					else if (_shrink == 2)
						scale.set(1, 0.5);
					else
						scale.set(1, .25);
						

				}
				else if(_shrink > -3)
				{
					if (_shrink == 0)
						scale.set(1, 0.5);
					else if (_shrink == -1)
						scale.set(1, 0.75);
					else if (_shrink == -2)
						scale.set(1, 1);
				}
				setGraphicSize();
				updateHitbox();
				_curHeight = _floorPos - Math.round(this.height);
				this.setPosition(this.getPosition().x, _curHeight);
				_shrink--;
				_expand = true;
				
			}
		}
	}

}
