//Alex Goldberger
package code {
	
	import rpg.ManagerAlpha;
	
	public class Exploring {
		
		public var manager:ManagerAlpha;
		
		public function Exploring(man:ManagerAlpha) {
			// constructor code
			
		}
		
		//This function will be called when the player explores and will do most of the work
		public function Explore():void
		{
			var rand:Number;
			rand = Math.random();
			trace(rand);
			
			//totalChance = .16;
			if(rand < .16)
			{
				//recipe find, just call a function and pass in rand
				//2.5% chance to find easy recipe 1
				//2.5% chance to find easy recipe 2
				//2.5% chance to find easy recipe 3
				//2.5% chance to find easy recipe 4
				//1% chance to find uncommon recipe part
				//1% chance to find uncommon recipe part 2
				//1% chance to find uncommon recipe part 3
				//.5% chance to find rare recipe part 1
				//.5% chance to find rare recipe part 2
			}
			else if(rand < .16 + .15)
			{
				//15% chance to get quest to find boss item (only unlocked after destroying every type of enemy in the biome)
				if(!false) //if(some bool that says if you've cleared the area)
				{
					Explore();
				}
			}
			else if(rand < .16 + .15 + .20)
			{
				//start encounter
				//20% chance to run into enemies
			}
			//https://docs.google.com/document/d/1POxFC8vdFo28uiiCN3xYHdxDJ1IiHOZbC8nJfaR_ICg/edit#
		}

	}
	
}
