package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;

class PipeDisplayElement extends FlxObject {
    var _pipeType : Player.PipeType;
    var _pipeIcon : FlxSprite;
    var _pipeText : FlxText;

    var _pipeRotateTween : FlxTween;

    public function RotateLeft() : Bool {
        if (!_pipeRotateTween.active) {
            _pipeRotateTween = FlxTween.tween(_pipeIcon,{angle: _pipeIcon.angle - 90},0.2);
            return true;
        }
        return false;
    }

    public function RotateRight() : Bool {
        if (!_pipeRotateTween.active) {
            _pipeRotateTween = FlxTween.tween(_pipeIcon,{angle: _pipeIcon.angle + 90},0.2);
            return true;
        }
        return false;
    }

    public function UpdateText(num : Int) : Void {
        _pipeText.text = "x " + num;
    }

    public function SetPosition(X : Float, Y : Float) {
        this.x = X;
        this.y = Y;
        _pipeIcon.setPosition(X, Y);
        _pipeText.setPosition(X + 128, Y + 32);
    }

    public function new(X : Float, Y : Float, pipeType : Player.PipeType, ?startingNumber : Int) : Void {
        super(0,0);
        _pipeType = pipeType;
        _pipeIcon = new FlxSprite(x,y);
        _pipeIcon.loadGraphic(AssetPaths.pipe_ss__png,true,128,128);
        _pipeIcon.animation.frameIndex = switch(pipeType) {
            case STRAIGHT:
                1;
            case CURVED:
                3;
            case CROSS:
                11;
            case TWOWAY:
                10;
        }
        _pipeIcon.scale.set(0.75,0.75);
        _pipeIcon.offset.set(48,48);
        _pipeIcon.updateHitbox();
        _pipeText = new FlxText(x + 64, y, 256);
        _pipeText.size = 48;
        UpdateText(startingNumber);
        _pipeRotateTween = FlxTween.tween(_pipeIcon, { x: _pipeIcon.x }, 0);
    }

    override public function draw() {
        _pipeIcon.draw();
        _pipeText.draw();
    }    
}

class PipeDisplay extends FlxObject {
    var _pipeElements : Array<FlxObject>;
    var _pipeSelectorTween : FlxTween;
    var _pipeSelector : FlxSprite;
    
    public function UpdateText(type : Player.PipeType, newVal : Int) : Void {
        var elementObject : FlxObject = _pipeElements[cast(type,Int)];
        var element : PipeDisplayElement = cast elementObject;
        element.UpdateText(newVal);
    }
    
    public function RotateLeft() : Bool {
        for (elementObject in _pipeElements) {
            var element : PipeDisplayElement = cast elementObject;
            if (!element.RotateLeft())
                return false;
        }
        return true;
    }

    public function RotateRight() : Bool {
        for (elementObject in _pipeElements) {
            var element : PipeDisplayElement = cast elementObject;
            if (!element.RotateRight())
                return false;
        }
        return true;
    }

    public function AlignElements() {
        var localY : Float = y;
        for (elementObject in _pipeElements) {
            var element : PipeDisplayElement = cast elementObject;
            element.SetPosition(x,localY);
            localY += 128;
        }
    }

    public function MoveSelector(type : Player.PipeType) {
        if (_pipeSelectorTween != null)
            _pipeSelectorTween.cancel();
        _pipeSelectorTween = FlxTween.tween(_pipeSelector, {y: _pipeElements[cast type].y}, 0.1);
    }

    public function new(?X:Float=0, ?Y:Float=0, ?initialValues : Array<Int>) {
        super(X,Y);
        this.x = X;
        this.y = Y;
        _pipeElements = new Array<FlxObject>();
        for (i in 0...4) {
            var newIcon : PipeDisplayElement = new PipeDisplayElement(X,Y,cast i,0);
            newIcon.UpdateText(initialValues[i]);
            _pipeElements.push(cast(newIcon,FlxObject));
        }
        AlignElements();
        _pipeSelector = new FlxSprite(x,y,AssetPaths.pipe_selector__png);
        _pipeSelector.scale.set(0.75,0.75);
        _pipeSelector.offset.set(48,48);
        _pipeSelector.updateHitbox();

    }

    override public function draw() {
        for (elementObject in _pipeElements) {
            var element : PipeDisplayElement = cast elementObject;
            element.draw();
        }
        _pipeSelector.draw();
    }
}