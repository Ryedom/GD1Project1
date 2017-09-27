package;

import flixel.addons.ui.FlxUIState;
import flixel.addons.transition.*;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.TransitionData.TransitionType;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import flixel.graphics.FlxGraphic;

class TransitionSetup extends FlxUIState
{
	
	override public function create():Void
	{
		super.create();
		
		FlxTransitionableState.defaultTransIn = new TransitionData();
		FlxTransitionableState.defaultTransOut = new TransitionData();
		transOut = new TransitionData();
		transIn = new TransitionData();
		
		var square:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
		square.persist = true;
		square.destroyOnNoUse = false;
		
		
		FlxTransitionableState.defaultTransOut.tileData = { asset: square, width: 32, height: 32 };
		FlxTransitionableState.defaultTransOut.color = FlxColor.BLACK;
		FlxTransitionableState.defaultTransOut.type = TransitionType.TILES;
		FlxTransitionableState.defaultTransOut.duration = 0.75;
		FlxTransitionableState.defaultTransOut.direction = new FlxPoint();
		FlxTransitionableState.defaultTransOut.direction.set(1, -1);
		
		FlxTransitionableState.defaultTransIn.tileData = { asset: square, width: 32, height: 32 };
		FlxTransitionableState.defaultTransIn.color = FlxColor.BLACK;
		FlxTransitionableState.defaultTransIn.type = TransitionType.TILES;
		FlxTransitionableState.defaultTransIn.duration = 0.75;
		FlxTransitionableState.defaultTransIn.direction = new FlxPoint();
		FlxTransitionableState.defaultTransIn.direction.set(1, -1);		
		
		transOut = FlxTransitionableState.defaultTransOut;
		transIn = FlxTransitionableState.defaultTransIn;
	}

	
}
