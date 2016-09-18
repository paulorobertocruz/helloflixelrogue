package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Background extends FlxSprite{

  public function new(_x:Int, _y:Int):Void{
    super(_x, _y);
    makeGraphic(32, 32, FlxColor.GREEN );
  }

}
