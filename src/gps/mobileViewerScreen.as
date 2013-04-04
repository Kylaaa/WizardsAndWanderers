package gps {
	
	import screen.MainScreen;
	import screen.Screen;
	import rpg.ManagerAlpha;
	
	import gps.Mobile;
	import gps.Database;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	import flash.events.*;
	
	public class mobileViewerScreen extends Screen {
		
		public var exit_btn:SimpleButton;
		
		//on screen fields
		public var txtLongVal:TextField;
		public var txtLatVal:TextField;
		public var txtSpeedVal:TextField;
		public var txtBiomeIDVal:TextField;
		public var txtBiomeType:TextField;
		public var txtBiomeMonsters:TextField;
		public var txtErrorMessage:TextField;

		var device:Mobile;
		var db:Database;
		
		public function mobileViewerScreen(newManager:ManagerAlpha) 
		{
			super(newManager);
			
			// constructor code
			txtErrorMessage.text = "";
			
			//progress bar
			prgLoader.setProgress(0, 100);
			
			//initialize the database first
			db = new Database(txtErrorMessage);
			db.addEventListener(Event.COMPLETE, dbLoaded)
		}
		
		
		private function dbLoaded(e:Event):void
		{
			//initialize our mobile stuff
			device = new Mobile(db, txtErrorMessage);
			device.addEventListener(Event.CHANGE, locationChange);
			device.addEventListener(Event.COMPLETE, locationReady);
			prgLoader.setProgress(50, 100);
		}
		
		private function locationReady(e:Event):void
		{
			//clear off the stage
			if (this.stage.numChildren >= 2)
			this.stage.removeChildren(1, this.stage.numChildren -1);
			
			if (device.IsReady)
			{
				txtBiomeIDVal.text = device.CurrentBiome.ID;
				txtBiomeType.text = device.CurrentBiome.Type;
				
				//build our string of enemies
				var enemyNames:String = "";
				for (var i:int = 0; i < device.CurrentBiome.Enemies.length; i++)
				{
					enemyNames += device.CurrentBiome.Enemies[i]["name"].toString() + ", ";
					
					
					//draw it to the screen too
					try
					{
						device.CurrentBiome.drawEnemy(this.stage, i, 15 + (i * 70), 5);
					}
					catch (err:Error)
					{
						txtErrorMessage.text = "Error Loading " + device.CurrentBiome.Enemies[i]["name"].toString() + "\'s image.\n";
						txtErrorMessage.appendText(err.getStackTrace());		
					}
				}
				txtBiomeMonsters.text = enemyNames;
			}
			
			prgLoader.setProgress(100, 100);
		}
		private function locationChange(e:Event):void
		{
			txtLongVal.text = device.CurrentLongitude.toString();
			txtLatVal.text  = device.CurrentLatitude.toString();
			txtSpeedVal.text= device.CurrentSpeed.toString();
		}
		
		public override function bringIn()
		{
			super.bringIn();
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
		}
		
		private function onExit(e:MouseEvent)
		{
			//clear off the stage
			if (this.stage.numChildren >= 2)
			this.stage.removeChildren(1, this.stage.numChildren -1);
			
			manage.displayScreen(MainScreen);
		}
		
		public override function cleanUp()
		{
			exit_btn.removeEventListener(MouseEvent.CLICK, onExit);
			super.cleanUp();
		}
	}
	
}
