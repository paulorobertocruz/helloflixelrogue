package;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Wall extends FlxSprite{

    public function new(_x:Float, _y:Float):Void {
        super(_x, _y);
        immovable = true;
        makeGraphic(32, 32, FlxColor.YELLOW);
    }

}
