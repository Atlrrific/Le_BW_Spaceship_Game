package bullets 
{
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class BlackBullet extends Bullet 
	{
		
		public function BlackBullet( x:int, y:int)
		{
			super(x, y);
			this.type = GC.TYPE_BLACK_BULLET;
			
			//Change the Color of the Bullet from the bullet entity.
			Image(this.graphic).color = 0x000000;
		}
		
	}

}