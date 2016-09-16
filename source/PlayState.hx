package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;


class Inter{

		public var min:Int;
		public var max:Int;

		public function new(mi:Int, ma:Int):Void{
			min = mi;
			max = ma;
		}
}
enum Turn {
	Player;
	Enemy;
}

class PlayState extends FlxState
{

	var level:Int = 1;
	var tileWidth:Int = 32;
	var tileHeight:Int = 32;
	var boardWidth:Int = 8;
	var boardHeight:Int = 8;
	var turn:Turn = Turn.Player;

	var InterEnemies:Inter = new Inter(1, 4);
	var InterWalls:Inter = new Inter(4, 10);

	var walls:FlxGroup;
	var enemies:FlxGroup;
	var food:FlxGroup;
	var player:Player;

	override public function create():Void
	{
		player = new Player(0, 0);
		enemies = new FlxGroup();
		walls = new FlxGroup();
		food = new FlxGroup();

		add(walls);
		add(enemies);
		add(player);
		add(food);

		loadLevel();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(player, walls);
		if(turn == Turn.Player){
			player.play_input();
		}else{
			//
		}


		super.update(elapsed);
	}

	public function loadLevel():Void{

		//place lugares disponiveis
		var pontos:Array<FlxPoint> = new Array<FlxPoint>();
		for(i in 0...boardWidth){
			for(j in 0...boardHeight){
				pontos.push(new FlxPoint(tileWidth * boardWidth, tileHeight * boardHeight));
			}
		}

		var qtdWalls:Int = FlxG.random.int(InterWalls.min, InterWalls.max);
		trace(qtdWalls);
		while( qtdWalls > 0 ) {
			trace("wall");
			qtdWalls -= 1;
			//get random FlxPoint
			var pointIndex:Int = FlxG.random.int(0, pontos.length);
			var currentPoint:FlxPoint = pontos[pointIndex];
			walls.add(new Wall(currentPoint.x, currentPoint.y));
			pontos.remove(currentPoint);
		}

		//place the player
		player.x = tileWidth * 2;
		player.y = tileHeight * 2;
		//place walls


	}
}
