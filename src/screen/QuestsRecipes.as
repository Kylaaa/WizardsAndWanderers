package screen
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	import ManagerAlpha;
	import screen.MainScreen;
	
	public class QuestsRecipes extends Screen
	{
		public var exit_btn:SimpleButton;
		
		public function QuestsRecipes(newManager:ManagerAlpha)
		{
			super(newManager);
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
		}
		
		private function onExit(e:MouseEvent):void
		{
			manage.displayScreen(MainScreen);
		}
		
		public override function cleanUp():void
		{
			exit_btn.removeEventListener(MouseEvent.CLICK, onExit);
			super.cleanUp();
		}
	}
}