package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.FlxObject;
class Player extends FlxSprite{
    var tween:FlxTween;

    public function new(_x:Float, _y:Float){
        super(_x, _y);
        // immovable = true;
        //makeGraphic(32, 32, FlxColor.WHITE);
        loadGraphic("assets/images/player.png", true, 32, 32);

        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        animation.add("atack",[8, 9], 6, false);

        animation.add("idle", [0, 1, 2, 3], 6, true);

        animation.add("die", [6, 7], 2, false);

        animation.play("ilde");
        // animation.play("atack");
    }

    public function play_input(){
        //somente quando é sua jogada você pode mecher o personagem
        if(FlxG.keys.anyJustReleased(["LEFT","A"])){
          tween =  FlxTween.tween(this,{x:this.x -this.width} ,0.05);
          facing = FlxObject.LEFT;
          if(animation.finished){
            animation.play("idle");
          }
        }else if(FlxG.keys.anyJustReleased(["RIGHT","D"])){
          tween =  FlxTween.tween(this,{x:this.x +this.width} ,0.05);
          facing = FlxObject.RIGHT;
          if(animation.finished){
            animation.play("idle");
          }
        }else if(FlxG.keys.anyJustReleased(["UP","W"])){
          tween =  FlxTween.tween(this,{y:this.y -this.width} ,0.05);
          facing = FlxObject.UP;
          if(animation.finished){
            animation.play("idle");
          }
        }else if(FlxG.keys.anyJustReleased(["DOWN","S"])){
          tween =  FlxTween.tween(this,{y:this.y +this.width} ,0.05);
          facing = FlxObject.DOWN;
          if(animation.finished){
            animation.play("idle");
          }
        }
        else if(FlxG.keys.anyJustPressed(["SPACE"])){
          animation.play("atack");
        }else{
          if(animation.finished){
            animation.play("idle");
          }
        }
    }

    public function stop_tween(){
      tween.cancel();
    }


    override public function update(elapsed:Float):Void{
      // animation.play("idle");
        super.update(elapsed);
    }
}
