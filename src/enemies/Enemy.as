package enemies 
{
	import bullets.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.Graphic;
	
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class Enemy extends Entity 
	{
		private var enemy_Image:Image;
		public function Enemy() 
		{
			
			super(FP.rand(FP.screen.width - 20), y);
			
			//Add the image to the Variable
			enemy_Image = new Image(GC.GFX_ENEMY)
			//Magnify it by two
			enemy_Image.scale = 2;
			
			this.graphic = enemy_Image;
			
			this.setHitbox(25, 28,-3,-2);
			
			this.type = GC.TYPE_ENEMY;
		}
		
		override public function update():void 
		{
			super.update();
			this.y += FP.elapsed * GC.ENEMY_SPEED;
			
			if (this.y > FP.screen.height) this.world.remove(this);
			
			//Variable b check if it is true that there is a bulet on the enemy coordinates
			//var b:Bullet = Bullet(this.collideTypes([GC.TYPE_WHITE_BULLET,GC.TYPE_BLACK_BULLET], x, y));
			var b:Bullet = Bullet(this.collideTypes([GC.TYPE_WHITE_BULLET, GC.TYPE_BLACK_BULLET], x, y));
			if (b != null)
			{
				trace("BULLET HITED");
				hit(b);
			}
		}
		
		
		//Function to remove the Bullet from the world.b:Bullet from the class
		protected function hit(b:Bullet):void
		{
			//Stuf for children. Pass it the Bullet class with all the properties
			b.world.remove(b);
			
		}
		
		protected function getScore() :void
		{
			GV.Score += GC.ENEMY_VALUE;
		}
	}

}