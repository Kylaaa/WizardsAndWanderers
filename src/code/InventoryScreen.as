//Alex Goldberger
package code {
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;	
	import flash.display3D.IndexBuffer3D;
	import flash.text.TextField;
	import managers.ShapesManager;
	import ManagerAlpha;
	import managers.ImageManager;
	
	public class InventoryScreen extends MovieClip {
		
		public var btn_back:SimpleButton;
		private var btn_left:SimpleButton;
		private var btn_right:SimpleButton;
		
		protected var manager:ManagerAlpha;
		private var currentIndex:int;
		private var tempArray:Array;
		private var weapon:Boolean;
		
		private var panel:Sprite = new Sprite();		
		
		/*private var btn_equip:SimpleButton;
		
		private var txt_inventory:TextField;
		private var txt_iSize:TextField;
		private var txt_index:TextField;*/
		
		public function InventoryScreen(man:ManagerAlpha, type:String) {
			// constructor code
			manager = man;
			
			/*btn_equip.addEventListener(MouseEvent.CLICK, equipButton);
			btn_Back_Item.addEventListener(MouseEvent.CLICK, bButton);
			btn_left.addEventListener(MouseEvent.CLICK, lButton);
			btn_right.addEventListener(MouseEvent.CLICK, rButton);*/
			
			if(type == "weapon")
			{
				tempArray = manager.weaponArray;
				weapon = true;
			}
			else
			{
				tempArray = manager.armorArray;
				weapon = false;
			}
			currentIndex = findEquippedId(); //Always open the equipped item			
			
			/*txt_inventory.text = tempArray[currentIndex].SummaryString();
			
			txt_iSize.text = "Inventory Size: " + tempArray.length.toString();
			txt_index.text = "Current Index: " + currentIndex.toString();*//////////////////////////////////////////////////////////////////////////
			
			//hide the buttons to cycle if they have only one item
			/*if(tempArray.length == 1)
			{
				btn_left.visible = false;
				btn_right.visible = false;
			}
			else
			{
				btn_left.visible = true;
				btn_right.visible = true;
			}*/
			
			checkEquipped();
			
			drawStuff();
			buttonSetUp();
		}
		
		private function drawStuff():void
		{
			graphics.beginFill(0x808080, .75);
			graphics.drawRect(0, 0, manager.stage.stageWidth, manager.stage.stageHeight);
			
			this.addChild(panel);
			panel.addChild(ImageManager.CharacterEssencePanel());
			panel.x = 20; //use relative to center and stuff
			panel.y = 20; //use relative to center and stuff
			panel.width *= 5;
			panel.height *= 5;
		}
		
		private function buttonSetUp():void
		{
			btn_back = ShapesManager.drawButton(0, -100, 200, 100, "Back", manager.device.CurrentBiome.Type, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
			this.addChild(btn_back);
			btn_back.addEventListener(MouseEvent.CLICK, onBack);
			
			btn_left = ShapesManager.drawButton(50, -200, 200, 100, "<---", manager.device.CurrentBiome.Type, ShapesManager.JUSTIFY_LEFT, ShapesManager.JUSTIFY_BOTTOM);
			this.addChild(btn_left);
			btn_left.addEventListener(MouseEvent.CLICK, onLeft); //switch to onLeft
			
			btn_right = ShapesManager.drawButton(-250, -200, 200, 100, "--->", manager.device.CurrentBiome.Type, ShapesManager.JUSTIFY_RIGHT, ShapesManager.JUSTIFY_BOTTOM);
			this.addChild(btn_right); 
			btn_right.addEventListener(MouseEvent.CLICK, onRight); //switch to onRight
		}
		
		private function onBack(e:MouseEvent):void
		{
			manager.removeChild(this);
		}

		private function onLeft(e:MouseEvent):void
		{
			tempFunction();
		}
		private function onRight(e:MouseEvent):void
		{
			tempFunction();
		}
		private function tempFunction():void
		{
			if (!weapon)
			{
			if (manager.equippedArmorId == 1)
			{
				manager.equippedArmorId == 2;
				//change armor
			}
			else
			{
				manager.equippedArmorId == 1;
				//change armor
			}
			//manager.equippedArmorId = tempArmor.idNumber;
			}
			else
			{
			if (manager.equippedWeaponId == 1)
			{
				manager.equippedWeaponId == 2;
				//change weapon
				//manager.weaponImage = ImageManager.
			}
			else
			{
				manager.equippedArmorId == 1;
				//change armor
			}
			//manager.equippedArmorId = tempArmor.idNumber;
			}
		}
		
		/*
		private function rButton(event:MouseEvent):void
		{
			if(tempArray.length > currentIndex + 1)
			{
				currentIndex++;
			}
			else
			{
				currentIndex = 0;
			}
			txt_inventory.text = tempArray[currentIndex].SummaryString();
			txt_index.text = "Current Index: " + currentIndex.toString();
			
			checkEquipped();
		}
		
		private function lButton(event:MouseEvent):void{
			if(currentIndex > 0)
			{
				currentIndex--;
			}
			else
			{
				currentIndex = tempArray.length - 1;
			}
			txt_inventory.text = tempArray[currentIndex].SummaryString();
			txt_index.text = "Current Index: " + currentIndex.toString();
			
			checkEquipped();
		}
		
		//Pressing this button will equip the new item
		private function equipButton(event:MouseEvent):void
		{
			if(weapon)
			{
				manager.equippedWeaponId = tempArray[currentIndex].idNumber;
				manager.currentWeapon = tempArray[currentIndex];
			}
			if(!weapon)
			{
				manager.player.equippedArmor.onUnequip(); //unequips the armor
				tempArray[currentIndex].onEquip(); //adds the stats of the equipped armor to character
				manager.player.equippedArmor = tempArray[currentIndex];
				manager.equippedArmorId = tempArray[currentIndex].idNumber;
			}
			btn_equip.visible = false;
			manager.CreateNotification("Item equipped.")
		}
		*/
		//this function checks to see if the current item is the equipped item
		//if it is, then it hides the button, otherwise it shows it
		private function checkEquipped():void
		{
			/*if(weapon)
			{
				if(tempArray[currentIndex].idNumber == manager.equippedWeaponId)
				{
					btn_equip.visible = false;
				}
				else
				{
					btn_equip.visible = true;
				}
			}
			else
			{
				if(tempArray[currentIndex].idNumber == manager.equippedArmorId)
				{
					btn_equip.visible = false;
				}
				else
				{
					btn_equip.visible = true;
				}
			}*/
			
		}
		//this function returns the id of the equipped item
		private function findEquippedId():int
		{
			var toReturn:int;
			toReturn = 0;
			if(weapon)
			{
				for (var i:int = 0; i < tempArray.length; i++)
				{
					if(tempArray[i].idNumber == manager.equippedWeaponId)
					{
						toReturn = i;
					}
				}
			}
			else
			{
				for (var j:int = 0; j < tempArray.length; j++)
				{
					if(tempArray[j].idNumber == manager.equippedArmorId)
					{
						toReturn = j;
					}
				}
			}
			return toReturn;
		}
	}
	
}
