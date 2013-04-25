package screen
{
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import managers.ImageManager;
	import managers.ShapesManager;
	import gps.Mobile;
	
	import ManagerAlpha;
	import screen.MainScreen;
	
	public class TitleScreen extends Screen
	{
		public var play_btn:SimpleButton;
		private var background:Bitmap;
		
		public function TitleScreen(newManager:ManagerAlpha)
		{
			super(newManager);
			
			background = ImageManager.TitleScreen();
			background.x = 0;
			background.y = 0;
			
			play_btn = ShapesManager.drawButton(-100, -110, 200, 100, "play", ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			
			
		}
		
		override public function bringIn():void 
		{
			super.bringIn();
			
			//format the logo image
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			this.addChild(background);
			
			//add the play button
			this.addChild(play_btn);
			play_btn.addEventListener(MouseEvent.CLICK, onPlay);
		}
		
		private function onPlay(e:MouseEvent):void
		{
			manage.displayScreen(MainScreen);
		}
		
		override public function cleanUp():void 
		{
		
			this.removeChild(play_btn);
			play_btn.removeEventListener(MouseEvent.CLICK, onPlay);
			super.cleanUp();
		}
	}
}