package gps 
{
	import gps.Mobile;
	import gps.Database;
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.*;
	
	//a wrapper class to test the Mobile Class
	public class mobileViewer extends MovieClip
	{
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
		
		public function mobileViewer() 
		{
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
			//trace("num Children before: " + this.stage.numChildren);
			
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
						device.CurrentBiome.drawEnemy(this.stage, i, 20 + (i * 75), 450);
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
			//trace("num Children after: " + this.stage.numChildren);
		}
		private function locationChange(e:Event):void
		{
			txtLongVal.text = device.CurrentLongitude.toString();
			txtLatVal.text  = device.CurrentLatitude.toString();
			txtSpeedVal.text= device.CurrentSpeed.toString();
		}

		
	}
	
}
