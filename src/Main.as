package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Atl Arredondo
	 */
	public class Main extends Engine 
	{
		
		public function Main():void 
		{
			//The size of the screen
			//super(160, 300);
			
			super(320, 600);
			//FP.screen.scale = 2;
			
			
			FP.screen.color = 0x888888;
			
			
			//To Enable and disable the console
			//FP.console.enable();
			
			
			
		}
		
		override public function init():void
		{
			//Do first the Title World to continue
			FP.world = new TitleWorld();
			
			
			
		}
		
	}
	
}