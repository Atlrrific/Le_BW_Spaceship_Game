package  
{
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class GC 
	{
		[Embed(source="../assets/Player2.png")]
		public static const GFX_PLAYER:Class;
		
		[Embed(source="../assets/Enemy.png")]
		public static const GFX_ENEMY:Class;
		public static const ENEMY_SPEED:Number = 40;
		public static const TYPE_ENEMY:String = "enemy";
		public static const ENEMY_SPAWN_CHANCE:Number = 0.99;
		public static const ENEMY_VALUE:Number = 100;
		

		//Integer taht contain the spped of the bullet pixels by second
		//Deploy in the bullets class
		public static const BULLET_SPEED:Number = 200;
		
		//Types of Bullets
		
		public static const TYPE_WHITE_BULLET:String = "white_bullet";
		
		public static const TYPE_BLACK_BULLET:String = "black_bullet";

		
	}

}