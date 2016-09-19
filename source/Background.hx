package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Background extends FlxSprite{

  public function new(_x:Int, _y:Int):Void{

    var images = ["back_0.png","back_1.png", "back_2.png", "back_3.png", "back_4.png"];
    var index:Int = FlxG.random.int(0, images.length-1);

    super(_x, _y);
    loadGraphic("assets/images/"+images[index],false, 32, 32);
  }

}
