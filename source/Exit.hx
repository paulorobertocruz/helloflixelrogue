package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Exit extends FlxSprite{

  public function new(_x:Int, _y:Int){
    super(_x, _y);
    immovable = true;
    makeGraphic(32, 32, FlxColor.RED);
  }

}
