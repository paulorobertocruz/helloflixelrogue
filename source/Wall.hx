package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

class Wall extends FlxSprite{

    public function new(_x:Float, _y:Float):Void {
        super(_x, _y);
        immovable = true;

        var images = ["wall_0.png", "wall_1.png"];
        var index:Int = FlxG.random.int(0, images.length-1);

        loadGraphic("assets/images/"+images[index],false, 32, 32);
    }

}
