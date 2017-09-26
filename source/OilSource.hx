package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

enum OilColor {
    Black;
    Red;
    Blue;
    Green;
    Yellow;
    Purple;
}

class OilSource extends FlxSprite {
    @:isVar public var oilColor(get,set) : OilColor;
    public var x: Int;
    public var y: Int;

    public function get_oilColor() {
        return oilColor;
    }

    private function set_oilColor(value) {
        return oilColor = value;
    }

    public function getX() {
    	return x;
    }

    public function getY() {
    	return y;
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
        x = X/64;
        y = Y/64;
        updateHitbox();
        oilColor = color;
    }
}