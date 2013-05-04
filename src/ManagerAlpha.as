package 
{
	import code.*;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.text.TextField;
	import flash.utils.Timer;
	import gps.Database;
	import gps.Mobile;
	import managers.ImageManager;
	import managers.ShapesManager;
	import rpg.Battle;
	import rpg.Player;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import screen.MainScreen;
	import screen.Screen;
	import screen.TitleScreen;
	
	public class ManagerAlpha extends Sprite
	{
		private var battle:Battle;
		
		private var currentScreen:Screen;
		
		public var player:Player;
		private var playerXML:XML;
		public var currentWeapon:Weapon;
		public var equippedWeaponId:int;
		public var equippedArmorId:int;
		public var armorArray:Array;
		public var weaponArray:Array;
		public var recipeArray:Array;
		
		//background
		public var biomeBackground:Bitmap;
		
		//explore
		public var exploring:Exploring;
		
		//device stuff
		public var database:Database;
		public var device:Mobile;
		private var txtErrorMessage:TextField;
		private var loadingMessage:MovieClip;
		
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
		public function ManagerAlpha()
		{
			super();
			
			exploring = new Exploring(this);
			armorArray = new Array();
			weaponArray = new Array();
			recipeArray = new Array();
			
			
			//consider drawing a loading screen for now
			loadingMessage = ShapesManager.drawLabel("Loading...", -100, -100, 200, 200, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			this.addChild(loadingMessage);
			txtErrorMessage = new TextField();
			txtErrorMessage.width = 500;
			txtErrorMessage.height = 500;
			this.addChild(txtErrorMessage);
			
			//initialize the database first
			database = new Database(txtErrorMessage);
			database.addEventListener(Event.COMPLETE, dbLoaded)
			
			createPlayer();
			
			// spell stuff
			threeHourSpellOne.addEventListener(TimerEvent.TIMER_COMPLETE, activateOne);
			threeHourSpellTwo.addEventListener(TimerEvent.TIMER_COMPLETE, activateTwo);
			threeHourSpellThree.addEventListener(TimerEvent.TIMER_COMPLETE, activateThree);
			
			dailySpell.addEventListener(TimerEvent.TIMER_COMPLETE, activateDaily);
		}
		
		// spell stuff
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
		
		public function createPlayer():void
		{
			player = new Player(this, 1);
		}
		
		private function dbLoaded(e:Event):void
		{
			trace("database completely loaded");
			//clean up the stage
			this.removeChild(txtErrorMessage);
			this.removeChild(loadingMessage);
			
			//initialize our mobile stuff
			device = new Mobile(database, txtErrorMessage);
			device.addEventListener(Event.CHANGE, locationChange);
			device.addEventListener(Event.COMPLETE, locationReady);
			
			device.addEventListener(Event.COMPLETE, startUp);
		}
		
		
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
		
		
		public function startUp(e:Event):void
		{
			//remove the event listener from the device and start the game
			device.removeEventListener(Event.COMPLETE, startUp);
			
			//Set the default weapon (later get the weapon/armor from the Player XML)
			var tempWeapon:Weapon = new Weapon(this,0,true,1,"Wooden Staff",true,15,1.75,6);
			populateWeaponArray(tempWeapon);
			equippedWeaponId = tempWeapon.idNumber; //equip the default weapon
			currentWeapon = tempWeapon;
			
			//Set the default armor
			//var tempStatArray:Array;
			//var tempStatEffectArray:Array
			//var tempArmor:Armor = new Armor(this,0,true,1,"Basic Robes",false,0,tempStatArray,tempStatEffectArray);
			//populateArmorArray(tempArmor);
			//equippedArmorId = tempArmor.idNumber; //equip the default armor
			//tempArmor.onEquip(); //changes stats based on the equipped armor
			
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
		public function CreateNotification(notification:String):void
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
		
	}
}