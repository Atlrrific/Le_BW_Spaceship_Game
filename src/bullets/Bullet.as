package bullets 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class Bullet extends Entity 
	{
		
		public function Bullet(x:int, y:int) 
		{
			this.x = x;
			this.y = y;
			
			this.setHitbox(2, 2, 0, 0);
			
			//Heigth, Width, transparency and color, for the Bitmap data because there is no image.
			this.graphic = new Image(new BitmapData(2, 2, false, 0xfffffff));
		}
		
		override public function update():void 
		{
			y -= FP.elapsed * GC.BULLET_SPEED;
			
			//Remove the bullet if it goes out of the screen
			if (y < -height) 
			{
				this.world.remove(this);
			}
			super.update();
		}
		
		override public function removed():void 
		{
			super.removed();
			
			trace("See ya ");
		}
		
	}

}