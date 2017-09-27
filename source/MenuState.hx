package;

import flixel.FlxState;
import flixel.addons.ui.FlxUIState;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import haxe.macro.Compiler.IncludePosition;
import flixel.addons.transition.*;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.TransitionData.TransitionType;
import flixel.util.FlxColor;

import flixel.graphics.FlxGraphic;

class MenuState extends TransitionSetup
{
	
	var _playButton:FlxButton;
	var _instructButton:FlxButton;
	var _banner:FlxButton;
	var _bg:BackgroundImage;
	var _text:FlxText;
	var _text2:FlxText;
	
	override public function create():Void
	{
		super.create();
		
		_bg = new BackgroundImage();
		_bg.setBg("assets/images/CutsceneAssets/title_3.png");
		add(_bg);
		
		_banner = new FlxButton(40, 40, "", clickPlay);
		_banner.loadGraphic("assets/images/Oil_Dady.png");
		_banner.updateHitbox();
		_banner.setPosition((FlxG.width/2 - _banner.width/2), -_banner.height);
		FlxTween.tween(_banner, {x : (FlxG.width / 2 - _banner.width / 2), y : (FlxG.height * 1.35 / 4 - _banner.height / 2)}, 1, {ease: FlxEase.cubeIn});
				
		_playButton = new FlxButton(40, 40, "", clickPlay);
		_playButton.loadGraphic("assets/images/start.jpg");
		_playButton.updateHitbox();
		_playButton.setPosition((FlxG.width/2 - _playButton.width/2), -_playButton.height);
		FlxTween.tween(_playButton, {x : (FlxG.width / 2 - _playButton.width / 2), y : (FlxG.height*3 / 4 - _playButton.height/2 - 50)}, 1, {ease: FlxEase.cubeIn});
		
		_instructButton = new FlxButton(40, 40, "", instructionClick);
		_instructButton.loadGraphic("assets/images/Htp.jpg");
		_instructButton.updateHitbox();
		_instructButton.setPosition((FlxG.width/2 - _playButton.width/2), -_playButton.height);
		FlxTween.tween(_instructButton, {x : (FlxG.width / 2 - _instructButton.width / 2), y : (FlxG.height*3 / 4 - _instructButton.height/2 + 85)}, 1, {ease: FlxEase.cubeIn});
		
		_text = new FlxText(0, -500, 300, "Made by: \nElaine Chao\nTim Kim\nRyan O'Malley\nRachel Grigg\nChristopher Chen ", 25);
		FlxTween.tween(_text, {x:(0), y:( 0)}, 1, {ease: FlxEase.cubeIn});
		
		_text2 = new FlxText(FlxG.width - 300, -500, 300, "Special thanks to:\nK Plate",25);
		FlxTween.tween(_text2, {x:(FlxG.width - 300), y:( 0)}, 1, {ease: FlxEase.cubeIn});
		
		
		add(_banner);
		add(_playButton);
		add(_instructButton);
		add(_text);
		add(_text2);
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
