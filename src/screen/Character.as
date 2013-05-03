package screen
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import managers.ShapesManager;
	
	import ManagerAlpha;
	import screen.MainScreen;
	import code.*;
	
	public class Character extends Screen
	{
		public var exit_btn:SimpleButton;
		
		public function Character(newManager:ManagerAlpha)
		{
			super(newManager);
			exit_btn = ShapesManager.drawButton(25, 25, 200, 100, "exit");
			
		}
		
		public override function bringIn()
		{
			super.bringIn();
			this.addChild(exit_btn);
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