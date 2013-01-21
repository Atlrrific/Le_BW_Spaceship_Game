package  
{
	import enemies.BlackEnemy;
	import enemies.Enemy;
	import enemies.WhiteEnemy;
	import flash.events.TextEvent;
	import flash.text.engine.TextLine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import players.Player;
	import players.*;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class GameWorld extends World 
	{
		//PRotected set a lock on variables that does not need to me modify.
		
		protected var player:Player;
		protected var scoreText:Text;
		protected var gameOverText:Text;
		protected var respawnTimer:Number;
		protected var enemySpeedCounter:Number = 1;
		protected var enemySpawnCounter:Number = 1;
		protected var gameOverCounter:Number = 0;
		public function GameWorld() 
		{
			respawnTimer = 0;
			super();
		}
		
		override public function begin():void 
		{
			//super.begin();
			
			scoreText = new Text("0");
			gameOverText = new Text("Game Over");
			addGraphic(scoreText);
			
			player = new Player(FP.screen.width/2 -6,525);
			//player.x = FP.screen.width/2 -6;
		//	player.y = 250;
			
			this.add(player);
			
		}
		
		
		
		/////////////////////////////////////////////////////
		
		// The UPDATE FUNCTUON
		//////////////////////////////////////////////////
		override public function update():void 
		{
			super.update();
			
			//Put the Enemies , when there is no more add one
			
			//Check the number of type of Entities that are in the world,
			if (this.classCount(Player) !=0)
			{
				
			
			if ((this.typeCount(GC.TYPE_ENEMY) == 0 || FP.random > GC.ENEMY_SPAWN_CHANCE))
			{
				if (FP.rand(2) == 0) add(new WhiteEnemy());
				else add(new BlackEnemy());
			}
			}
			
			
			//Show the score Updated
			scoreText.text = GV.Score.toString();
			
			//Makes the Game harder by giving the enemies more speed and spawn chance
			if (GV.Score == 500 * enemySpeedCounter)
			{
				GC.ENEMY_SPEED += 20;
				
				if (GV.Score == 1000 * enemySpawnCounter)
				{
					GC.ENEMY_SPAWN_CHANCE -= 0.01;
					
					enemySpawnCounter++;
				}
				
				enemySpeedCounter ++;
			}
			
			if (this.classCount(Player) == 0 && gameOverCounter ==0)
			{
				//GAME OVER MESSAGE
				gameOverText.size = 30;
				gameOverText.x = FP.width / 2-gameOverText.width/2;
				gameOverText.y =  FP.height / 2 -100;
				gameOverText.color = 0xff0000;
				
				gameOverText.alpha = 0;
				addGraphic(gameOverText, -2);
				
				var textTween:VarTween = new VarTween();
				textTween.tween(gameOverText, "alpha", 1, 2, Ease.quadIn);
				addTween(textTween, true);
				
				trace("GAME OVER");
				
				gameOverCounter ++;
			}
			//If there is now player
			if (this.classCount(Player) == 0 && this.typeCount(GC.TYPE_ENEMY)==0)
			{
				respawnTimer += FP.elapsed;
				
				//Reset The Score Values
				scoreText.text = "0";
				enemySpeedCounter = 1;
				enemySpawnCounter = 1;
				GV.Score = 0;
				
				//Change the Enemy values to original values
				GC.ENEMY_SPEED = 80;
				GC.ENEMY_SPAWN_CHANCE = 0.99;
				
				//Fading out the Game Over Message
				var textTweenOut:VarTween = new VarTween();
				textTweenOut.tween(gameOverText, "alpha", 0, 1, Ease.quadIn);
				addTween(textTweenOut, true);

				//Check if FP.elapsed is two seconds and then respawn the player
				if (respawnTimer > 1)
				{
					
					createPlayer();
					//player = new Player(FP.screen.width/2 -6,250);
				//	player.x = ;
				//	player.y = 250;
					//this.add(player);

					respawnTimer = 0;
					gameOverCounter = 0;
				}
				
			}
		}
		
		
		///////////////////////////////////////////////////////////////////////
		// Create a new Player
		//
		///////////////////////////////////////////////////////////////////////
		
		public function createPlayer ():void
		{
			
			player = new Player(FP.screen.width/2 -6,525);
				//	player.x = ;
				//player.y = 550;
			this.add(player);
		}
	}

}