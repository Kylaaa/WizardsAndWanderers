package screen
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import managers.ShapesManager;
	
	import ManagerAlpha;
	import screen.MainScreen;
	
	public class TitleScreen extends Screen
	{
		public var play_btn:SimpleButton;
		
		public function TitleScreen(newManager:ManagerAlpha)
		{
			super(newManager);
			
			play_btn = ShapesManager.drawButton(0, 0, 0, 0, "play");
		}
		
		override public function bringIn():void 
		{
			super.bringIn();
			play_btn.addEventListener(MouseEvent.CLICK, onPlay);
		}
		
		private function onPlay(e:MouseEvent):void
		{
			manage.displayScreen(MainScreen);
		}
		
		override public function cleanUp():void 
		{
			play_btn.removeEventListener(MouseEvent.CLICK, onPlay);
			super.cleanUp();
		}
	}
}