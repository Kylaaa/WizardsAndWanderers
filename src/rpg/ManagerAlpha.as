package rpg
{
	import code.*;
	
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
		private var playerXML:XML;
		
		public var armorArray:Array;
		public var weaponArray:Array;
		public var recipeArray:Array;
		
		public var equippedWeaponId:int;
		public var equippedArmorId:int;
		
		public var currentWeapon:Weapon;
		
		private var currentScreen:Screen;
		
		public var player:Player;
		
		//explore
		public var exploring:Exploring;
		
		public function ManagerAlpha()
		{
			super();
			
			player = new Player(this);
			exploring = new Exploring(this);
			
			displayScreen(TitleScreen);
			
			armorArray = new Array();
			weaponArray = new Array();
			recipeArray = new Array();
			
			startUp();
		}
		
		function startUp()
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
		}
		
		public function displayScreen(screenClass:Class)
		{
			if(currentScreen != null)
			{
				currentScreen.bringOut();
			}
			
			if(screenClass == Battle)
			{
				battle = new Battle(this);
				addChild(battle);
				battle.bringIn();
				battle.initialize();
			} else {
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
		
		
		public function openInventory(weapon:Boolean)
		{
			if(weapon)
			{
				var wIScreen:inventoryScreen = new inventoryScreen(this,"weapon");
				addChild(wIScreen);
			}
			else
			{
				var aIScreen:inventoryScreen = new inventoryScreen(this,"armor");
				addChild(aIScreen);
			}
		}
		
		public function populateArmorArray(armor:Armor)
		{
			//find the end of the armorArray
			var posToAddTo:int = armorArray.length;
			
			armorArray[posToAddTo] = armor;
		}
		
		public function populateWeaponArray(weapon:Weapon)
		{
			//find the end of the inventoryArray
			var posToAddTo:int = weaponArray.length;
			
			weaponArray[posToAddTo] = weapon;
		}
		
		public function populateRecipeArray(recipe:Recipe)
		{
			//find the end of the inventoryArray
			var posToAddTo:int = recipeArray.length;
			recipeArray[posToAddTo] = recipe;
		}	
		
	}
}