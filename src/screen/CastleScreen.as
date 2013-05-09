package screen
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import managers.ImageManager;
	import managers.ShapesManager;
	
	import ManagerAlpha;
	import screen.MainScreen;
	
	public class CastleScreen extends Screen
	{
		public var exit_btn:SimpleButton;
		
		public function CastleScreen(newManager:ManagerAlpha)
		{
			super(newManager);
			exit_btn = ShapesManager.drawButton(0, -100, 200, 100, "Back", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
			
			
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			
			this.addChild(manage.biomeBackground);
			this.addChild(ShapesManager.drawImage("under-construction.png", -250, -200, 500, 400, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y));
			this.addChild(ShapesManager.drawText("Customize Home Castle", -250, -190, 500, 200, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y));
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