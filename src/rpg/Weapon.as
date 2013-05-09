//Alex Goldberger
package rpg  {
	
		import flash.events.MouseEvent;
		import ManagerAlpha;
		
	public class Weapon extends Item {
		
		public var critChance:int;
		public var critDamageBonus:Number;
		public var critEffect:int; //have an array of weapon effects
		
		public function Weapon(man:ManagerAlpha, id:int, equip:Boolean, lvl:int, iName:String, weap:Boolean, cC:int, cDB:Number, cE:int) {
			// constructor code
			super(man, id, equip, lvl, iName, weap);
			critChance = cC;
			critDamageBonus = cDB;
			critEffect = cE;
			
			this.buttonMode = true;
			//this.addEventListener(MouseEvent.MOUSE_UP, MouseReleased);
			
		}

		
		/*override protected function MouseReleased(event:MouseEvent):void
		{
			//trace("unclick");
			this.stopDrag();
		}*/
		
		override public function SummaryString():String
		{
			return "\nItem: " + itemName + "\niLevel: " + ilevel + "\nType: " + "Weapon" + "\nCritical Hit Chance: " + critChance + "\nCritical Damage Bonus: " + critDamageBonus + " Critical Effect: " + critEffect;
		}

	}
	
}
