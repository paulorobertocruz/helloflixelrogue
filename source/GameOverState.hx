package;

import flixel.FlxG;
import flixel.FlxState;

class GameOverState extends FlxState{


    override public function create():Void{
        FlxG.switchState(new PlayState());
    }

    override public function update(elapsed:Float):Void{

    }
}
