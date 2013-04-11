//Alex Goldberger
package code
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ManagerAlpha;
	
	public class RecipeScreen extends MovieClip
	{
		
		protected var manager:ManagerAlpha;
		
		private var currentIndex:int;
		private var tempRecipeArray:Array;
		private var textBoxArray:Array;
		
		public function RecipeScreen(man:ManagerAlpha)
		{
			// constructor code
			manager = man;
			btn_Back.addEventListener(MouseEvent.CLICK, bButton);
			btn_left.addEventListener(MouseEvent.CLICK, lButton);
			btn_right.addEventListener(MouseEvent.CLICK, rButton);
			btn_create.addEventListener(MouseEvent.CLICK, createButton);
			
			/*txt_e_F1.text = manager.player.esscencesBiomeArray[0][0].toString();
			txt_e_F2.text = manager.player.esscencesBiomeArray[1][0].toString();
			txt_e_F3.text = manager.player.esscencesBiomeArray[2][0].toString();
			txt_e_F4.text = manager.player.esscencesBiomeArray[3][0].toString();
			
			txt_e_W1.text = manager.player.esscencesBiomeArray[0][1].toString();
			txt_e_W2.text = manager.player.esscencesBiomeArray[1][1].toString();
			txt_e_W3.text = manager.player.esscencesBiomeArray[2][1].toString();
			txt_e_W4.text = manager.player.esscencesBiomeArray[3][1].toString();
			
			txt_e_M1.text = manager.player.esscencesBiomeArray[0][2].toString();
			txt_e_M2.text = manager.player.esscencesBiomeArray[1][2].toString();
			txt_e_M3.text = manager.player.esscencesBiomeArray[2][2].toString();
			txt_e_M4.text = manager.player.esscencesBiomeArray[3][2].toString();
			
			txt_e_D1.text = manager.player.esscencesBiomeArray[0][3].toString();
			txt_e_D2.text = manager.player.esscencesBiomeArray[1][3].toString();
			txt_e_D3.text = manager.player.esscencesBiomeArray[2][3].toString();
			txt_e_D4.text = manager.player.esscencesBiomeArray[3][3].toString();*/
			
			textBoxArray = new Array();
			textBoxArray[0] = (txt_e_F1);
			textBoxArray[1] = (txt_e_F2);
			textBoxArray[2] = (txt_e_F3);
			textBoxArray[3] = (txt_e_F4);
			
			textBoxArray[4] = (txt_e_W1);
			textBoxArray[5] = (txt_e_W2);
			textBoxArray[6] = (txt_e_W3);
			textBoxArray[7] = (txt_e_W4);
			
			textBoxArray[8] = (txt_e_M1);
			textBoxArray[9] = (txt_e_M2);
			textBoxArray[10] = (txt_e_M3);
			textBoxArray[11] = (txt_e_M4);
			
			textBoxArray[12] = (txt_e_D1);
			textBoxArray[13] = (txt_e_D2);
			textBoxArray[14] = (txt_e_D3);
			textBoxArray[15] = (txt_e_D4);
			
			
			//This code fills in the text boxes with the essences that the player has
			FillTextBoxes();
			
			
			tempRecipeArray = manager.recipeArray;
			currentIndex = 0;
			
			//Show the first recipe
			txt_recipeDescription.text = tempRecipeArray[currentIndex].SummaryString();
			txt_index.text = "Current Index: " + currentIndex.toString();
			readCost(tempRecipeArray[currentIndex].cost);
		}
		
		//This code fills in the text boxes with the essences that the player has
		function FillTextBoxes():void
		{
			var i:int = 0;
			var j:int = 0;
			var k:int = 0;
			for (i = 0; i < textBoxArray.length; i++)
			{
				textBoxArray[i].text = manager.player.esscencesBiomeArray[j][k].toString();
				if (j < 3)
				{
					j++;
				}
				else
				{
					j = 0;
					k++;
				}
			}
		}
		
		//Makes an item from the recipe
		function createButton(event:MouseEvent):void
		{
			if (checkCost(tempRecipeArray[currentIndex].cost)) //checks to make sure the player can afford the item
			{
				
				removeEssences(tempRecipeArray[currentIndex].cost); //remove the used essences
				FillTextBoxes(); // update the esscences text boxes
				makeItem(tempRecipeArray[currentIndex]); //creates the item and adds it to inventory
				removeRecipe();
				var eScreen:EssencesScreen = new EssencesScreen(manager);
				manager.addChild(eScreen);
				manager.removeChild(this);
				manager.CreateNotification("Item crafted.");
			}
		}
		
		function bButton(event:MouseEvent):void
		{
			var eScreen:EssencesScreen = new EssencesScreen(manager);
			manager.addChild(eScreen);
			manager.removeChild(this);
		}
		
		function rButton(event:MouseEvent):void
		{
			if (tempRecipeArray.length > currentIndex + 1)
			{
				currentIndex++;
			}
			else
			{
				currentIndex = 0;
			}
			txt_recipeDescription.text = tempRecipeArray[currentIndex].SummaryString();
			txt_index.text = "Current Index: " + currentIndex.toString();
			readCost(tempRecipeArray[currentIndex].cost);
		}
		
		function lButton(event:MouseEvent):void
		{
			if (currentIndex > 0)
			{
				currentIndex--;
			}
			else
			{
				currentIndex = tempRecipeArray.length - 1;
			}
			txt_recipeDescription.text = tempRecipeArray[currentIndex].SummaryString();
			txt_index.text = "Current Index: " + currentIndex.toString();
			readCost(tempRecipeArray[currentIndex].cost);
		}
		
		//sets the textBoxes to show the players essences and the recipe cost
		function readCost(costArray:Array)
		{
			var i:int = 0;
			var j:int = 0;
			var k:int = 0;
			for (i = 0; i < textBoxArray.length; i++)
			{
				var string1:String = manager.player.esscencesBiomeArray[j][k].toString();
				var string2:String = costArray[j][k].toString();
				textBoxArray[i].text = string1 + "-" + string2;
				//textBoxArray[i].text = manager.player.esscencesBiomeArray[j][k].toString() + "/" + costArray[j][k].toString();
				//textBoxArray[i].text = costArray[j][k].toString(); 
				if (j < 3)
				{
					j++;
				}
				else
				{
					j = 0;
					k++;
				}
			}
		}
		
		//returns true if the player can afford the item
		function checkCost(costArray:Array):Boolean
		{
			var toReturn:Boolean = false;
			var i:int = 0;
			var j:int = 0;
			var k:int = 0;
			var fail:int = 0;
			for (i = 0; i < textBoxArray.length; i++)
			{
				var have:int = manager.player.esscencesBiomeArray[j][k];
				var need:int = costArray[j][k];
				if (have - need < 0)
				{
					fail++;
				}
				if (j < 3)
				{
					j++;
				}
				else
				{
					j = 0;
					k++;
				}
			}
			if (fail > 0)
			{
				manager.CreateNotification("You cannot afford that recipe.");
				toReturn = false;
			}
			
			if (fail == 0)
			{
				toReturn = true;
			}
			return toReturn;
		}
		
		function removeEssences(costArray:Array)
		{
			var i:int = 0;
			var j:int = 0;
			var k:int = 0;
			for (i = 0; i < textBoxArray.length; i++)
			{
				var have:int = manager.player.esscencesBiomeArray[j][k];
				var need:int = costArray[j][k];
				
				var newCount = have - need;
				//manager.essencesBiomeArray[j][k] = newCount;
				manager.player.SetEsscencesBiomeArray(j,k,newCount);
				//This is where you stopped, maybe you need to make a function in manager that sets it, have it take 3 parameters, the row, column and the new cost
				
				if (j < 3)
				{
					j++;
				}
				else
				{
					j = 0;
					k++;
				}
			}
		}
		
		//creates an item from the recipe and adds it to the inventory in manager
		function makeItem(r:Recipe)
		{
			if(r.weapon)
			{
				var newWeapon:Weapon = new Weapon(r.manager,r.idNumber,r.equipment,r.ilevel, r.itemName, r.weapon, r.critChance,r.critDamageBonus, r.critEffect);
				manager.populateWeaponArray(newWeapon);
			}
			else
			{
				var newArmor:Armor = new Armor(r.manager, r.idNumber, r.equipment, r.ilevel, r.itemName, r.weapon, r.proficiency, r.statEffected, r.amountStatEffected);
				manager.populateArmorArray(newArmor);
			}
		}
		
		function removeRecipe()
		{
			manager.recipeArray.splice(currentIndex,1);
		}
	}
	
}