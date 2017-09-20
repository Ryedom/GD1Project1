package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite
{
    private var gridTween : FlxTween;
    private var tweenDuration : Float = 0.2;
    private var collisionMap : FlxTilemap;

    public function new(?X:Float=0, ?Y:Float=0, newCollision:FlxTilemap)
    {
        super(X, Y);
        //makeGraphic(64,64,FlxColor.BLUE);
        // Load player spritesheet
        loadGraphic(AssetPaths.player__png, true, 128, 128);
        // Set scale, then fix the sprite offset to be the center.
        scale.set(0.5,0.5);
        offset.set(32,32);
        // Animations (currently single frames)
        animation.add("u", [3], 6, false);
        animation.add("d", [0], 6, false);
        animation.add("l", [1], 6, false);
        animation.add("r", [2], 6, false);
        // Assign & initialize various other parameters
        collisionMap = newCollision;
        //   (Figure out how to create a blank, inactive tween later)
        gridTween = FlxTween.tween(this, { x: this.x }, 0);
    }

    private function movement():Void {
        // Retrieve inputs
        var _up:Bool = FlxG.keys.anyPressed([UP, W]);
        var _left:Bool = FlxG.keys.anyPressed([LEFT, A]);
        var _down:Bool = FlxG.keys.anyPressed([DOWN, S]);
        var _right:Bool = FlxG.keys.anyPressed([RIGHT, D]);

        // Only move when not already moving between tiles
        if (!gridTween.active) {
            if (_up) {
                // Check the tilemap for a possible collision before moving
                if (!collisionMap.overlapsPoint(new FlxPoint(x, y - 64))) {
                    gridTween = FlxTween.tween(this, { x: this.x, y: this.y - 64}, tweenDuration);
                    animation.play("u");
                }
            }
            else if (_down) {
                if (!collisionMap.overlapsPoint(new FlxPoint(x, y + 64))) {
                    gridTween = FlxTween.tween(this, { x: this.x, y: this.y + 64}, tweenDuration);
                    animation.play("d");
                }
            }
            else if (_left) {
                if (!collisionMap.overlapsPoint(new FlxPoint(x - 64, y))) {
                    gridTween = FlxTween.tween(this, { x: this.x - 64, y: this.y}, tweenDuration);
                    animation.play("l");
                }
            }
            else if (_right) {
                if (!collisionMap.overlapsPoint(new FlxPoint(x + 64, y))) {
                    gridTween = FlxTween.tween(this, { x: this.x + 64, y: this.y}, tweenDuration);
                    animation.play("r");
                }
            }
            else {
                animation.stop();
            }
        }
    }

    override public function update(elapsed:Float):Void {
        movement();
        super.update(elapsed);
    }
}