//Alex Goldberger
package rpg
{
	
	import flash.events.MouseEvent;
	
	import ManagerAlpha;
	
	public class Armor extends Item
	{
		
		public var proficiency:Number;
		public var statEffected:Array;
		public var amountStatEffected:Array;
		
		public function Armor(man:ManagerAlpha, id:int, equip:Boolean, lvl:int, iName:String, weap:Boolean, prof:int, sE:Array, aSE:Array)
		{
			// constructor code
			super(man, id, equip, lvl, iName, weap);
			
			proficiency = prof;
			statEffected = sE;
			amountStatEffected = aSE;
			
			this.buttonMode = true;
		}
		
		//this function handles the changes made when equiping an item
		public function onEquip():void
		{
			if (statEffected !=null)
				//if (statEffected.length > 0)
			{
				for (var i:int = 0; i < statEffected.length; i++)
				{
					switch (statEffected[i])
					{
						case 0 ://status prevention
							manager.player.statusPrevention +=  amountStatEffected[i];
							break;
						case 1 ://Crit Chance increase
							manager.player.critChance +=  amountStatEffected[i];
							break;
						case 2 ://Health Increase
							manager.player.health +=  amountStatEffected[i];
							break;
						case 3 ://Health Regen
							manager.player.healthRegen +=  amountStatEffected[i];
							break;
						case 4 ://Speed Boost Chance
							manager.player.speedBoostChance +=  amountStatEffected[i];
							break;
						case 5 ://Dodge Chance Increase
							manager.player.dodgeChance +=  amountStatEffected[i];
							break;
						case 6 ://Plus Damage VS:
							//THIS DOES NOTHING YET
							break;
					}
				}
			}
		}
		
		//this function handles the changes made when unequiping an item
		public function onUnequip():void
		{
			if (statEffected !=null)
				//if (statEffected.length > 0)
			{
				for (var i:int = 0; i <= statEffected.length; i++)
				{
					switch (statEffected[i])
					{
						case 0 ://status prevention
							manager.player.statusPrevention -=  amountStatEffected[i];
							break;
						case 1 ://Crit Chance increase
							manager.player.critChance -=  amountStatEffected[i];
							break;
						case 2 ://Health Increase
							manager.player.health -=  amountStatEffected[i];
							break;
						case 3 ://Health Regen
							manager.player.healthRegen -=  amountStatEffected[i];
							break;
						case 4 ://Speed Boost Chance
							manager.player.speedBoostChance -=  amountStatEffected[i];
							break;
						case 5 ://Dodge Chance Increase
							manager.player.dodgeChance -=  amountStatEffected[i];
							break;
						case 6 ://Plus Damage VS:
							//THIS DOES NOTHING YET
							break;
					}
				}
			}
		}
		
		override public function SummaryString():String
		{
			var toReturn:String = "\nItem: " + itemName + "\niLevel: " + ilevel + "\nType: " + "Armor" + "\nProficiency: " + proficiency ;// + "\nStat effected: " + statEffected + "\nEffect amount: " + amountStatEffected;
			if (statEffected !=null)
			{
				for (var i:int = 0; i < statEffected.length; i++)
				{
					toReturn += "\nStat effected: " + super.checkArmorStatusEffect(statEffected[i]);
					toReturn += "\nEffect amount: " + amountStatEffected[i];
				}
			}
			return toReturn;
		}
		
	}
	
}