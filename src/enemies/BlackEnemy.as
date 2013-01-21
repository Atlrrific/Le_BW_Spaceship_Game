package enemies 
{
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	
	 import net.flashpunk.graphics.Image;
	 import bullets.*;
	public class BlackEnemy extends Enemy 
	{
		
		
		public function BlackEnemy() 
		{
			//enemy_Image1 = new Image(this.addGraphic(enemy_Image));
			
			super();
			Image(enemy_Image).color = 0;
			
		}
		
		override protected function hit(b:Bullet):void
		{
			super.hit(b);
			if (b.type == GC.TYPE_WHITE_BULLET)
			{
				
				
				
					//trace("REmove ENEMY");
					//this.world.remove(this);
					
					this.getScore();
				
				
			}
		}
		
	}

}