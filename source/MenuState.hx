package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class MenuState extends FlxState
{
	
	var _playButton:FlxButton;
	var _banner:FlxButton;
	var _bg:BackgroundImage;
	
	override public function create():Void
	{
		super.create();
		
		_bg = new BackgroundImage();
		_bg.setBg("assets/images/assets/ge_background.png");
		add(_bg);
		
		_banner = new FlxButton(40, 40, "", clickPlay);
		_banner.loadGraphic("assets/images/baller_banner.png");
		_banner.updateHitbox();
		_banner.setPosition((FlxG.width/2 - _banner.width/2), -_banner.height);
		FlxTween.tween(_banner, {x : (FlxG.width / 2 - _banner.width / 2), y : (FlxG.height * 1.35 / 4 - _banner.height / 2)}, 1, {ease: FlxEase.cubeIn});
				
		_playButton = new FlxButton(40, 40, "", clickPlay);
		//_playButton.setGraphicSize(400, 200);
		_playButton.loadGraphic("assets/images/COOLbuttoNASSET.png");
		_playButton.updateHitbox();
		_playButton.setPosition((FlxG.width/2 - _playButton.width/2), -_playButton.height);
		FlxTween.tween(_playButton, {x : (FlxG.width / 2 - _playButton.width / 2), y : (FlxG.height*3 / 4 - _playButton.height/2)}, 1, {ease: FlxEase.cubeIn});
		
	
		add(_banner);
		add(_playButton);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void{
		FlxG.switchState(new SceneOne());
	}
	
}
