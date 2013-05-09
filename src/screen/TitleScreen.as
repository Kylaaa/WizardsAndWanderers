package screen
{
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import managers.ImageManager;
	import managers.ShapesManager;
	import gps.Mobile;
	
	import ManagerAlpha;
	import screen.MainScreen;
	
	public class TitleScreen extends Screen
	{
		public var play_btn:SimpleButton;
		
		private var wizBtn:SimpleButton;
		private var druBtn:SimpleButton;
		
		private var background:Bitmap;
		
		public function TitleScreen(newManager:ManagerAlpha)
		{
			super(newManager);
			
			background = ImageManager.TitleScreen();
			background.x = 0;
			background.y = 0;
			
			trace("Current Biome Type: " + manage.device.CurrentBiome.Type);
			play_btn = ShapesManager.drawButton(-100, -110, 200, 100, "PLAY", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			
			
		}
		
		override public function bringIn():void 
		{
			super.bringIn();
			trace("");
			
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
			wizBtn = ShapesManager.drawButton(0, 0, stage.stageWidth / 2, stage.stageHeight, null, "wizard");
			wizBtn.addEventListener(MouseEvent.CLICK, wizardChoice);
			addChild(wizBtn);
			
			druBtn = ShapesManager.drawButton(stage.stageWidth / 2, 0, stage.stageWidth / 2, stage.stageHeight, null, "druid");
			druBtn.addEventListener(MouseEvent.CLICK, druidChoice);
			addChild(druBtn);
		}
		
		private function wizardChoice(e:MouseEvent):void
		{
			manage.player.level = 1;
			manage.displayScreen(MainScreen);
		}
		
		private function druidChoice(e:MouseEvent):void
		{
			manage.player.level = 10;
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