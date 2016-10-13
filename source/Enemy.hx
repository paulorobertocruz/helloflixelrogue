package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxObject;
import flixel.util.FlxCollision;
import flixel.group.FlxGroup;
import flixel.tweens.FlxTween;
import flixel.FlxState;

class Enemy extends FlxSprite{

    static public var player:Player;
    static public var friends:FlxTypedGroup<Enemy>;
    static public var walls:FlxTypedGroup<Wall>;
    static public var outerwalls:FlxTypedGroup<Wall>;
    static public var food:FlxTypedGroup<Food>;

    var facePlayer = FlxObject.NONE;

    public function new(_x:Int, _y:Int){
        super(_x, _y);
        makeGraphic(32, 32, FlxColor.RED);

        setFacingFlip(FlxObject.LEFT, true, false);
        setFacingFlip(FlxObject.RIGHT, false, false);

        loadGraphic("assets/images/enemy.png", true, 32, 32);
        animation.add("idle", [0,1,2,3,4,5], 6, true);
        animation.add("atacar", [6, 7], 6, false);
        animation.play("idle");
    }

    override public function update(elapsed:Float):Void{
        if(animation.finished)
          animation.play("idle");
        super.update(elapsed);
    }

    public function playerPerto():Bool{
        if(FlxCollision.pixelPerfectPointCheck(Std.int(getMidpoint().x - width), Std.int(getMidpoint().y), player)){
          facePlayer = FlxObject.RIGHT;
          return true;
        }
        if(FlxCollision.pixelPerfectPointCheck(Std.int(getMidpoint().x + width), Std.int(getMidpoint().y), player)){
          facePlayer = FlxObject.LEFT;
          return true;
        }
        if(FlxCollision.pixelPerfectPointCheck(Std.int(getMidpoint().x), Std.int(getMidpoint().y - height), player)){
          facePlayer = FlxObject.UP;
          return true;
        }
        if(FlxCollision.pixelPerfectPointCheck(Std.int(getMidpoint().x), Std.int(getMidpoint().y + height), player)){
          facePlayer = FlxObject.DOWN;
          return true;
        }

        return false;
    }

    //verifica se o player esta na frente imediatamente
    public function playerNaFrente():Bool{
      switch (facing) {
      case FlxObject.LEFT:
        return FlxCollision.pixelPerfectPointCheck(Std.int(getMidpoint().x - width), Std.int(getMidpoint().y ), player);
      case FlxObject.RIGHT:
        return FlxCollision.pixelPerfectPointCheck(Std.int(getMidpoint().x + width), Std.int(getMidpoint().y ), player);
      case FlxObject.UP:
        return FlxCollision.pixelPerfectPointCheck(Std.int(x), Std.int(y - (height/2)), player);
      case FlxObject.DOWN:
        return FlxCollision.pixelPerfectPointCheck(Std.int(x), Std.int(y + (height/2)), player);
      }
      return false;
    }

    public function atacar():Void{
      animation.play("atacar");
      player.atacado();
    }

    public function podeMoverPara(px:Float, py:Float):Bool{
      var ipx = Std.int(px);
      var ipy = Std.int(py);

      for(w in Enemy.walls){
        if(FlxCollision.pixelPerfectPointCheck(ipx, ipy, w)){
          trace("collide enemy walls");
          return false;
        }
      }
      for(w in Enemy.outerwalls){
        if(FlxCollision.pixelPerfectPointCheck(ipx, ipy, w)){
          trace("collide enemy outerwalls");
          return false;
        }
      }

      for(f in Enemy.friends){
        if(FlxCollision.pixelPerfectPointCheck(ipx+16, ipy+16, f)){
          trace("collide enemy friend");
          return false;
        }
      }

      for(f in Enemy.food){
        if(FlxCollision.pixelPerfectPointCheck(ipx+16, ipy+16, f)){
          trace("collide enemy food");
          return false;
        }
      }

      return true;
    }

    public function move(px:Float, py:Float):Void{
      // FlxTween.tween(this, {x:px, y:py}, 0.05);
      x = px;
      y = py;
    }

    public function nextMove():Void{
      if(playerNaFrente()){
        //se perto do player ataca
        atacar();
      }
      else if(playerPerto()){
        //vira para player e ataca
        facing = facePlayer;
        atacar();
      }
      else{
        var distx = player.x - x;
        var disty = player.y - y;

        if(Math.abs(distx) > Math.abs(disty)){
          if( distx > 0){
            if(podeMoverPara(x+32, y)){
              facing = FlxObject.LEFT;
              move(x+32, y);
              return;
            }
          }else{
            if(podeMoverPara(x-32, y)){
              facing = FlxObject.RIGHT;
              move(x-32, y);
              return;
            }
          }
        }
        //tenta mover vertical
        if(disty > 0){
          if(podeMoverPara(x, y+32)){
            facing = FlxObject.DOWN;
            move(x, y+32);
            return;
          }
        }else{
          if(podeMoverPara(x, y-32)){
            facing = FlxObject.UP;
            move(x, y-32);
            return;
          }
        }

      }
    }

}
