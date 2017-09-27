package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.math.*;
import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.debug.watch.Tracker;

@:enum
abstract PipeDirection(Int) {
    var UP = 0;
    var RIGHT = 1;
    var DOWN = 2;
    var LEFT = 3;
}

@:enum
abstract PipeType(Int) {
    var STRAIGHT = 0;
    var CURVED = 1;
    var CROSS = 2;
    var TWOWAY = 3;
}

class PipeTileOrder {
    public static var STRAIGHT = [1, 2, 1, 2];
    public static var CURVED = [3, 4, 5, 6];
    public static var CROSS = [11, 11, 11, 11];
    public static var TWOWAY = [10, 7, 8, 9];
}



class Player extends FlxSprite {
    private var gridTween : FlxTween;
    private var tweenDuration : Float = 0.25;
    private var currentMap : GameMap;
    private var pipeMap : FlxTilemap;
    private var currentPipeDirection : Int = 0;
    private var currentPipeType : Int = cast PipeType.STRAIGHT;
    private var characterX : Int = 0;
    private var characterY : Int = 0;
    static var IndexToTileType : Array<Int> = [-1,0,0,1,1,1,1,2,2,2,2,3];

    public function new(?X:Float=0, ?Y:Float=0, mapReference : GameMap) {
        super(X, Y);
        this.x = X;
        this.y = Y;
        // Load player spritesheet
        loadGraphic(AssetPaths.rb_ss__png, true, 128, 128);
        pixelPerfectPosition = true;
        // Set scale, then fix the sprite offset to be the center.
        scale.set(0.5,0.5);
        offset.set(32,32);
        updateHitbox();
        // Animations (currently single frames)
        animation.add("Left", [0,1,2,3,4], 7, false, true, false);
        animation.add("StopLeft", [4,5,0], 7, false, true, false);
        animation.add("Right", [0,1,2,3,4], 7, false, false, false);
        animation.add("StopRight", [4,5,0], 7, false, false, false);
        animation.play("StopRight");
        facing = FlxObject.RIGHT;
        // Assign & initialize various other parameters
        allowCollisions = FlxObject.ANY;
        currentMap = mapReference;
        pipeMap = currentMap._mPipes;
        //   (Figure out how to create a blank, inactive tween later)
        gridTween = FlxTween.tween(this, { x: this.x }, 0);
    }

    // Convert a world-space location to tile-map coordinates.
    private function toTilemapCoords(point : FlxPoint, tileMap : FlxTilemap) : FlxPoint {
        var mapBounds : FlxRect = tileMap.getBounds();
        var normalPoint : FlxPoint = new FlxPoint(point.x - mapBounds.left, point.y - mapBounds.top);
        var tileWidth : Int = cast (mapBounds.width / tileMap.widthInTiles);
        var tileHeight : Int = cast (mapBounds.height / tileMap.heightInTiles);
        return new FlxPoint(Math.floor(normalPoint.x / tileWidth),Math.floor(normalPoint.y / tileHeight));
    }

    // Returns whether a pipe exists at that world-space location.
    private inline function checkPipeExists(point : FlxPoint) {
        return pipeMap.overlapsPoint(point);
    }

    // Returns what type (tile ID) a tile is in map-space.
    private inline function checkPipeType(pointX : Int, pointY : Int) {
        return pipeMap.getTile(pointX, pointY);
    }

    // Check collision. Doesn't use tilemap's bounds().containsPoint as will return false-positives in some situations.
    private function checkCollision(point : FlxPoint):Bool {
        for (tileMap in [currentMap._mWalls,currentMap._mPipes,currentMap._mConstantPipes]) {
            if (point.x < tileMap.x || point.y < tileMap.y)
                return true;
            if (point.x >= tileMap.x + tileMap.width || point.y >= tileMap.y + tileMap.height)
                return true;
            if (tileMap.overlapsPoint(point))
                return true;
        }
        for (entity in currentMap._mEntities) {
            if (entity == this)
                continue;
            if ((cast (entity,FlxSprite)).overlapsPoint(point))
                return true;
        }
        return false;
    }

