package screen
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import rpg.ManagerAlpha;
	
	import screen.MainScreen;
	
	public class TitleScreen extends Screen
	{
		public var play_btn
		
		public function TitleScreen(newManager:ManagerAlpha)
		{
			super(newManager);
		}
		
		public override function bringIn()
		{
			super.bringIn();
			play_btn.addEventListener(MouseEvent.CLICK, onPlay);
		}
		
		private function onPlay(e:MouseEvent)
		{
			manage.displayScreen(MainScreen);
		}
		
		public override function cleanUp()
		{
			play_btn.removeEventListener(MouseEvent.CLICK, onPlay);
			super.cleanUp();
		}
	}
}