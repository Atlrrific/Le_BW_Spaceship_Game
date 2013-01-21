package enemies 
{
	import bullets.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class Enemy extends Entity 
	{
		protected var enemy_Image:Image;
		protected var bulletEmitter:Emitter;
		
		protected const EXPLOSION_SIZE:uint = 20;
		public function Enemy() 
		{
			
			super(FP.rand(FP.screen.width - 20), y);
			
			//Add the image to the Variable
			enemy_Image = new Image(GC.GFX_ENEMY)
			//Magnify it by two
			enemy_Image.scale = 2;
			
			//this.graphic = enemy_Image;
			this.setHitbox(25, 28,-3,-2);
			
			this.type = GC.TYPE_ENEMY;
			
			//Bullet Explsion Emitter
			bulletEmitter = new Emitter(new BitmapData(2, 2, false, 0xff0000), 2, 2);
			bulletEmitter.newType("explode", [0]);
			bulletEmitter.setAlpha("explode", 1, 0);
			bulletEmitter.setMotion("explode", 0, 100, 2, 360, -2, -0.5, Ease.quadOut);
			bulletEmitter.relative = false;
			
			this.graphic = new Graphiclist (enemy_Image, bulletEmitter);

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
				//trace("BULLET HITED");
				//collidable = false;
				//enemy_Image.visible = false;
				
				
				
				hit(b);
			}
			
			if(!collidable && bulletEmitter.particleCount == 0 && world != null)
			{
				this.world.remove(this);
			}
		}
		
		
		//Function to remove the Bullet from the world.b:Bullet from the class
		protected function hit(b:Bullet):void
		{
			
			b.world.remove(b);
			trace("Hit on Enemy Function");
		}
		//protected function enemyExplosion():void
		//{
			//trace("BULLET HITED");
			//collidable = false;
			//enemy_Image.visible = false;
				//
			//for (var i:uint = 0; i < EXPLOSION_SIZE; i++)
			//{
						//bulletEmitter.emit("explode", x , y + height / 2);
						//
			//}
		//}
		protected function getScore() :void
		{
			this.collidable = false;
			setHitbox(0, 0, 0, 0);
			for (var i:uint = 0; i < this.EXPLOSION_SIZE; i++)
			{
					this.bulletEmitter.emit("explode", x+ width/2 , y + height / 2);
						
						//trace ("Explosion Bullet"+i);
			}
			GV.Score += GC.ENEMY_VALUE;
			
			enemy_Image.visible = false;
			
		}
	}

}