    private function movement():Void {
		if (!currentMap.winCondition){
			// Retrieve inputs
			var _up:Bool = false;
			var _left:Bool = false;
			var _down:Bool = false;
			var _right:Bool = false;
            var _placePipe:Bool = false;
            var _removePipe:Bool = false;

            #if !FLX_NO_KEYBOARD
            _up = _up || FlxG.keys.anyPressed([W]);
			_left = _left || FlxG.keys.anyPressed([A]);
			_down = _down || FlxG.keys.anyPressed([S]);
			_right = _right || FlxG.keys.anyPressed([D]);
            _placePipe = _placePipe || FlxG.keys.anyPressed([SPACE]);
            _removePipe = _removePipe || FlxG.keys.anyPressed([SHIFT]);
            #end

			#if !FLX_NO_GAMEPAD
			var gamepad = FlxG.gamepads.lastActive;
			if (gamepad != null) {
				_up = _up || gamepad.pressed.DPAD_UP || gamepad.getYAxis(LEFT_ANALOG_STICK) < 0.0;
				_left = _left || gamepad.pressed.DPAD_LEFT || gamepad.getXAxis(LEFT_ANALOG_STICK) < 0.0;
				_down = _down || gamepad.pressed.DPAD_DOWN || gamepad.getYAxis(LEFT_ANALOG_STICK) > 0.0;
				_right = _right || gamepad.pressed.DPAD_RIGHT || gamepad.getXAxis(LEFT_ANALOG_STICK) > 0.0;
                _placePipe = _placePipe || gamepad.pressed.A;
                _removePipe = _removePipe || gamepad.pressed.X;
			}
			#end

			// Only move when not already moving between tiles
			if (!gridTween.active && !_placePipe && !_removePipe) {
				if (_up) {
					// Check the tilemap for a possible collision before moving
					if (!checkCollision(new FlxPoint(x, y - 64))) {
						gridTween = FlxTween.tween(this, { x: this.x, y: this.y - 64}, tweenDuration);
						facing = FlxObject.UP;
					}
				}
				else if (_down) {
					if (!checkCollision(new FlxPoint(x, y + 64))) {
						gridTween = FlxTween.tween(this, { x: this.x, y: this.y + 64}, tweenDuration);
						facing = FlxObject.DOWN;
					}
				}
				else if (_left) {
					if (!checkCollision(new FlxPoint(x - 64, y))) {
						gridTween = FlxTween.tween(this, { x: this.x - 64, y: this.y}, tweenDuration);
						facing = FlxObject.LEFT;
					}
				}
				else if (_right) {
					if (!checkCollision(new FlxPoint(x + 64, y))) {
						gridTween = FlxTween.tween(this, { x: this.x + 64, y: this.y}, tweenDuration);
						facing = FlxObject.RIGHT;
					}
				}
			}

			// Animation Stuff
			switch (animation.name) {
				case "Left":
					if (!gridTween.active) {
						animation.play("StopLeft");
					}
					else if (facing == FlxObject.RIGHT) {
						var currentFrame : Int = animation.frameIndex;
						animation.play("Right");
						animation.frameIndex = currentFrame;
						animation.finish();
					}
				case "Right":
					if (!gridTween.active) {
						animation.play("StopRight");
					}
					else if (facing == FlxObject.LEFT) {
						var currentFrame : Int = animation.frameIndex;
						animation.play("Left");
						animation.frameIndex = currentFrame;
						animation.finish();
					}
				case "StopLeft":
					if (gridTween.active) {
						if (_right)
							animation.play("Right");
						else
							animation.play("Left");
                        
					}
				case "StopRight":
					if (gridTween.active) {
						if (_left)
							animation.play("Left");
						else
							animation.play("Right");
					}
			}
		
		
		}
    }

