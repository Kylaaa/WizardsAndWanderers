package 
{
	import code.*;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.text.TextField;
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
		
		//explore
		public var exploring:Exploring;
		
		//device stuff
		public var database:Database;
		public var device:Mobile;
		private var txtErrorMessage:TextField;
		private var loadingMessage:MovieClip;
		
		//CONSTRUCTOR
		public function ManagerAlpha()
		{
			super();
			
			player = new Player(this);
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
		}
		
		private function dbLoaded(e:Event):void
		{
			//clean up the stage
			this.removeChild(txtErrorMessage);
			this.removeChild(loadingMessage);
			
			//initialize our mobile stuff
			device = new Mobile(database, txtErrorMessage);
			device.addEventListener(Event.CHANGE, locationChange);
			device.addEventListener(Event.COMPLETE, locationReady);
			
			startUp();
		}
		
		
		private function locationReady(e:Event):void
		{
			//clear off the stage
			//if (this.stage.numChildren >= 2)
			//this.stage.removeChildren(1, this.stage.numChildren -1);
			
			if (device.IsReady)
			{
				//txtBiomeIDVal.text = device.CurrentBiome.ID;
				//txtBiomeType.text = device.CurrentBiome.Type;
				
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
				//txtBiomeMonsters.text = enemyNames;
			}
			
			//prgLoader.setProgress(100, 100);
		}
		private function locationChange(e:Event):void
		{
			//txtLongVal.text = device.CurrentLongitude.toString();
			//txtLatVal.text  = device.CurrentLatitude.toString();
			//txtSpeedVal.text= device.CurrentSpeed.toString();
		}
		
		
		public function startUp():void
		{
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
			
			if(screenClass === Battle)
			{
				battle = new Battle(this);
				addChild(battle);
				battle.bringIn();
				battle.initialize();
			} 
			else 
			{
				currentScreen = new screenClass(this);
				addChild(currentScreen);
				currentScreen.bringIn();
			}
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