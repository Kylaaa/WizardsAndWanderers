package screen
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import managers.ShapesManager;
	
	import ManagerAlpha;
	import screen.MainScreen;
	
	public class Explore extends Screen
	{
		public var exit_btn:SimpleButton;
		public var infoLabel:MovieClip;
		
		public function Explore(newManager:ManagerAlpha)
		{
			super(newManager);
			
			exit_btn = ShapesManager.drawButton(0, -100, 200, 100, "Back", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			
			this.addChild(manage.biomeBackground);
			this.addChild(ShapesManager.drawImage("under-construction.png", -250, -200, 500, 400, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y));
			this.addChild(ShapesManager.drawText("Explore", -250, -190, 500, 200, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y));
			
			updateMessage();
			
			this.addChild(exit_btn);
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
			
			
			
		}
		
		
		private function updateMessage():void
		{
			if (infoLabel != null)
			if (this.contains(infoLabel)) { this.removeChild(infoLabel); }
			
			//draw a label with our biome information and stuff
			var message:String = "Current Latitude:\t" + manage.device.CurrentLatitude + "\n";
				message += "Current Longitude:\t" + manage.device.CurrentLongitude + "\n";
				message += "Current Speed:\t" + manage.device.CurrentSpeed + "\n";
				message += "You are currently in Biome #" + manage.device.CurrentBiome.ID + ". A " + manage.device.CurrentBiome.Type + " Biome.\n";
				message += "Here you can expect to fight " + getMonsterNames();
				
			infoLabel = ShapesManager.drawLabel(message, -240, -150, 480, 340, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y, true);
			this.addChild(infoLabel);
		}
		private function getMonsterNames():String
		{
			var monsterNames:String = "";
			for (var i:int = 0; i < manage.device.CurrentBiome.Enemies.length; i++)
			{
				monsterNames += manage.device.CurrentBiome.Enemies[i]["name"] + "s";
				if (i < manage.device.CurrentBiome.Enemies.length - 1) 
					monsterNames += ", ";
			}
			return monsterNames;
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