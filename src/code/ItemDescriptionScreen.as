//Alex Goldberger
package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ManagerAlpha;
	
	//LEGACY///////LEGACY/////////////////LEGACY///////////////LEGACY///////////////LEGACY//////////////LEGACY//////////////LEGACY////////////
	public class ItemDescriptionScreen extends MovieClip {
		
		protected var manager:ManagerAlpha;
		
		//This displayed the stas of the item selected
		public function ItemDescriptionScreen(man:ManagerAlpha, itemDesc:String) {
			// constructor code
			manager = man;
			btn_Back_Item.addEventListener(MouseEvent.CLICK, bButton);
			btn_weaponI.addEventListener(MouseEvent.CLICK, wIButton);
			btn_armorI.addEventListener(MouseEvent.CLICK, aIButton);
			txt_inventory.text = itemDesc;
		}
		function bButton(event:MouseEvent):void{
			manager.removeChild(this);
		}
		function wIButton(event:MouseEvent):void{
			var wIScreen:inventoryScreen = new inventoryScreen(manager,"weapon");
			manager.addChild(wIScreen);
		}
		function aIButton(event:MouseEvent):void{
			var aIScreen:inventoryScreen = new inventoryScreen(manager,"armor");
			manager.addChild(aIScreen);
		}		
	}
	
}
