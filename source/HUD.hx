package

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;

/*
class PipeDisplayElement extends FlxObject {
    var pipeType : Player.PipeType;
    var pipeIcon : FlxSprite;
    var pipeText : FlxText;

    var pipeRotateTween : FlxTween;

    override public function draw() {
        pipeIcon.draw();
        pipeText.draw();
    }

    public function RotateLeft() : Bool {

    }

    public function RotateRight() : Bool {

    }

    public function UpdateText(num : Int) : Void {
        pipeText.text = "x " + num;
    }

    
}

class PipeDisplay extends FlxObject {
    var pipeElements : Array<FlxObject>;

    public function TakePipe(pipeType: Player.PipeType) {

    }

    public function RotateLeft() : Bool {
        for (element in pipeElements) {
            if (!element.RotateLeft())
                return false;
        }
        return true;
    }

    public function RotateRight() : Bool {
        for (element in pipeElements) {
            if (!element.RotateLeft())
                return false;
        }
        return true;
    }

    public inline function AlignElements() : Void {
        FlxSpriteUtil.space(pipeElements,cast this.x,cast this.y,0,10,false);
    }

    public function new(?X:Float=0, ?Y:Float=0, ) {

    }

    override public function draw() {
        for (element in pipeElements) {
            element.draw();
        }
    }
}
*/