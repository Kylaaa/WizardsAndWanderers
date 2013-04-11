//Alex Goldberger
package code {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import ManagerAlpha;
	
	public class EssencesScreen extends MovieClip {
		
		protected var manager:ManagerAlpha;
		private var txt_biome:TextField;
		private var txt_eLevel:TextField;
		
		private var txt_e_F1:TextField;
		private var txt_e_F2:TextField;
		private var txt_e_F3:TextField;
		private var txt_e_F4:TextField;
		
		private var txt_e_W1:TextField;
		private var txt_e_W2:TextField;
		private var txt_e_W3:TextField;
		private var txt_e_W4:TextField;
		
		private var txt_e_M1:TextField;
		private var txt_e_M2:TextField;
		private var txt_e_M3:TextField;
		private var txt_e_M4:TextField;
		
		private var txt_e_D1:TextField;
		private var txt_e_D2:TextField;
		private var txt_e_D3:TextField;
		private var txt_e_D4:TextField;
		
		private var btn_Back_Essences:SimpleButton;
		private var btn_essenceUp:SimpleButton;
		private var btn_essenceDown:SimpleButton;
		private var btn_EssenceBiomeLeft:SimpleButton;
		private var btn_EssenceBiomeRight:SimpleButton;
		private var btn_essenceAdd:SimpleButton;
		private var btn_recipe:SimpleButton;
		
		
		public function EssencesScreen(man:ManagerAlpha) {
			// constructor code
			manager = man;
			btn_Back_Essences.addEventListener(MouseEvent.CLICK, bButton);
			btn_essenceUp.addEventListener(MouseEvent.CLICK, upButton);
			btn_essenceDown.addEventListener(MouseEvent.CLICK, downButton); 
			btn_EssenceBiomeLeft.addEventListener(MouseEvent.CLICK, leftButton); 
			btn_EssenceBiomeRight.addEventListener(MouseEvent.CLICK, rightButton);
			btn_essenceAdd.addEventListener(MouseEvent.CLICK, addButton);
			btn_recipe.addEventListener(MouseEvent.CLICK, recipeButton);
			
			txt_e_F1.text = manager.player.esscencesBiomeArray[0][0].toString();
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
			txt_e_D4.text = manager.player.esscencesBiomeArray[3][3].toString();
		}
		
		function bButton(event:MouseEvent):void{
			manager.removeChild(this);
		}
		
		function addButton(event:MouseEvent):void{
			
			var row:int;
			var column:int;
			if(txt_eLevel.text == "Lesser")
			{
				row = 0;
			}
			else if(txt_eLevel.text == "Average")
			{
				row = 1;
			}
			else if(txt_eLevel.text == "Greater")
			{
				row = 2;
			}
			else if(txt_eLevel.text == "Grand")
			{
				row = 3;
			}
			
			if(txt_biome.text == "Forest")
			{
				column = 0;
			}
			else if(txt_biome.text == "Wetlands")
			{
				column = 1;
			}
			else if(txt_biome.text == "Mountain")
			{
				column = 2;
			}
			else if(txt_biome.text == "Desert")
			{
				column = 3;
			}
			
			manager.player.esscencesBiomeArray[row][column] = manager.player.esscencesBiomeArray[row][column] + 1;
			
			txt_e_F1.text = manager.player.esscencesBiomeArray[0][0].toString();
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
			txt_e_D4.text = manager.player.esscencesBiomeArray[3][3].toString();
			
		}
		
		function upButton(event:MouseEvent):void{
			if(txt_eLevel.text == "Average")
			{
				txt_eLevel.text = "Lesser";
			}
			else if(txt_eLevel.text == "Greater")
			{
				txt_eLevel.text = "Average";
			}
			else if(txt_eLevel.text == "Grand")
			{
				txt_eLevel.text = "Greater";			
			}
			
			//trace("." + txt_eLevel.text + ".");
		}
		
		function downButton(event:MouseEvent):void{
			if(txt_eLevel.text == "Lesser")
			{
				txt_eLevel.text = "Average";
			}
			else if(txt_eLevel.text == "Average")
			{
				txt_eLevel.text = "Greater";
			}
			else if(txt_eLevel.text == "Greater")
			{
				txt_eLevel.text = "Grand";			
			}
			
		}
		
		function rightButton(event:MouseEvent):void{
			if(txt_biome.text == "Forest")
			{
				txt_biome.text = "Wetlands";
			}
			else if(txt_biome.text == "Wetlands")
			{
				txt_biome.text = "Mountain";
			}
			else if(txt_biome.text == "Mountain")
			{
				txt_biome.text = "Desert";
			}
			else if(txt_biome.text == "Desert")
			{
				txt_biome.text = "Forest";
			}						
		}	
		
		function leftButton(event:MouseEvent):void{
			if(txt_biome.text == "Wetlands")
			{
				txt_biome.text = "Forest";
			}
			else if(txt_biome.text == "Mountain")
			{
				txt_biome.text = "Wetlands";
			}
			else if(txt_biome.text == "Desert")
			{
				txt_biome.text = "Mountain";
			}			
			else if(txt_biome.text == "Forest")
			{
				txt_biome.text = "Desert";
			}			
		}
		
		function recipeButton(event:MouseEvent):void{
			if(manager.recipeArray.length > 0)
			{
			var rScreen:RecipeScreen = new RecipeScreen(manager);
			manager.addChild(rScreen);
			manager.removeChild(this);
			}
			else
			{
				manager.CreateNotification("You have no recipes.");
			}
		}
		
	}
	
}
