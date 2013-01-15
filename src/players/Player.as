package players 
{
	import bullets.BlackBullet;
	import bullets.Bullet;
	import bullets.WhiteBullet;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class Player extends Entity 
	{
		//Variable to import the Whitebullet class
		protected var currentBullet:Class;
		public function Player(x:int, y:int) 
		{
			super (x, y);
			
			graphic = new Image(GC.GFX_PLAYER);
			setHitbox(32, 32, 0, 0);
			
			//Set up the currentBullet variable to the WhiteBullet class.
			currentBullet = WhiteBullet;
		}
		
		override public function update():void 
		{
			super.update();
			
			x = Input.mouseX - width / 2;
			
			//To dont go out of the screen
			if (x < 0) x = 0;
			
			if (x > FP.screen.width - width) x = FP.screen.width - width;
			
			if (Input.mousePressed)
			{
				//Spawn our Bullet, it uses the currentBullet class
				this.world.add(new currentBullet(x + 1, y +16));
				
				this.world.add(new currentBullet(x+29, y +16));
			}
			
			if (Input.pressed(Key.Z))
			{
				//Handle the color shift
				if (currentBullet == WhiteBullet)
				{
					Image(this.graphic).color = 0;
					currentBullet = BlackBullet;
				}
				else
				{
					//The Player is Currently Black.
					Image(this.graphic).color = 0xffffff;
					
					//Change the seettiings of the bullet
					currentBullet = WhiteBullet;
				}
			}
			
			if (this.collide(GC.TYPE_ENEMY, x, y))
			{
				//dead
				this.world.remove(this);
			}
		}
		
	}

}