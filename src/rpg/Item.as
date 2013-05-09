//Alex Goldberger
package rpg  {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import ManagerAlpha;
	import screen.InventoryScreen;
	
	public class Item extends Sprite {
		
		public var manager:ManagerAlpha;
		public var idNumber:int;
		public var equipment:Boolean;
		public var ilevel:int;
		public var itemName:String;
		public var weapon:Boolean;
		
		//paramterized constructor
		public function Item(man:ManagerAlpha, id:int, equip:Boolean, lvl:int, iName:String, weap:Boolean)
		{
			manager = man;
			idNumber = id;
			equipment = equip;
			ilevel = lvl;
			itemName = iName;
			weapon = weap;
			this.x = 25;
			this.y = 25;
			//this.useHandCursor = true;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_DOWN, MouseClicked);
			//this.addEventListener(MouseEvent.MOUSE_UP, MouseReleased);
		}
		
		public function SummaryString():String
		{
			return "\nItem: " + itemName + "iLevel: " + ilevel;
		}
		
		public function MouseClicked(event:MouseEvent):void
		{
			if(weapon)
			{
				openInventory(true);
			}
			if(!weapon)
			{
				openInventory(false);
			}
		}
		
		public function openInventory(weapon:Boolean):void
		{
			if(weapon)
			{
				var wIScreen:InventoryScreen = new InventoryScreen(manager,"weapon");
				manager.addChild(wIScreen);
			}
			else
			{
				var aIScreen:InventoryScreen = new InventoryScreen(manager,"armor");
				manager.addChild(aIScreen);
			}
		}
		
		//This function takes an int representing the stat effected and returns the string associated with it
		public function checkArmorStatusEffect(statNumber:int):String
		{
			var toReturn:String = "";
			switch (statNumber)
			{
				case 0 ://status prevention
					toReturn = "Status Prevention";
					break;
				case 1 ://Crit Chance increase
					toReturn = "Crit Chance Increase";
					break;
				case 2 ://Health Increase
					toReturn = "Health Increase";
					break;
				case 3 ://Health Regen
					toReturn = "Health Regen";
					break;
				case 4 ://Speed Boost Chance
					toReturn = "Speed Boost Chance";
					break;
				case 5 ://Dodge Chance Increase
					toReturn = "Dodge Chance Increase";
					break;
				case 6 ://Plus Damage VS:
					toReturn = "Plus Damage Vs";
					break;
			}
			return toReturn;
		}
		
	}
	
}
