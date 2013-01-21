package players 
{
	import bullets.*;
	
	import flash.display.BitmapData;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.*;
	
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class Player extends Entity 
	{
		//Variable to import the Whitebullet class
		protected var currentBullet:Class;
		private var player_Image:Image;
		protected var flipInTween:VarTween;
		protected var flipOutTween:VarTween;
		
		//Emitter for Explosion, graphic that handle the particles
		protected var explosionEmitter:Emitter;
		
		protected const FLIP_SPEED:Number = 0.5;
		protected const EXPLOSION_SIZE:uint = 100;
		protected var collisionNumber:Number = 0;
		protected var fireRate:Number;
		protected var fireTimer:Number;
		
		public function Player(x:int, y:int) 
		{
			super (x, y);
			
			//Add the Iamge to the Variable
			player_Image = new Image(GC.GFX_PLAYER);
			//Magnify the image by two
			player_Image.scale = 2;
			
			//Change the origin of the scale to flip in the middle.
			//Determines transformation point
			player_Image.originX = 16;
			
			//Change Color Tween Animation
									//Do this function when it start, and  persist until it finish
			flipInTween = new VarTween(onFlipInComplete, Tween.PERSIST);
			flipOutTween = new VarTween(onFlipOutComplete, Tween.PERSIST);
			
			//Emitter for explosions
			explosionEmitter =  new Emitter(new BitmapData(4,4), 4, 4);
			
			//Define the Particles
										//For the frames of the animation in this case just one frame
			explosionEmitter.newType("explode", [0]);
			explosionEmitter.setAlpha("explode", 1, 0); //For 
			//nameParticle,angle,distance,duration,angleRange,distanceRange,durationRange,ease
			explosionEmitter.setMotion("explode", 0, 100, 2, 360, -40, -0.5, Ease.quadOut);//nameParticle,angle,distance,duration,
			
			//Dont draw relative to the entity Player coordinates 
			explosionEmitter.relative = false;
			graphic = new Graphiclist(player_Image, explosionEmitter);
			setHitbox(62, 64, 32, 0);
			
			addTween(flipInTween);
			addTween(flipOutTween);
			
			//Set up the currentBullet variable to the WhiteBullet class.
			currentBullet = WhiteBullet;
			
			
			//Define out auto-shoot properties
			fireRate = 0.2;
			fireTimer = 0;
			
			
		}
		
		
		//Function to return the scale to 1 when if FlipIn
		//It also calls switch Color to change the color of the bullet and the player
		protected function onFlipInComplete():void
		{
			switchColor();
			flipOutTween.tween(player_Image, "scaleX", 1, FLIP_SPEED / 2,Ease.quadOut);
			flipOutTween.start();
		}
		
		
		protected function onFlipOutComplete():void
		{
			
		}
		
		protected function switchColor():void
		{
			//Handle Color Shift
			if (currentBullet == WhiteBullet)
			{
				//The Player is Currently White
				player_Image.color = 0;
				explosionEmitter.setColor("explode", 0, 0);
				//Change Bullet Type
				currentBullet = BlackBullet;
				
				
			}
			
			else
			{
				//The player is currently black
				player_Image.color = 0xffffff;
				explosionEmitter.setColor("explode", 0xffffff, 0xffffff);
				currentBullet = WhiteBullet;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			x = Input.mouseX ;//- (width/2) - 2;
			
			//To dont go out of the screen
			if (x < 32) x = 32;
			
			if (x > FP.screen.width - width/2) x = FP.screen.width -width/2;
			
			
			////////////////////////////////////////////////
			
			// The new Stuff
			
			////////////////////////////////////////////////
			if (Input.mousePressed && !flipInTween.active && !flipOutTween.active)
			{
				fireTimer = 0;
				//Spawn our Bullet, it uses the currentBullet class
				this.world.add(new currentBullet(x - 32, y +16));
				
				this.world.add(new currentBullet(x+ 28, y +16));
			}
			//To shot continously when the mouse is pressed
			else if (Input.mouseDown && !flipInTween.active && !flipOutTween.active)
			{
				//The fire Timer is the time elapse you shoot
				fireTimer += FP.elapsed;
				
				//just to test
				//trace(FP.elapsed);
				
				//If the time is grater that the rate then shot
				if (fireTimer > fireRate)
				{
					//trace("Before:"+fireTimer);
					//Set the fire timer to it normal state
					fireTimer -= fireRate;
					
					
					this.world.add(new currentBullet(x - 32, y +16));
				
					this.world.add(new currentBullet(x+ 28, y +16));
					//trace("After time Lapsed"+ FP.elapsed);
				}
			}
			
			
			
			//if (Input.pressed(Key.Z))
			//{
				//Handle the color shift
				//if (currentBullet == WhiteBullet)
				//{
					//Image(this.graphic).color = 0;
					//currentBullet = BlackBullet;
				//}
				//else
				//{
					//The Player is Currently Black.
					//Image(this.graphic).color = 0xffffff;
					//
					//Change the seettiings of the bullet
					//currentBullet = WhiteBullet;
				//}
			//}
			
			if (Input.pressed(Key.Z) && !flipInTween.active && !flipOutTween.active )
			{
				//When it start the Tween it also does the onFlipInComplete() function
				flipInTween.tween(player_Image, "scaleX", 0, FLIP_SPEED/2,Ease.quadIn);
				flipInTween.start();
			}
			
			if (this.collide(GC.TYPE_ENEMY, x, y) && collisionNumber ==0)
			{
				//dead
				//Player no longer colide with things
				
				
				collidable = false;
				player_Image.visible = false;
				
				for (var i:uint = 0; i < EXPLOSION_SIZE; i++)
				{
						explosionEmitter.emit("explode", x , y + height / 2);
						
				}
				
				//this.collidable = false;
				//trace(collidable);
				
				//Does not allow the enemy to colly continuously
				//setHitbox(0, 0, 32, 0);
				
				
				//x = 0;
				//y = 0;
				//
				collisionNumber = 1;
			}
			
			if (!collidable && explosionEmitter.particleCount == 0)
			{
				if (this.world != null)
				{
					this.world.remove(this);
				}
				
				collisionNumber = 0;
			}
		}
		
	}

}