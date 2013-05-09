//Alex Goldberger
package rpg {
	
	public class Enchantments {

		public tier:int;
		public var cost:Array;
		public eName:String;
		public int: effect;
		
		public function Enchantments() {
			// constructor code
		}
		
		public function SummaryString():String
		{
			var toReturn:String = "";
				toReturn = "\nEnchantment: " + eName + "\nTier: " + tier + "\nEffect: " + effect;
			return toReturn;
		}

	}
	
}
