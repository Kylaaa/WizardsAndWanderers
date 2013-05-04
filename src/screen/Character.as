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
			exit_btn = ShapesManager.drawButton(0, -100, 200, 100, "Back", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
			
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