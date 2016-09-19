package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class OuterWall extends FlxSprite{

  public function new(_x:Int, _y:Int) {
    super(_x, _y);
    immovable = true;

    var images = ["wall_0.png", "wall_1.png"];
    var index:Int = FlxG.random.int(0, images.length-1);

    loadGraphic("assets/images/"+images[index],false, 32, 32);
  }

}
