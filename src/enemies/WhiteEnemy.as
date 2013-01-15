package enemies 
{
	//import bullets.Bullet;
	import bullets.*;
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class WhiteEnemy extends Enemy 
	{
		
		public function WhiteEnemy() 
		{
			super();
			
		}
		
		override protected function hit(b:Bullet):void
		{
			super.hit(b);
			if (b.type == GC.TYPE_BLACK_BULLET)
			{
				this.world.remove(this);
				this.getScore();
			}
		}
		
	}

}