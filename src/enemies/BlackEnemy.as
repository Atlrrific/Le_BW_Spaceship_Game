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
			super();
			Image(this.graphic).color = 0;
			
		}
		
		override protected function hit(b:Bullet):void
		{
			super.hit(b);
			if (b.type == GC.TYPE_WHITE_BULLET)
			{
				this.world.remove(this);
				this.getScore();
			}
		}
		
	}

}