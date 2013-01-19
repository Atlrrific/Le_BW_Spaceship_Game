package  
{
	import enemies.BlackEnemy;
	import enemies.Enemy;
	import enemies.WhiteEnemy;
	import flash.text.engine.TextLine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import players.Player;
	import players.*;
	
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class GameWorld extends World 
	{
		//PRotected set a lock on variables that does not need to me modify.
		
		protected var player:Player;
		protected var scoreText:Text;
		protected var respawnTimer:Number;
		public function GameWorld() 
		{
			respawnTimer = 0;
			super();
		}
		
		override public function begin():void 
		{
			//super.begin();
			
			scoreText = new Text("0");
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
			
			//If there is now player
			if (this.classCount(Player) == 0 && this.typeCount(GC.TYPE_ENEMY)==0)
			{
				respawnTimer += FP.elapsed;
				scoreText.text = "0";
				//Check if FP.elapsed is two seconds and then respawn the player
				if (respawnTimer > 2)
				{
					
					createPlayer();
					//player = new Player(FP.screen.width/2 -6,250);
				//	player.x = ;
				//	player.y = 250;
					//this.add(player);

					respawnTimer = 0;
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