package code
{

	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.text.engine.Kerning;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.notifications.NotificationStyle;
	
	import ManagerAlpha;
	import screen.Screen;
	import screen.MainScreen;

	public class Manager extends Screen
	{
		public var manager:ManagerAlpha;
		
		public function Manager(newManager:ManagerAlpha)
		{
			super(newManager);
			manager = newManager;
			// constructor code
			
			//Set the default weapon
			var tempWeapon:Weapon = new Weapon(manager,1,true,2,"Wooden Staff",true,15,1.75,0);
			addChild(tempWeapon);
			tempWeapon.x = 205;
			tempWeapon.y = 95;
			
			//Set the default armor
			var tempStatArray:Array;
			var tempStatEffectArray:Array
			var tempArmor:Armor = new Armor(manager,0,true,1,"Basic Robes",false,0,tempStatArray,tempStatEffectArray);
			manager.player.equippedArmor = tempArmor;
			manager.equippedArmorId = tempArmor.idNumber; 
			addChild(tempArmor);
			tempArmor.x = 330;
			tempArmor.y = 95;
			

			btn_defaultItems.addEventListener(MouseEvent.CLICK, dItemButton);
			btn_Essences.addEventListener(MouseEvent.CLICK, essencesButton);
			btn_Stats.addEventListener(MouseEvent.CLICK, statsButton);
			
			btn_back.addEventListener(MouseEvent.CLICK, backToMenu);
		}
		
		function essencesButton(event:MouseEvent):void
		{
			var eScreen:EssencesScreen = new EssencesScreen(manager);
			manager.addChild(eScreen);
		}
		
		function backToMenu(event:MouseEvent):void
		{
			manage.displayScreen(MainScreen);
		}
		
		function statsButton(event:MouseEvent):void
		{
			var statsScreen:CharacterStatsScreen = new CharacterStatsScreen(manage);
			manage.addChild(statsScreen);
		}
		
		//makes some pre-set recipes and items for testing
		function dItemButton(event:MouseEvent):void
		{
			var tempWeapon2:Weapon = new Weapon(manager,2,true,3,"Magic Wand",true,20,12,3);
			manager.populateWeaponArray(tempWeapon2);

			var tempWeapon3:Weapon = new Weapon(manager,3,true,5,"Gold Wand",true,25,22,1);
			manager.populateWeaponArray(tempWeapon3);
			
			var tempStatArray:Array = new Array();
			var tempStatEffectArray:Array = new Array();
			
			tempStatArray.push(5);
			tempStatEffectArray.push(2.5);
			var tempArmor2:Armor = new Armor(manager,1,true,1,"Dune Cloak",false,2.5,tempStatArray,tempStatEffectArray);
			manager.populateArmorArray(tempArmor2);

			tempStatArray = new Array();
			tempStatEffectArray = new Array();
			tempStatArray.push(1);
			tempStatEffectArray.push(2.5);
			var tempArmor3:Armor = new Armor(manager,2,true,1,"Surge Robes",false,2.5,tempStatArray,tempStatEffectArray);
			manager.populateArmorArray(tempArmor3);

			//cost array
			var costArray:Array;
			costArray = new Array(4);
			//Forest-Wetlands-Mountain-Desert
			costArray[0] = [3,1,3,8];//lesser
			costArray[1] = [2,0,2,6];//average
			costArray[2] = [0,0,0,5];//greater
			costArray[3] = [0,0,0,1];//grand
			
			tempStatArray = new Array();
			tempStatEffectArray = new Array();
			var tempRecipe:Recipe = new Recipe(manager,4,true,9,"Armor of the North",false,5, tempStatArray, tempStatEffectArray, 0,0,0, costArray);
			manager.populateRecipeArray(tempRecipe);

			costArray = new Array(4);
			//Forest-Wetlands-Mountain-Desert
			costArray[0] = [0,0,1,7];//lesser
			costArray[1] = [1,1,1,4];//average
			costArray[2] = [0,0,1,1];//greater
			costArray[3] = [0,0,0,1];//grand
			var tempRecipe2:Recipe = new Recipe(manager,3,true,1,"Foe Shatterer",true,0,tempStatArray,tempStatEffectArray,7.5,150,0,costArray);
			manager.populateRecipeArray(tempRecipe2);

		}

		//Legacy
		/*
		//list the stats of the selected item
		public function itemSpecs(item:Item)
		{
			//txt_inventory.text = item.SummaryString();
		}*/		
		/*function create_Item():void
		{
		//set item
		//txt_itemName.text = txt_input_itemName.text;
		//txt_equipment.text = txt_input_equipment.text;
		//txt_level.text = txt_input_level.text;
		
		/*var tempEquipBool:Boolean = false;
		
		if(txt_input_equipment.text == "true")
		{
		tempEquipBool = true;
		}
		
		if(tempEquipBool == false)
		{
		var tempItem:Item = new Item(manager, tempEquipBool, int(txt_input_level.text), txt_input_itemName.text, false);
		populateArray(tempItem);
		trace("Make Item");
		addChild(tempItem);
		}*/
		/*if()
		{
		var tempWeaponBool:Boolean = false;
		if(txt_input_weapon.text == "true")
		{
		tempWeaponBool = true;
		var tempWeapon:Weapon = new Weapon(manager, true, int(txt_input_level.text), txt_input_itemName.text, tempWeaponBool, int(txt_input_cC.text), int(txt_input_cDB.text),int(txt_input_cE.text)); 
		populateArray(tempWeapon);
		trace("Make Weapon");
		addChild(tempWeapon);
		}
		else
		{
		var tempArmor:Armor = new Armor(manager, true, int(txt_input_level.text), txt_input_itemName.text, tempWeaponBool, txt_input_sE.text, int(txt_input_aE.text));
		populateArray(tempArmor);
		trace(txt_input_weapon.text);
		trace("Make Armor");
		addChild(tempArmor);
		}
		}
		
		*/
		/*var tempInventoryText:String = "";
		for(var i:int; i < inventoryArray.length; i++)
		{
		tempInventoryText += inventoryArray[i].SummaryString();
		trace(inventoryArray[i].SummaryString());
		}
		txt_inventory.text = tempInventoryText;*/
		/*
		}*/

	}

}