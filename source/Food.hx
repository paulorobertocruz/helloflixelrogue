package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Food extends FlxSprite{
  public function new(_x:Int, _y:Int){
    super(_x, _y);
    if(FlxG.random.int(0, 1) < 1){
      loadGraphic("assets/images/drink.png", false, 32, 32);
    }else{
      loadGraphic("assets/images/food.png", false, 32, 32);
    }
  }

}
