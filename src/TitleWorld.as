package  
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.graphics.Text
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class TitleWorld extends World 
	{
		//Entities fot the titles animations
		protected var topTitle:Entity;
		protected var bottomTitle:Entity;
		protected var hasPlayedTitle:Boolean;
		protected var infoText:Text;
		public function TitleWorld() 
		{
			super();
		}
		
		
		//Set up the images into the entities
		override public function begin():void 
		{
			super.begin();
			topTitle = addGraphic(new Image(GC.GFX_TITLE_TOP));
			topTitle.y = -FP.screen.height ;
			
			bottomTitle = addGraphic(new Image(GC.GFX_TITLE_BOTTOM));
			bottomTitle.y = FP.screen.height * 1.5;
			
			
			//Create Tweens
			var topTween:VarTween = new VarTween(onBounceIn);
			//What to Tween (Object,properties,from,to,ease)
			topTween.tween(topTitle, "y", 0, 1.5, Ease.bounceOut);
			addTween(topTween, true);
			
			var bottomTween:VarTween = new VarTween();
			//What to Tween (Object,properties,from,to,ease)
			bottomTween.tween(bottomTitle, "y", FP.screen.height/2, 1.5,Ease.bounceOut);
			addTween(bottomTween, true);
			
			
		}
		
	//Creates the Text and put it on the Screen with a Tween
	//Does not allow the user to Start unless the tween finish
		protected function onBounceIn():void
		{
			//hasPlayedTitle = true;
			Text.size = 22;
			
			infoText = new Text("click to play");
			infoText.x = FP.screen.width / 2 - infoText.width/ 2;//;*infoText.width;
			infoText.y = FP.screen.height - 40;
			infoText.color = 0;
			//infoText.scale = 2;
			infoText.alpha = 0;
			addGraphic(infoText, -1);
			
			var textTween:VarTween = new VarTween(onTextFade);
			textTween.tween(infoText, "alpha", 1, 0.5, Ease.quadIn);
			addTween(textTween, true);
		}
		
		
		
	//Function to set has playedTitle true when the tween played

		protected function onTextFade():void
		{
			hasPlayedTitle = true;
		}
		
		//Update Function to the Game
		
		override public function update():void 
		{
			super.update();
			
			if (Input.mousePressed && hasPlayedTitle)
			{
				//Handle continious for going to the next world
				FP.world = new GameWorld();
			}
		}
		
	}

}
