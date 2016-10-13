package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.FlxObject;
import flixel.group.FlxGroup;

class Player extends FlxSprite{

    static public var enemies:FlxTypedGroup<Enemy>;

    var tween:FlxTween;
    var food:Int = 50;

    public function new(_x:Float, _y:Float){
        super(_x, _y);

        loadGraphic("assets/images/player.png", true, 32, 32);

        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        animation.add("atack",[8, 9], 6, false);
        animation.add("idle", [0, 1, 2, 3], 6, true);
        animation.add("die", [6, 7], 2, false);

        animation.play("idle");
    }

    public function play_input(){

        if(FlxG.keys.anyJustReleased(["LEFT","A"])){
          tween =  FlxTween.tween(this,{x:this.x -this.width} ,0.05);
          facing = FlxObject.LEFT;
          if(animation.finished){
            animation.play("idle");
          }
          return true;
        }else if(FlxG.keys.anyJustReleased(["RIGHT","D"])){
          tween =  FlxTween.tween(this,{x:this.x +this.width} ,0.05);
          facing = FlxObject.RIGHT;
          if(animation.finished){
            animation.play("idle");
          }
          return true;
        }else if(FlxG.keys.anyJustReleased(["UP","W"])){
          tween =  FlxTween.tween(this,{y:this.y -this.width} ,0.05);
          facing = FlxObject.UP;
          if(animation.finished){
            animation.play("idle");
          }
          return true;
        }else if(FlxG.keys.anyJustReleased(["DOWN","S"])){
          tween =  FlxTween.tween(this,{y:this.y +this.width} ,0.05);
          facing = FlxObject.DOWN;
          if(animation.finished){
            animation.play("idle");
          }
          return true;
        }
        else if(FlxG.keys.anyJustPressed(["SPACE"])){
          animation.play("atack");
          return true;
        }else{
          if(animation.finished){
            animation.play("idle");
          }
          return false;
        }
    }

    public function stop_tween(){
      tween.cancel();
    }

    public function addFood(){
      food += 3;
    }

    public function getFood():Int{
      return food;
    }

    public function atacado():Void{
      food -= 5;
    }

    public function atacar():Void{
      //inimigos

      //walls
    }

    public function estaMorto():Bool{
      return food <= 0;
    }

    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}
