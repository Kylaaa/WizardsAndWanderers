package 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import gps.Database;
	import gps.Mobile;
	import managers.ImageManager;
	import managers.ShapesManager;
	import rpg.Armor;
	import rpg.Battle;
	import rpg.Exploring;
	import rpg.Player;
	import rpg.Recipe;
	import rpg.Weapon;
	import screen.InventoryScreen;
	import screen.NotificationWindow;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import screen.MainScreen;
	import screen.Screen;
	import screen.TitleScreen;
	
	public class Game extends Sprite
	{
		//EMBEDDED FILES
		[Embed(source = "xml/PlayerData.xml", 	mimeType = "application/octet-stream")] 	private static var xmlPlayerData:Class; 
		public static function get XMLplayerData():XML 	{ 	var byteArray:ByteArray = new xmlPlayerData() as ByteArray; return new XML(byteArray.readUTFBytes(byteArray.length)); }
		
		//CONSTANTS
		
		
		//********************** GLOBAL VARIABLES ********************
		//SCREEN VARIABLES
		private var currentScreen:Screen;
		private var battle:Battle;
		public var exploring:Exploring;
		
		//PLAYER VARIABLES
		public var player:Player;		//the current selected player
		public var allPlayers:Array;   	//loaded and parsed from xml
		public var playerName:String;
		public var playerID:int;
		public var collectedGold:int;
		public var homeBiomeID:int; 
		
		//EQUIPMENT VARIABLES
		public var armorArray:Array;
		public var weaponArray:Array;
		public var recipeArray:Array;
		
		//DEVICE & GPS VARIABLES
		public var database:Database;
		public var device:Mobile;
		public var biomeBackground:Bitmap;
		
		// spell stuff
		public var threeHourSpellOne:Timer = new Timer(1000, 60);
		public var threeHourSpellTwo:Timer = new Timer(1000, 60);
		public var threeHourSpellThree:Timer = new Timer(1000, 60);
		public var dailySpell:Timer = new Timer(1000, 300);
		public var spellOne:Boolean = true;
		public var spellTwo:Boolean = true;
		public var spellThree:Boolean = true;
		public var spellDaily:Boolean = true;
		
		//CONSTRUCTOR
		public function Game()
		{			
			exploring = new Exploring(this);
			allPlayers = new Array();
			armorArray = new Array();
			weaponArray = new Array();
			recipeArray = new Array();
			
			//initialize the spell stuff
			threeHourSpellOne.addEventListener(TimerEvent.TIMER_COMPLETE, activateOne);
			threeHourSpellTwo.addEventListener(TimerEvent.TIMER_COMPLETE, activateTwo);
			threeHourSpellThree.addEventListener(TimerEvent.TIMER_COMPLETE, activateThree);
			dailySpell.addEventListener(TimerEvent.TIMER_COMPLETE, activateDaily);
			
			//initialize all the player's characters
			initPlayerData();
			
			//initialize the database
			//once the database and mobile device is initialize, the game will start 
			database = new Database();
			database.addEventListener(Event.COMPLETE, dbLoaded);
			
			//consider drawing a loading screen for now
			addEventListener(Event.ADDED_TO_STAGE, addTitleScreen);
		}
		
		//INITIALIZATION FUNCTIONS
		public function initPlayerData():void
		{
			//grab the xml so we don't have to keep using the Getter function
			var playerXML:XML = XMLplayerData;
			
			//parse out the the player data
			playerID = playerXML.player.id[0];
			playerName = playerXML.player.name[0];
			homeBiomeID = playerXML.player.homeBiome[0];
			collectedGold = playerXML.player.gold[0];
			
			//parse all the characters
			for (var i:int = 0; i < playerXML.character.length(); i++)
			{
				var aCharacter:XML = playerXML.character[i];
				allPlayers.push(new Player(this, aCharacter));
			}
			
			//wait for the character select screen to assign the player
			//but for now, assign the first character, just to be safe
			player = allPlayers[0];
		}
		private function dbLoaded(e:Event):void
		{
			trace("database completely loaded");
			
			//initialize our mobile stuff
			device = new Mobile(database);
			device.addEventListener(Event.CHANGE, locationChange);
			device.addEventListener(Event.COMPLETE, locationReady);
			device.addEventListener(Event.COMPLETE, startUp);
		}
		public function startUp(e:Event):void
		{
			//remove the event listener from the device and start the game
			device.removeEventListener(Event.COMPLETE, startUp);
			
			//reveal the play button on the title screen
			if (! currentScreen is TitleScreen) 
			{
				displayScreen(TitleScreen); //contingency plan
				try { startUp(e); }
				catch (e:Error) { return; }
				return;
			}
			
			(currentScreen as TitleScreen).addPlayButton();
		}
		public function populateArmorArray(armor:Armor):void
		{
			//find the end of the armorArray
			var posToAddTo:int = armorArray.length;
			
			armorArray[posToAddTo] = armor;
		}
		public function populateWeaponArray(weapon:Weapon):void
		{
			//find the end of the inventoryArray
			var posToAddTo:int = weaponArray.length;
			
			weaponArray[posToAddTo] = weapon;
		}
		public function populateRecipeArray(recipe:Recipe):void
		{
			//find the end of the inventoryArray
			var posToAddTo:int = recipeArray.length;
			recipeArray[posToAddTo] = recipe;
		}	
		
		
		//SAVE FUNCTIONS
		public function saveProgress():void
		{
			player.lastTimePlayed = Main.getCurrentTimeValue();
			
			//write to the playerData.xml file
			var playerXML:String = "<game>";
				playerXML += "<player>";
				playerXML += "<id>" + -1 + "</id>";
				playerXML += "<name>" + playerName + "</name>";
				playerXML += "<gold>" + collectedGold + "</gold>";
				playerXML += "<homeBiome>" + homeBiomeID + "</homeBiome>";
				playerXML += "</player>";
			for (var i:int = 0; i < allPlayers.length; i++)
				playerXML += allPlayers[i].toXML();
				playerXML += "</game>";
				
			//TO DO: WRITE OUT THIS TEXT TO PlayerData.xml
		}
		
		//MOBILE & LOCATION FUNCTIONS
		private function locationReady(e:Event):void
		{
			//clear off the stage
			//if (this.stage.numChildren >= 2)
			//this.stage.removeChildren(1, this.stage.numChildren -1);
			trace("location ready event");
			if (device.IsReady)
			{
				//txtBiomeIDVal.text = device.CurrentBiome.ID;
				//txtBiomeType.text = device.CurrentBiome.Type;
				trace("Current Biome is: " + device.CurrentBiome.Type);
				
				//build our string of enemies
				var enemyNames:String = "";
				for (var i:int = 0; i < device.CurrentBiome.Enemies.length; i++)
				{
					enemyNames += device.CurrentBiome.Enemies[i]["name"].toString() + ", ";
					
					
					//draw it to the screen too
					/*try
					{
						device.CurrentBiome.drawEnemy(this.stage, i, 15 + (i * 70), 5);
					}
					catch (err:Error)
					{
						txtErrorMessage.text = "Error Loading " + device.CurrentBiome.Enemies[i]["name"].toString() + "\'s image.\n";
						txtErrorMessage.appendText(err.getStackTrace());		
					}*/
				}
				//txtBiomeMonsters.text = enemyNames;
			}
			trace("Enemy names = " + enemyNames);
			//prgLoader.setProgress(100, 100);
		}
		private function locationChange(e:Event):void
		{
			//txtLongVal.text = device.CurrentLongitude.toString();
			//txtLatVal.text  = device.CurrentLatitude.toString();
			//txtSpeedVal.text= device.CurrentSpeed.toString();
			
			trace("Location changed: (" + device.CurrentLatitude + ", " + device.CurrentLongitude + ")");
		}
		
		
		
		//SPELL FUNCTIONS
		//I'M NOT SURE BUT I FEEL LIKE THESE SHOULD BE ATTACHED TO A PLAYER_DATA OBJECT.
		public function activateOne(e:TimerEvent):void 
		{	
			spellOne = true;
			threeHourSpellOne.reset();
		}
		public function activateTwo(e:TimerEvent):void 
		{
			spellTwo = true;
			threeHourSpellTwo.reset();
		}
		public function activateThree(e:TimerEvent):void 
		{	
			spellThree = true;
			threeHourSpellThree.reset();
		}
		public function activateDaily(e:TimerEvent):void 
		{	
			spellDaily = true;
			dailySpell.reset();
		}
		
		
		//NOTIFICATION & SCREEN FUNCTIONS
		public function addTitleScreen(e:Event):void
		{
			//the stage has been properly initialized, display the title screen
			removeEventListener(Event.ADDED_TO_STAGE, addTitleScreen);
			
			displayScreen(TitleScreen);
		}
		public function displayScreen(screenClass:Class):void
		{
			trace("displaying screen: " + screenClass);
			if(currentScreen != null)
			{
				currentScreen.bringOut();
			}
			
		
			currentScreen = new screenClass(this);
			currentScreen.alpha = 0.0;
			addChild(currentScreen);
			currentScreen.bringIn();
			
			
		}
		public function createNotification(notification:String):void
		{
			var nW:NotificationWindow = new NotificationWindow(this,notification);
			addChild(nW);
		}
		public function openInventory(weapon:Boolean):void
		{
			if(weapon)
			{
				var wIScreen:InventoryScreen = new InventoryScreen(this,"weapon");
				addChild(wIScreen);
			}
			else
			{
				var aIScreen:InventoryScreen = new InventoryScreen(this,"armor");
				addChild(aIScreen);
			}
		}
		
		
	}
}