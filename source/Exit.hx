package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Exit extends FlxSprite{

  public function new(_x:Int, _y:Int){
    super(_x, _y);
    immovable = true;
    loadGraphic("assets/images/exit.png", false, 32, 32);    
  }

}