    private function pipePlace():Void {
        // Retrieve inputs
        var _up:Bool = false;
        var _left:Bool = false;
        var _down:Bool = false;
        var _right:Bool = false;
        var _rotateLeft:Bool = false;
        var _rotateRight:Bool = false;
		var _next:Bool = false;
		var _prev:Bool = false;
        var _placePipe:Bool = false;
        var _removePipe:Bool = false;

        #if !FLX_NO_KEYBOARD
        _up = _up || FlxG.keys.anyJustPressed([W]);
        _left = _left || FlxG.keys.anyJustPressed([A]);
        _down = _down || FlxG.keys.anyJustPressed([S]);
        _right = _right || FlxG.keys.anyJustPressed([D]);
        _rotateLeft = _rotateLeft || FlxG.keys.anyJustPressed([LEFT]);
        _rotateRight = _rotateRight || FlxG.keys.anyJustPressed([RIGHT]);
		_next = _next || FlxG.keys.anyJustPressed([UP]);
		_prev = _prev || FlxG.keys.anyJustPressed([DOWN]);
        _placePipe = _placePipe || FlxG.keys.anyPressed([SPACE]);
        _removePipe = _removePipe || FlxG.keys.anyPressed([SHIFT]);
        #end

        #if !FLX_NO_GAMEPAD
        var gamepad = FlxG.gamepads.lastActive;
        if (gamepad != null) {
            _up = _up || gamepad.pressed.DPAD_UP || gamepad.getYAxis(LEFT_ANALOG_STICK) < 0.0;
			_left = _left || gamepad.pressed.DPAD_LEFT || gamepad.getXAxis(LEFT_ANALOG_STICK) < 0.0;
			_down = _down || gamepad.pressed.DPAD_DOWN || gamepad.getYAxis(LEFT_ANALOG_STICK) > 0.0;
			_right = _right || gamepad.pressed.DPAD_RIGHT || gamepad.getXAxis(LEFT_ANALOG_STICK) > 0.0;
            _rotateLeft = _rotateLeft || gamepad.justPressed.LEFT_SHOULDER;
            _rotateRight = _rotateRight || gamepad.justPressed.RIGHT_SHOULDER;
            _next = _next || gamepad.pressed.B;
		    _prev = _prev || gamepad.pressed.Y;
            _placePipe = _placePipe || gamepad.pressed.A;
            _removePipe = _removePipe || gamepad.pressed.X;
        }
        #end

        // Handle pipe placement rotation
        if ( !(_rotateLeft && _rotateRight) ) {
            // Rotating is just incrementing/decrementing the tile direction enum
            if (_rotateLeft) {
                if (currentMap._pipeDisplay.RotateLeft())
                    currentPipeDirection = currentPipeDirection == 0 ? 3 : currentPipeDirection - 1;
                
            }
            else if (_rotateRight) {
                if (currentMap._pipeDisplay.RotateRight())
                    currentPipeDirection = (currentPipeDirection + 1) % 4;
                
            }
        }
		
		if (!(_next && _prev)){
			if (_next){
				currentPipeType = currentPipeType == 0 ? 3 : currentPipeType - 1;
			}
			else if (_prev){
				currentPipeType = (currentPipeType + 1) % 4;
			}
            currentMap._pipeDisplay.MoveSelector(cast currentPipeType);
		}
		

        // Handle pipe placement
        if (_up || _left || _down || _right) {
            // Find a point to place at
            var placePoint : FlxPoint = new FlxPoint(0,0);
            if (_up) {
                placePoint = new FlxPoint(x, y - 64);
            }
            else if (_left) {
                placePoint = new FlxPoint(x - 64, y);
            }
            else if (_down) {
                placePoint = new FlxPoint(x, y + 64);
            }
            else if (_right) {
                placePoint = new FlxPoint(x + 64, y);
            }
				
            // Get the tile location
            var tileCoords : FlxPoint = toTilemapCoords(placePoint,pipeMap);
            var tileX : Int = cast tileCoords.x;
            var tileY : Int = cast tileCoords.y;

            // If holding shift, remove the tile in that direction.
            if (_removePipe) {
				if (tileX > -1 && tileY > -1){
                    var tileCoords : FlxPoint = toTilemapCoords(placePoint,pipeMap);
                    var tileIndex : Int = pipeMap.getTile(cast tileCoords.x, cast tileCoords.y);
                    if (tileIndex > 0) {
                        pipeMap.setTile(tileX,tileY,0);
                        currentMap.removePipe(tileX, tileY);
                        var pickedPipe : PipeType = cast(IndexToTileType[tileIndex],PipeType);
                        currentMap._pipeAmounts[cast(pickedPipe,Int)] += 1;
                        currentMap._pipeDisplay.UpdateText(cast pickedPipe,currentMap._pipeAmounts[cast pickedPipe]);
                    }
				}
            }

            // If not, place a tile based on the current placement rotation.
            else if (_placePipe) {
                if (!checkCollision(placePoint)) {
                    if (currentMap._pipeAmounts[currentPipeType] > 0) {
                        switch (currentPipeType) {
                            case STRAIGHT:
                                pipeMap.setTile(tileX,tileY,PipeTileOrder.STRAIGHT[currentPipeDirection]);
                                currentMap.addPipe(tileX, tileY, PipeTileOrder.STRAIGHT[currentPipeDirection]);
                            case CURVED:
                                pipeMap.setTile(tileX,tileY,PipeTileOrder.CURVED[currentPipeDirection]);
                                currentMap.addPipe(tileX, tileY, PipeTileOrder.CURVED[currentPipeDirection]);
                            case CROSS:
                                pipeMap.setTile(tileX,tileY,PipeTileOrder.CROSS[currentPipeDirection]);
                                currentMap.addPipe(tileX, tileY, PipeTileOrder.CROSS[currentPipeDirection]);
                            case TWOWAY:
                                pipeMap.setTile(tileX,tileY,PipeTileOrder.TWOWAY[currentPipeDirection]);
                                currentMap.addPipe(tileX, tileY, PipeTileOrder.TWOWAY[currentPipeDirection]);
                        }
                        currentMap._pipeAmounts[currentPipeType] -= 1;
                        currentMap._pipeDisplay.UpdateText(cast currentPipeType,cast(currentMap._pipeAmounts[currentPipeType],Int));
                        if (currentMap.checkSolution()){
                            currentMap.winCondition = true;
                        }
                    }
                    
                }
            }
        }
    }

    override public function update(elapsed:Float):Void {
        pipePlace();
        movement();
        // Debug: Character's tile position.
        characterX = cast toTilemapCoords(new FlxPoint(this.x,this.y),pipeMap).x;
        characterY = cast toTilemapCoords(new FlxPoint(this.x,this.y),pipeMap).y;
        super.update(elapsed);
    }
}