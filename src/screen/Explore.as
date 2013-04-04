package screen
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import rpg.ManagerAlpha;
	import screen.MainScreen;
	
	public class Explore extends Screen
	{
		public var exit_btn:SimpleButton;
		
		public function Explore(newManager:ManagerAlpha)
		{
			super(newManager);
		}
		
		public override function bringIn()
		{
			super.bringIn();
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
		}
		
		private function onExit(e:MouseEvent)
		{
			manage.displayScreen(MainScreen);
		}
		
		public override function cleanUp()
		{
			exit_btn.removeEventListener(MouseEvent.CLICK, onExit);
			super.cleanUp();
		}
	}
}