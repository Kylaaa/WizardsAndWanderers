package screen
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import managers.ShapesManager;
	
	import ManagerAlpha;
	import screen.MainScreen;
	
	public class Explore extends Screen
	{
		public var exit_btn:SimpleButton;
		
		public function Explore(newManager:ManagerAlpha)
		{
			super(newManager);
			
			exit_btn = ShapesManager.drawButton(0, 0, 100, 100, "exit");
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			addChild(exit_btn);
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
		}
		
		private function onExit(e:MouseEvent):void
		{
			manage.displayScreen(MainScreen);
		}
		
		public override function cleanUp():void
		{
			removeChild(exit_btn);
			exit_btn.removeEventListener(MouseEvent.CLICK, onExit);
			super.cleanUp();
		}
	}
}