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
import flixel.util.FlxCollision;
import flixel.util.FlxTimer;

class Inter{

		public var min:Int;
		public var max:Int;

		public function new(mi:Int, ma:Int):Void{
			min = mi;
			max = ma;
		}
}

enum Turn {
	PlayerT;
	EnemyT;
}

class PlayState extends FlxState
{
	var timer:FlxTimer;
	var enemyPlayed:Bool = false;
	var hudDayText:FlxText;
	var hudFoodText:FlxText;
	var level:Int = 1;
	var tileWidth:Int = 32;
	var tileHeight:Int = 32;
	var boardWidth:Int;
	var boardHeight:Int;
	var turn:Turn = Turn.PlayerT;
	var playerTurn:Int = 1;
	var playerTurnMax:Int = 1;

	var InterEnemies:Inter = new Inter(3, 6);
	var InterWalls:Inter = new Inter(5, 10);
	var InterComida:Inter = new Inter(1, 4);

	//game objects
	var exit:Exit;
	var walls:FlxTypedGroup<Wall>;
	var background:FlxGroup;
	var outerwalls:FlxTypedGroup<Wall>;
	var enemies:FlxTypedGroup<Enemy>;
	var food:FlxTypedGroup<Food>;
	var player:Player;

	override public function create():Void
	{
		boardWidth = Std.int(FlxG.width/tileWidth);
		boardHeight = Std.int(FlxG.height/tileHeight);

		hudDayText = new FlxText("Dia: "+ level);
		player = new Player(0, 0);
		enemies = new FlxTypedGroup<Enemy>();
		background = new FlxGroup();
		outerwalls = new FlxTypedGroup<Wall>();
		walls = new FlxTypedGroup<Wall>();
		food = new FlxTypedGroup<Food>();
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
			outerwalls.add(new Wall(i * tileWidth, 0));
			outerwalls.add(new Wall(i * tileWidth, tileHeight * (boardHeight-1) ));
		}
		for(i in 1...boardHeight){
			outerwalls.add(new Wall(0, i * tileHeight));
			outerwalls.add(new Wall(tileWidth * (boardWidth-1), i * tileHeight));
		}

		add(outerwalls);
		add(walls);
		add(enemies);
		add(exit);
		add(player);
		add(food);
		add(hudDayText);

		Enemy.player = player;
		Enemy.walls = walls;
		Enemy.friends = enemies;
		Enemy.food = food;
		Enemy.outerwalls = outerwalls;


		loadLevel();
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		//colide com paredes
		FlxG.collide(player, walls);
		FlxG.collide(player, outerwalls);
		// FlxG.collide(enemies, enemies);


		//colide com a saida e vai para o proximo nivel(dia)
		FlxG.collide(player, exit, function(p:Player, e:Exit):Void{
			level += 1;
			player.stop_tween();
			loadLevel();
			//timer load new level
		});

		FlxG.overlap(player, food, function(p:Player, f:Food):Void{
			f.kill();
			p.addFood();
		});

		if(turn == Turn.PlayerT && playerTurn > 0){
			if(player.play_input())
				playerTurn -= 1;

			if(playerTurn <= 0)
				turn = Turn.EnemyT;
		}else if(!enemyPlayed){
			//sleep
			enemyPlayed = true;
			timer = new FlxTimer().start(0.1, function(f:FlxTimer){
				turn = Turn.PlayerT;

				playerTurn = playerTurnMax;

				enemies.forEach(function(e:Enemy):Void{
					e.nextMove();
				});
				timer.destroy();
				enemyPlayed = false;
			});

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

		//remove todas as comidas
		food.forEach( function(f):Void{
			food.remove(f);
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
		var qtdComida:Int = FlxG.random.int(InterComida.min, InterComida.max);
		while(qtdComida > 0){
			qtdComida -= 1;
			//pega um ponto de forma aleatoria
			var pointIndex:Int = FlxG.random.int(0, pontos.length - 1);
			var currentPoint:FlxPoint = pontos[pointIndex];
			food.add(new Food( Std.int(currentPoint.x), Std.int(currentPoint.y) ));
			//remove o ponto da lista de pontos disponiveis
			pontos.remove(currentPoint);
		}

		//coloca inimigos
		var qtdEnemies:Int = FlxG.random.int(InterEnemies.min, InterEnemies.max);
		while(qtdEnemies > 0){
			qtdEnemies -= 1;
			//pega um ponto de forma aleatoria
			var pointIndex:Int = FlxG.random.int(0, pontos.length - 1);
			var currentPoint:FlxPoint = pontos[pointIndex];
			enemies.add(new Enemy(Std.int(currentPoint.x), Std.int(currentPoint.y)));
			//remove o ponto da lista de pontos disponiveis
			pontos.remove(currentPoint);
		}




	}
}
