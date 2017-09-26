package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import haxe.macro.Compiler.IncludePosition;

class MenuState extends FlxState
{
	
	var _playButton:FlxButton;
	var _instructButton:FlxButton;
	var _banner:FlxButton;
	var _bg:BackgroundImage;
	
	override public function create():Void
	{
		super.create();
		
		_bg = new BackgroundImage();
		_bg.setBg("assets/images/CutsceneAssets/title.png");
		add(_bg);
		
		_banner = new FlxButton(40, 40, "", clickPlay);
		_banner.loadGraphic("assets/images/baller_banner.png");
		_banner.updateHitbox();
		_banner.setPosition((FlxG.width/2 - _banner.width/2), -_banner.height);
		FlxTween.tween(_banner, {x : (FlxG.width / 2 - _banner.width / 2), y : (FlxG.height * 1.35 / 4 - _banner.height / 2)}, 1, {ease: FlxEase.cubeIn});
				
		_playButton = new FlxButton(40, 40, "", clickPlay);
		_playButton.loadGraphic("assets/images/COOLbuttoNASSET.png");
		_playButton.updateHitbox();
		_playButton.setPosition((FlxG.width/2 - _playButton.width/2), -_playButton.height);
		FlxTween.tween(_playButton, {x : (FlxG.width / 2 - _playButton.width / 2), y : (FlxG.height*3 / 4 - _playButton.height/2 - 50)}, 1, {ease: FlxEase.cubeIn});
		
		_instructButton = new FlxButton(40, 40, "", instructionClick);
		_instructButton.loadGraphic("assets/images/COOLbuttoNASSET.png");
		_instructButton.updateHitbox();
		_instructButton.setPosition((FlxG.width/2 - _playButton.width/2), -_playButton.height);
		FlxTween.tween(_instructButton, {x : (FlxG.width / 2 - _instructButton.width / 2), y : (FlxG.height*3 / 4 - _instructButton.height/2 + 85)}, 1, {ease: FlxEase.cubeIn});
		
		add(_banner);
		add(_playButton);
		add(_instructButton);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	
	function clickPlay():Void{
		FlxG.switchState(new SceneOne());
	}
	
	function instructionClick():Void{
		FlxG.switchState(new InstructionScene());
	}
	
}
