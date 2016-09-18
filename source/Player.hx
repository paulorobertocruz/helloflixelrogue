package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.tweens.FlxTween;

class Player extends FlxSprite{

    public function new(_x:Float, _y:Float){
        super(_x, _y);
        immovable = true;
        makeGraphic(32, 32, FlxColor.WHITE);
    }

    public function play_input(){
        //somente quando é sua jogada você pode mecher o personagem
        if(FlxG.keys.anyJustReleased(["LEFT","A"])){
            FlxTween.tween(this,{x:this.x -this.width} ,0.05);
        }else if(FlxG.keys.anyJustReleased(["RIGHT","D"])){
            FlxTween.tween(this,{x:this.x +this.width} ,0.05);
        }else if(FlxG.keys.anyJustReleased(["UP","W"])){
            FlxTween.tween(this,{y:this.y -this.width} ,0.05);
        }else if(FlxG.keys.anyJustReleased(["DOWN","S"])){
            FlxTween.tween(this,{y:this.y +this.width} ,0.05);
        }
    }


    override public function update(elapsed:Float):Void{
        super.update(elapsed);
    }
}
