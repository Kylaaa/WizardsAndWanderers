//Alex Goldberger
package rpg
{
	
	import flash.events.MouseEvent;
	import ManagerAlpha;
	import rpg.Armor;
	
	public class Recipe extends Item
	{
		
		//Armor
		public var proficiency:Number;
		public var statEffected:Array;
		public var amountStatEffected:Array;
		
		//Weapon
		public var critChance:int;
		public var critDamageBonus:int;
		public var critEffect:int;
		
		public var cost:Array;
		
		//This takes an extra 2 or 3 parameters depending on what kind of equipment the recipe is for
		public function Recipe(man:ManagerAlpha, id:int, equip:Boolean, lvl:int, iName:String, weap:Boolean, prof:Number, sE:Array, aSE:Array, cC:int, cDB:int, cE:int, co:Array)
		{
			// constructor code
			super(man, id, equip, lvl, iName, weap);
			statEffected = sE;
			amountStatEffected = aSE;
			
			cost = co;
		}
		
		override public function SummaryString():String
		{
			var toReturn:String = "";
			if (weapon == false)
			{
				toReturn = "\nItem: " + itemName + "\niLevel: " + ilevel + "\nType: " + "Armor" + "\nProficiency: " + proficiency ;// + "\nStat effected: " + statEffected + "\nEffect amount: " + amountStatEffected;
				if (statEffected.length > 0)
				{
					for (var i:int = 0; i < statEffected.length; i++)
					{
						toReturn += "\nStat effected: " + super.checkArmorStatusEffect(statEffected[i]);
						toReturn += "\nEffect amount: " + amountStatEffected[i];
					}
				}
			}
			else
			{
				toReturn = "\nItem: " + itemName + "\niLevel: " + ilevel + "\nType: " + "Weapon" + "\nCritical Hit Chance: " + critChance + "\nCritical Damage Bonus: " + critDamageBonus + " Critical Effect: " + critEffect;
			}
			return toReturn;
		}
		
	}
	
}