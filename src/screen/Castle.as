package screen
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import managers.ShapesManager;
	
	import ManagerAlpha;
	import screen.MainScreen;
	
	public class Castle extends Screen
	{
		public var exit_btn:SimpleButton;
		
		public function Castle(newManager:ManagerAlpha)
		{
			super(newManager);
			exit_btn = ShapesManager.drawButton(0, 0, 200, 100, "Return", manage.device.CurrentBiome.Type);
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			this.addChild(exit_btn);
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