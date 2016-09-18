package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxTween;

class Player extends FlxSprite{
    var tween:FlxTween;

    public function new(_x:Float, _y:Float){
        super(_x, _y);
        // immovable = true;
        makeGraphic(32, 32, FlxColor.WHITE);
    }

    public function play_input(){
        //somente quando é sua jogada você pode mecher o personagem
        if(FlxG.keys.anyJustReleased(["LEFT","A"])){
          tween =  FlxTween.tween(this,{x:this.x -this.width} ,0.05);
        }else if(FlxG.keys.anyJustReleased(["RIGHT","D"])){
          tween =  FlxTween.tween(this,{x:this.x +this.width} ,0.05);
        }else if(FlxG.keys.anyJustReleased(["UP","W"])){
          tween =  FlxTween.tween(this,{y:this.y -this.width} ,0.05);
        }else if(FlxG.keys.anyJustReleased(["DOWN","S"])){
          tween =  FlxTween.tween(this,{y:this.y +this.width} ,0.05);
        }
    }

    public function stop_tween(){
      tween.cancel();
    }


    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}
