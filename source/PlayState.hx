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
	var hudDayText:FlxText;
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
	var background:FlxGroup;
	var outerwalls:FlxGroup;
	var enemies:FlxGroup;
	var food:FlxGroup;
	var player:Player;

	override public function create():Void
	{
		boardWidth = Std.int(FlxG.width/tileWidth);
		boardHeight = Std.int(FlxG.height/tileHeight);

		hudDayText = new FlxText("Dia: "+ level);
		player = new Player(0, 0);
		enemies = new FlxGroup();
		background = new FlxGroup();
		outerwalls = new FlxGroup();
		walls = new FlxGroup();
		food = new FlxGroup();
		//saida da dangeon
		exit = new Exit((boardWidth-2) * tileWidth, 1 * tileHeight);

		//backgound
		for( i in 1...boardWidth-1){
			for( j in 1...boardHeight-1){
				background.add(new Background(tileWidth * i, tileHeight * j));
			}
		}
		add(background);

		//parede mais externa
		for(i in 0...boardWidth){
			outerwalls.add(new OuterWall(i * tileWidth, 0));
			outerwalls.add(new OuterWall(i * tileWidth, tileHeight * (boardHeight-1) ));
		}
		for(i in 1...boardHeight){
			outerwalls.add(new OuterWall(0, i * tileHeight));
			outerwalls.add(new OuterWall(tileWidth * (boardWidth-1), i * tileHeight));
		}
		add(outerwalls);

		add(walls);
		add(enemies);
		add(exit);
		add(player);
		add(food);
		add(hudDayText);

		loadLevel();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		//colide com paredes
		FlxG.collide(player, walls);
		FlxG.collide(player, outerwalls);

		//colide com a saida e vai para o proximo nivel(dia)
		FlxG.collide(player, exit, function(p:Player, e:Exit):Void{
			level += 1;
			player.stop_tween();
			loadLevel();
		});

		if(turn == Turn.Player){
			player.play_input();
		}else{
			//
		}


		super.update(elapsed);
	}

	public function loadLevel():Void{
		//set text
		hudDayText.text = "Dia: "+ level;
		//reset level
		walls.forEach( function(w):Void{
			walls.remove(w);
		});

		//remove todos os enemies
		enemies.forEach( function(e):Void{
			enemies.remove(e);
		});

		//posiciona o jogador
		player.x = tileWidth;
		player.y = (boardHeight - 2) * tileHeight;

		//place lugares disponiveis
		var pontos:Array<FlxPoint> = new Array<FlxPoint>();

		for(i in 2...boardWidth-2){
			for(j in 2...boardHeight-2){
				pontos.push(new FlxPoint(tileWidth * i, tileHeight * j));
			}
		}

		//coloca paredes no level
		var qtdWalls:Int = FlxG.random.int(InterWalls.min, InterWalls.max);
		while( qtdWalls > 0 ) {
			qtdWalls -= 1;
			//pega um ponto de forma aleatoria
			var pointIndex:Int = FlxG.random.int(0, pontos.length - 1);
			var currentPoint:FlxPoint = pontos[pointIndex];
			walls.add(new Wall(currentPoint.x, currentPoint.y));
			//remove o ponto da lista de pontos disponiveis
			pontos.remove(currentPoint);
		}

		//coloca comida

		//coloca inimigos
		var qtdEnemies:Int = FlxG.random.int(InterEnemies.min, InterEnemies.max);
		while(qtdEnemies > 0){
			qtdEnemies -= 1;
			//pega um ponto de forma aleatoria
			var pointIndex:Int = FlxG.random.int(0, pontos.length - 1);
			var currentPoint:FlxPoint = pontos[pointIndex];
			enemies.add(new Enemy(currentPoint.x, currentPoint.y));
			//remove o ponto da lista de pontos disponiveis
			pontos.remove(currentPoint);
		}




	}
}
