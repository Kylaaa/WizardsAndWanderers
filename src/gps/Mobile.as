//AUTHOR- KYLER MULHERIN

package gps {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	
	// Android stuff
	import flash.desktop.NativeApplication;
	
	// Geolocation
	import flash.sensors.Geolocation;
	import flash.events.GeolocationEvent;
	import flash.events.StatusEvent;
	
	//web stuff
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.SecurityErrorEvent;
	
	//database stuff
	import gps.Database;
	import gps.Biome;
	import flash.data.SQLStatement;
	import flash.data.SQLResult;
	import flash.events.SQLEvent;
	
	
	
	public class Mobile extends MovieClip 
	{
		// Constant for geolocation
		private var pGeolocation:Geolocation;
		private static const LOCATION_UPDATE_INTERVAL:int = 60000; //in milliseconds = 1 second
		
		//web stuff
		private var loader:URLLoader;
		
		//database stuff
		private var db:Database;
		
		//biome and enemy stuff
		private var tempBiomeID:String;
		private var tempBiomeType:String;
		private var tempBiomeEnemies:String;
		private var numBiomeEnemies:int;
		private var searchedEnemies:int;
		private var biomeMonsters:Array;
		private var currentBiome:Biome;
		private var currentLatitude:Number;
		private var currentLongitude:Number;
		private var currentSpeed:Number;
		
		//other stuff
		private var isReady:Boolean;
		
		//debug stuff
		private var txtOut:TextField;
		private var enemyPictures:Array;
		
		
		public function Mobile(aDatabase:Database, outputTextField:TextField = null) 
		{
			// constructor code
			isReady = false;
			
			
			//deal with mobile aspects of the game
			addEventListener(Event.EXITING, closeAllConnections);
			
			//initialize the phone's geolocation stuff
			initGeolocation();
			
			//initialize the phone's database
			db = aDatabase;
			
			//set up the debug output class if it is present
			if (outputTextField != null) txtOut = outputTextField;
		}
		
		//ACCESSORS		
		public function get IsReady():Boolean 			{ return isReady; }
		public function get CurrentBiome():Biome 		{ return currentBiome; }
		public function get CurrentLatitude():Number 	{ return currentLatitude; }
		public function get CurrentLongitude():Number 	{ return currentLongitude; }
		public function get CurrentSpeed():Number 		{ return currentSpeed; }
		
		
		//GEO LOCATION
		private function initGeolocation():void
		{
			pGeolocation = new Geolocation();
			pGeolocation.addEventListener(GeolocationEvent.UPDATE, onGeoLocationUpdate, false, 0, true);
			pGeolocation.addEventListener(StatusEvent.STATUS, onGeoStatusChange, false, 0, true);
			
			//check online where we are by getting a debug location on RIT's campus
			var url:String = "http://itreallyiskyler.com/games/GPSRPG/database/getCurrentBiome.php?";
			url += "lat=" + 43.0838;
			url += "&long=" + -77.680;
			appendMessage(url);
			trace(url);
			
			var aRequest:URLRequest = new URLRequest(url)
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadComplete);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error);
			loader.load(aRequest);
			
			if (Geolocation.isSupported)
			{
				//displayMessage("Geolocation is supported");
				pGeolocation.setRequestedUpdateInterval(1); //get an immediate read out
				
				if (pGeolocation.muted)
				{
					writeMessage("Error: Geolocation is muted");
				}
			}
			else
			{
				trace("Geolocation is not supported on this device");
				writeMessage("Error: Geolocation is not supported on this device!");
			}
		}
		private function onGeoLocationUpdate(e:GeolocationEvent):void
		{
			var str:String = "(" + e.longitude + ", " + e.latitude + ")";
			writeMessage("new location = " + str);	
			
			//save our information to the device
			currentLongitude = e.longitude;
			currentLatitude = e.latitude;
			currentSpeed = e.speed;
			
			//update when the next time we should update
			var secondsToWait:Number = 60;
			pGeolocation.setRequestedUpdateInterval((secondsToWait / currentSpeed) * 1000); //interval is in milliseconds

			//check online where we are
			var url:String = "http://itreallyiskyler.com/games/GPSRPG/database/getCurrentBiome.php?";
			url += "lat=" + e.latitude.toString();
			url += "&long=" + e.longitude.toString();
			appendMessage(url);
			//trace(url);
			
			var aRequest:URLRequest = new URLRequest(url)
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadComplete);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, error);
			loader.load(aRequest);
			
			
			//throw an event to know something has changed
			dispatchEvent(new Event(Event.CHANGE));
		}
		private function onGeoStatusChange(e:StatusEvent):void 
		{
			if (e.code == "Geolocation.Muted")
			{
				//inform the user to turn on the location sensor
				appendMessage("Error: Turn on location sensing!");
				
			}
			
			appendMessage("Error Code: " + e.code);
		}
		
		
		
		//web query stuff		
		private function loadComplete(event:Event):void 
		{
			//grab the information
			writeMessage("Data grabbed from the internet: ");
			//trace(event.target.data.toString());
			appendMessage(event.target.data.toString());
			
			//parse the information we've recieved
			var rawBiomeData:String = event.target.data.toString();
			var biomeDataArray:Array = rawBiomeData.split(",");
			
			//check to make sure our data came back in the right format
			if (biomeDataArray.length > 2)
			{
				tempBiomeID = biomeDataArray[0];
				tempBiomeType = biomeDataArray[1];
				tempBiomeEnemies = "";
				numBiomeEnemies = biomeDataArray.length - 4;
				searchedEnemies = 0;
				biomeMonsters = new Array();
				
				writeMessage("Seaching the database for our enemies...");
				appendMessage("-num enemies to search for = " + numBiomeEnemies);
				for (var i:int = 2; i < biomeDataArray.length - 2; i++) 
				{ 
					tempBiomeEnemies += biomeDataArray[i] + ", "; 
					
					try
					{
						//grab data out of the database
						db.getDataRowWithCallBack(addMonstersToArray, "Enemy", "id", biomeDataArray[i]);
					}
					catch( err: Error)
					{
						writeMessage("empty cell error: " + err.getStackTrace());
					}
				}
			}
			
			//only start requesting once the first one is done
			pGeolocation.setRequestedUpdateInterval(LOCATION_UPDATE_INTERVAL);
			
			//clean up the loader variable
			loader.removeEventListener(Event.COMPLETE, loadComplete);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, error);
		}
		private function addMonstersToArray(e:SQLEvent):void //callback function for the database
		{
			
			searchedEnemies ++;
			appendMessage("-adding monster #" + searchedEnemies + " information to array");
						  
			var stat:SQLStatement = e.currentTarget as SQLStatement;
			stat.removeEventListener(SQLEvent.RESULT, addMonstersToArray);
			
			var result:SQLResult = stat.getResult();
			if (result == null || result.data == null) 
			{
				// check to make sure that data came in
				//trace("\t-Result was null or data was null (we deleted)");
				appendMessage("\t-Result was empty/null");
			}
			else
			{
				//trace("The Database result: " + result.data.toString());
				//parse out our enemy information
				var rows:int = result.data.length;
				for (var i:int = 0; i < rows; i++) 
				{
					if(result.data[i] != null)
					{
						var row:Object = result.data[i];
						biomeMonsters.push(row); //add it to our biome array
						
						//trace("-row[" + i + "] = " + row);
						//appendMessage("\t-row[" + i + "] = " + row);
						//appendMessage("\t-Enemy Name: " + row["id"]);
						for (var internalValue:Object in row)
						{
							//appendMessage("\t-" + internalValue + ": " + row[internalValue]);				
							//*******
							//parse an enemy's information out here
							//********
						}
					}
					
				}
			}
			
			appendMessage("# enemies to look up = " + numBiomeEnemies.toString() + ". # enemies currently looked up = " + searchedEnemies.toString());
			
			if (searchedEnemies == numBiomeEnemies)
			{
				writeMessage("\nBiome is ready to be created...");
				//we now have an array with all the database information
				//time to create the biome
				createBiome();
			}
			

		}
		private function createBiome():void
		{
			isReady = true;
			currentBiome = new Biome(tempBiomeID, tempBiomeType, biomeMonsters);
			
			//fire off an event to let all our connections know we completely loaded
			dispatchEvent(new Event(Event.COMPLETE));
			appendMessage("biome complete");
		}
		
		
		private function error(event:SecurityErrorEvent):void {
			//trace("Security Error: ");
			//trace(event.text);
			appendMessage("Security Error: ");
			appendMessage(event.text);
			
			//clean up the loader variable
			loader.removeEventListener(Event.COMPLETE, loadComplete);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, error);
		}
		
		
		
		//ANDROID helper functions
		private function closeAllConnections(e:Event):void
		{
			trace("closing");
			
			pGeolocation.removeEventListener(GeolocationEvent.UPDATE, onGeoLocationUpdate);
			pGeolocation.removeEventListener(StatusEvent.STATUS, onGeoStatusChange);
			
			pGeolocation = null;
			loader = null;
			
			NativeApplication.nativeApplication.exit();
		}
		
		
		
		//odd functions
		public function writeMessage(aMessage:String):void
		{
			//writes out a message to the SQL results window
			if (txtOut != null) txtOut.text = aMessage + "\n";
		}
		public function appendMessage(aMessage:String):void
		{
			//writes out a message to the SQL results window
			if (txtOut != null) txtOut.appendText(aMessage + "\n");
		}
		public function clearMessage():void
		{
			//clears out the SQL results window
			if (txtOut != null) txtOut.text = "";
		}
		
	}
	
}
