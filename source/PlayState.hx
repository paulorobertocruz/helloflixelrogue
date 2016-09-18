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
	var boardWidth:Int;
	var boardHeight:Int;
	var turn:Turn = Turn.Player;

	var InterEnemies:Inter = new Inter(1, 4);
	var InterWalls:Inter = new Inter(4, 10);

	//game objects
	var exit:Exit;
	var walls:FlxGroup;
	var enemies:FlxGroup;
	var food:FlxGroup;
	var player:Player;

	override public function create():Void
	{
		boardWidth = Std.int(FlxG.width/tileWidth);
		boardHeight = Std.int(FlxG.height/tileHeight);

		trace(boardWidth);
		trace(boardHeight);

		player = new Player(0, 0);
		enemies = new FlxGroup();
		walls = new FlxGroup();
		food = new FlxGroup();
		//saida da dangeon
		exit = new Exit((boardWidth-2) * tileWidth, 1 * tileHeight);

		add(walls);
		add(enemies);
		add(exit);
		add(player);
		add(food);


		loadLevel();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(player, walls, collide_player_wall);

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

		for(i in 2...boardWidth-2){
			for(j in 2...boardHeight-2){
				pontos.push(new FlxPoint(tileWidth * i, tileHeight * j));
			}
		}

		var qtdWalls:Int = FlxG.random.int(InterWalls.min, InterWalls.max);

		while( qtdWalls > 0 ) {
			qtdWalls -= 1;
			trace("length: " + pontos.length);
			var pointIndex:Int = FlxG.random.int(0, pontos.length - 1);
			var currentPoint:FlxPoint = pontos[pointIndex];
			walls.add(new Wall(currentPoint.x, currentPoint.y));
			pontos.remove(currentPoint);
		}

		//place the player
		player.x = tileWidth * 2;
		player.y = tileHeight * 2;
		//place walls


	}

	public function collide_player_wall(p:Player, w:Wall):Void{
		trace("collide p w");
	}

}
