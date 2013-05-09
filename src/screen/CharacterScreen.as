package screen
{

	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.text.engine.Kerning;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import managers.ShapesManager;
	import flash.display.Sprite;
	import managers.ImageManager;
	//import flash.notifications.NotificationStyle;
	
	import ManagerAlpha;
	import screen.Screen;
	import screen.MainScreen;

	public class CharacterScreen extends Screen
	{
		public var manager:ManagerAlpha;
		
		//private var btn_defaultItems:SimpleButton;
		//private var btn_Essences:SimpleButton;
		//private var btn_Stats:SimpleButton;
		//private var btn_back:SimpleButton;
		
		public var exit_btn:SimpleButton;
		private var btn_inventoryWeapon:SimpleButton;
		private var btn_inventoryGarb:SimpleButton;
		
		public var backgroundLayer:Sprite = new Sprite();	// background images
		
		public var characterBody:Sprite = new Sprite();
		public var characterBodyImage:Bitmap = new Bitmap();
		//public var characterArmor:Sprite = new Sprite();
		//public var ArmorImage:Bitmap = new Bitmap();
		public var characterWeapon:Sprite = new Sprite();
		public var characterWeaponImage:Bitmap = new Bitmap();
		public var characterOther:Sprite = new Sprite();
		public var characterOtherImage:Bitmap = new Bitmap();
		
		public var armor:Sprite = new Sprite();
		public var ArmorImage:Bitmap = new Bitmap();
		public var weapon:Sprite = new Sprite();
		public var other:Sprite = new Sprite();
		public var otherImage:Bitmap = new Bitmap();
		
		private var smallPanel:Sprite = new Sprite(); //use for the width and height
		private var cePanel:Sprite = new Sprite();
		private var cpPanel:Sprite = new Sprite();
		private var csPanel_weapon:SimpleButton= new SimpleButton();
		private var csPanel_garb:Sprite = new Sprite();
		private var csPanel_other:Sprite = new Sprite();
		
		private var characterPanelPosition:int = 100;
		private var characterOffset:int = 53;
		
		private var characterName:String = "";
		private var characterNameText:TextField = new TextField();
		
		private var characterClass:String = "";
		private var characterClassText:TextField = new TextField();
		
		private var wizard:Boolean;
		
		public function CharacterScreen(newManager:ManagerAlpha)
		{
			super(newManager);
			manager = newManager;
			
			if (manager.player.level == 1)
			{
				characterClass = "Wizard";
				characterName = "Shane";
				wizard = true;
			}
			else
			{
				characterClass = "Druid";
				characterName = "Issac";
				wizard = false;
			}
			
			// constructor code
			addChild(backgroundLayer);
			backgroundLayer.addChild(manage.biomeBackground);
			
			exit_btn = ShapesManager.drawButton(0, -100, 200, 100, "Back", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
			var scale:int = .75;
			//var scale = .5;
			//btn_inventoryWeapon = ShapesManager.drawButtonFromImage(225, -150, 200 * scale, 100 * scale, "Weapons", "characterSmallPanel.png", ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
			//btn_inventoryGarb = ShapesManager.drawButton(350, -150, 200 * scale, 100 * scale, "Garbs", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
			
			//Set the default weapon
			//var tempWeapon:Weapon = new Weapon(manager,1,true,2,"Wooden Staff",true,15,1.75,0);
			//addChild(tempWeapon);
			//tempWeapon.x = 205;
			//tempWeapon.y = 95;
			
			//Set the default armor
			/*var tempStatArray:Array;
			var tempStatEffectArray:Array
			var tempArmor:Armor = new Armor(manager,0,true,1,"Basic Robes",false,0,tempStatArray,tempStatEffectArray);
			manager.player.equippedArmor = tempArmor;
			manager.equippedArmorId = tempArmor.idNumber;*/
			//addChild(tempArmor);
			//tempArmor.x = 330;
			//tempArmor.y = 95;
			
			manager.equippedWeaponId = 1;
			manager.equippedArmorId = 1;
			
			//btn_defaultItems.addEventListener(MouseEvent.CLICK, dItemButton);
			//btn_Essences.addEventListener(MouseEvent.CLICK, essencesButton);
			//btn_Stats.addEventListener(MouseEvent.CLICK, statsButton);
			
			//btn_back.addEventListener(MouseEvent.CLICK, backToMenu);
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			bringIn_Panels();
			
			this.addChild(exit_btn);
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
			
			if (characterClass == "Wizard")
			{
				//csPanel_weapon.addEventListener(MouseEvent.CLICK, onWeapon); //uncomment to turn on the start of inventory
			}
			
			//this.addChild(btn_inventoryGarb);
			
			bringIn_Character();
			
		}
		
		private function onExit(e:MouseEvent):void
		{
			manage.displayScreen(MainScreen);
		}
		
		private function onWeapon(e:MouseEvent):void
		{
			var weaponInventory:InventoryScreen = new InventoryScreen(manager, "weapon"); 
			manage.addChild(weaponInventory);
		}
		
		public override function cleanUp():void
		{
			exit_btn.removeEventListener(MouseEvent.CLICK, onExit);
			super.cleanUp();
		}
		
		private function bringIn_Character():void
		{
			var scale:int = 3;
			var x:int = 20;
			
			this.addChild(characterBody);
			if (wizard)
			{
				characterBodyImage = ImageManager.WizardBody1();
			}
			else
			{
				characterBodyImage = ImageManager.DruidBody1();
			}
			characterBody.addChild(characterBodyImage);
			characterBodyImage.x = x;
			characterBodyImage.y = characterPanelPosition + characterOffset;
			characterBodyImage.width *= scale;
			characterBodyImage.height *= scale;
			
			this.addChild(characterWeapon);
			if (wizard)
			{
				characterWeaponImage = ImageManager.WizardStaff();
			}
			else
			{
				characterWeaponImage = ImageManager.DruidStaff1();
			}
			characterWeapon.addChild(characterWeaponImage);
			characterWeaponImage.x = x;
			characterWeaponImage.y = characterPanelPosition + characterOffset;
			characterWeaponImage.width *= scale;
			characterWeaponImage.height *= scale;
			
			this.addChild(characterOther);
			if (wizard)
			{
				characterOtherImage = ImageManager.PurpleOrb();
			}
			else
			{
				characterOtherImage = ImageManager.Raven();
			}
			characterOther.addChild(characterOtherImage);
			characterOtherImage.x = x;
			characterOtherImage.y = characterPanelPosition + characterOffset;
			characterOtherImage.width *= scale;
			characterOtherImage.height *= scale;
			
			//ShapesManager.drawText(characterName, x, 200,100, 100);
			characterNameText = ShapesManager.drawText(characterName, x + 5, 100, 200, 100, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_TOP,false, false);
			this.addChild(characterNameText);
			
			characterClassText = ShapesManager.drawText("the " + characterClass, x + 15, 125, 200, 100, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_TOP, false, false);
			this.addChild(characterClassText);
			
			
		}
		
		private function bringIn_Panels():void
		{
			var panelScale:int = 2.5;
			var equipmentScale:int = 1.75;
			
			this.addChild(cePanel);
			/*cePanel.addChild(ImageManager.CharacterEssencePanel());
			cePanel.x = 225; //use relative to center and stuff
			cePanel.y = characterPanelPosition; //use relative to center and stuff
			cePanel.width *= 2.75;
			cePanel.height *= 2.5;*/
			
			cePanel.addChild(ImageManager.EssenceDemoPanel());
			cePanel.x = 225; //use relative to center and stuff
			cePanel.y = characterPanelPosition; //use relative to center and stuff
			cePanel.width *= 1.35;
			//cePanel.height *= 2.5;
			
			this.addChild(cpPanel);
			cpPanel.addChild(ImageManager.CharacterPlayerPanel());
			cpPanel.x = 20; //use relative to center and stuff
			cpPanel.y = characterPanelPosition; //use relative to center and stuff
			cpPanel.width *= 2.5;
			cpPanel.height *= 2.5;
			
			var smallPanelY:int = 225;
			//this.addChild(csPanel_weapon);
			//csPanel_weapon.addChild(ImageManager.CharacterSmallPanel());
			//csPanel_weapon.x = 225; //use relative to center and stuff
			//csPanel_weapon.y = smallPanelY; //use relative to center and stuff
			//csPanel_weapon.width *= 2.5;
			//csPanel_weapon.height *= 2.5;
			
			this.addChild(smallPanel);
			smallPanel.addChild(ImageManager.CharacterSmallPanel());
			//smallPanel.x = 225; //use relative to center and stuff
			//smallPanel.y = smallPanelY; //use relative to center and stuff
			smallPanel.visible = false; //we don't need to see it, only to access it's width and height
			smallPanel.width *= 2.5;
			smallPanel.height *= 2.5;
			
			csPanel_weapon = ShapesManager.drawButtonFromImage(225, smallPanelY, smallPanel.width, smallPanel.height, "Weapons", "characterSmallPanel.png");
			//csPanel_weapon = ShapesManager.drawButton(225, -150, 200 * scale, 100 * scale, "Weapons", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
			this.addChild(csPanel_weapon);
			
			this.addChild(weapon);
			if (wizard)
			{
				manager.weaponImage = ImageManager.WizardStaff();
			}
			else
			{
				manager.weaponImage = ImageManager.DruidStaff1();
			}
			weapon.addChild(manager.weaponImage);
			weapon.x = 200; //use relative to center and stuff
			weapon.y = 220; //use relative to center and stuff
			weapon.width *= 1.75;
			weapon.height *= 1.75;
			weapon.mouseEnabled = false;
			
			this.addChild(csPanel_garb);
			csPanel_garb.addChild(ImageManager.CharacterSmallPanel());
			csPanel_garb.x = 350; //use relative to center and stuff
			csPanel_garb.y = smallPanelY; //use relative to center and stuff
			csPanel_garb.width *= 2.5;
			csPanel_garb.height *= 2.5;
			
			this.addChild(armor);
			if (wizard)
			{
				ArmorImage = ImageManager.WizardGarb1();
			}
			else
			{
				ArmorImage = ImageManager.DruidGarb1();
			}
			armor.addChild(ArmorImage);
			armor.x = 355; //use relative to center and stuff
			armor.y = 235; //use relative to center and stuff
			armor.width *= 1.75;
			armor.height *= 1.75;
			
			this.addChild(csPanel_other);
			csPanel_other.addChild(ImageManager.CharacterSmallPanel());
			csPanel_other.x = 475; //use relative to center and stuff
			csPanel_other.y = smallPanelY; //use relative to center and stuff
			csPanel_other.width *= 2.5;
			csPanel_other.height *= 2.5;
			
			this.addChild(other);
			
			if (wizard)
			{
				otherImage = ImageManager.PurpleOrb();
			}
			else
			{
				otherImage = ImageManager.Raven();
			}
			other.addChild(otherImage);
			other.x = 500; //use relative to center and stuff
			other.y = 235; //use relative to center and stuff
			other.width *= 1.75;
			other.height *= 1.75;
		}
		
		//buttons should be on screens now for example Character
		/*private function essencesButton(event:MouseEvent):void
		{
			var eScreen:EssencesScreen = new EssencesScreen(manager);
			manager.addChild(eScreen);
		}
		
		private function backToMenu(event:MouseEvent):void
		{
			manage.displayScreen(MainScreen);
		}
		
		private function statsButton(event:MouseEvent):void
		{
			var statsScreen:CharacterStatsScreen = new CharacterStatsScreen(manage);
			manage.addChild(statsScreen);
		}*/
		
		//makes some pre-set recipes and items for testing
		/*private function dItemButton(event:MouseEvent):void
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

		}*/

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