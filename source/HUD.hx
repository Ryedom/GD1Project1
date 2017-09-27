package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;

/*
class PipeDisplayElement extends FlxObject {
    var _pipeType : Player.PipeType;
    var _pipeIcon : FlxSprite;
    var _pipeText : FlxText;

    var _pipeRotateTween : FlxTween;


    public function RotateLeft() : Bool {

    }

    public function RotateRight() : Bool {

    }

    public function UpdateText(num : Int) : Void {
        _pipeText.text = "x " + num;
    }

    public function new(pipeType : Player.PipeType, ?startingNumber : Int) : Void {
        super(0,0);
        _pipeType = pipeType;
        _pipeIcon = new FlxSprite(x,y);
        _pipeIcon.loadGraphic(AssetPaths.pipe_ss__png,true,64,64);
        _pipeIcon.animation.frameIndex = switch(pipeType) {
            case STRAIGHT:
                1;
            case CURVED:
                2;
            case CROSS:
                3;
            case TWOWAY:
                4;
            case CROSSOVER:
                5;
        }
        _pipeText = new FlxText(x + 64, y, 256);
        UpdateText(startingNumber);
    }

    override public function draw() {
        _pipeIcon.draw();
        _pipeText.draw();
    }    
}

class PipeDisplay extends FlxObject {
    var pipeElements : Array<FlxObject>;

    public function TakePipe(pipeType: Player.PipeType) : Bool {

    }

    public function ReplacePipe(pipeType: Player.PipeType) : Bool {

    }

    public function RotateLeft() : Bool {
        for (elementObject in pipeElements) {
            var element : PipeDisplayElement = cast elementObject;
            if (!element.RotateLeft())
                return false;
        }
        return true;
    }

    public function RotateRight() : Bool {
        for (elementObject in pipeElements) {
            var element : PipeDisplayElement = cast elementObject;
            if (!element.RotateLeft())
                return false;
        }
        return true;
    }

    public inline function AlignElements() : Void {
        FlxSpriteUtil.space(pipeElements,cast this.x,cast this.y,0,10,false);
    }

    public function new(?X:Float=0, ?Y:Float=0, ) {
        for (i in 0..5) {
            newIcon : PipeDisplayElement = new PipeDisplayElement(cast i,0);
        }
    }

    override public function draw() {
        for (element in pipeElements) {
            element.draw();
        }
    }
}
*/