package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

enum OilColor {
    Black;
    Red;
    Blue;
}

class OilSource extends FlxSprite {
    @:isVar public var oilColor(get,set) : OilColor;
    // Index positions
    public var _x: Int;
    public var _y: Int;

    public function get_oilColor() {
        return oilColor;
    }

    private function set_oilColor(value) {
        return oilColor = value;
    }

    public function getX() {
        return _x;
    }

    public function getY() {
    	return _y;
    }

    public function setX(newX:Int) {
        _x = Std.int(newX/64);
    }

    public function setY(newY:Int) {
        _y = Std.int(newY/64);
    }

    public function new(?X:Float=0, ?Y:Float=0, color : OilColor) {
        super(X,Y);
        loadGraphic(AssetPaths.dirt_ss__png,true,128,128);
        switch(color) {
            case Black:
                animation.frameIndex = 2;
            case Red:
                animation.frameIndex = 4;
            case Blue:
                animation.frameIndex = 3;
            default:
                animation.frameIndex = 2;
        }
        pixelPerfectPosition = true;
        // Set scale, then fix the sprite offset to be the center.
        allowCollisions = FlxObject.ANY;
        scale.set(0.5,0.5);
        offset.set(32,32);
        updateHitbox();
        oilColor = color;
    }
}