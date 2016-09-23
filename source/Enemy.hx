package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Enemy extends FlxSprite{

    public function new(_x:Float, _y:Float){
        super(_x, _y);
        makeGraphic(32, 32, FlxColor.RED);
    }

    public function nextMove():Void{

    }

    override public function update(elapsed:Float):Void{

        super.update(elapsed);
    }
}
