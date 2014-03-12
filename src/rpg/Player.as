package rpg
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import managers.ImageManager;
	import managers.ShapesManager;
	import rpg.Weapon;
	import rpg.Armor;
	import flash.utils.ByteArray;
    import flash.net.FileReference;
    import flash.filesystem.File;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Player
	{		
		//CONSTANTS
		public static const CLASS_DRUID:int = 2;
		public static const CLASS_PRIEST:int= 0;
		public static const CLASS_NECRO:int = 1;
		public static const CLASS_WIZARD:int= 3;
		public static const ESSENCE_FOREST:int  = 0;
		public static const ESSENCE_WETLAND:int = 1;
		public static const ESSENCE_MOUNTAIN:int= 2;
		public static const ESSENCE_DESERT:int  = 3;
		
		
		public var manager:Game;
		public var sprite:MovieClip;
		
		//player variables
		public var name:String;
		public var characterClass:String;
		public var characterType:int;
		public var skills:Array = new Array("slash", "stab");
		public var level:int;
		public var exp:int;
		public var expTilNext:int;
		public var gold:int;
		
		//spells stuff
		public var hSpells:int;
		public var hourlySpells:Array;
		public var dSpells:int;
		public var dailySpells:Array;

		
		//character variables
		public var curHealth:int;
		public var health:int;
		public var healthRegen:int;
		public var atkPwr:int;
		public var speed:int;
		public var effectUnder:int;
		public var missChance:int;
		public var statusPrevention:int;//this is the chance to resist a status effect
		public var critChance:int;//this currently will only take the armor but should also take the weapon
		
		public var speedBoostChance:int;
		public var dodgeChance:int;
		public var lastTimePlayed:Number;
		
		//inventory variables
		public var essencesBiomeArray:Array;//This contains the player's essences
		public var equippedArmor:Armor;
		public var currentWeapon:Weapon;
		//public var currentWeapon:Weapon;
		//public var equippedWeaponId:int;
		//public var equippedArmorId:int;
		//public var weaponImage:Bitmap = new Bitmap();

		/// exploration
		public var exploreChargesCurrent:int;
		public var exploreChargesMax:int;
		public var exploreRechargeTime:int;//currently 1 hour
	
		// CONSTRUCTOR AND INITIALIZATION FUNCTIONS
		public function Player(man:Game, characterXML:XML)
		{
			manager = man;
			
			//TO DO: LOAD THESE IN THE GAME SO THEY CAN BE SHARED ACROSS CHARACTERS
			essencesBiomeArray = new Array(4);
			essencesBiomeArray[ESSENCE_FOREST]  = [1,2,3,0];//lesser
			essencesBiomeArray[ESSENCE_WETLAND] = [2,1,2,3];//average
			essencesBiomeArray[ESSENCE_MOUNTAIN]= [3,2,1,2];//greater
			essencesBiomeArray[ESSENCE_DESERT]  = [0,3,2,1];//grand
			
			//pass a <character> tag to be parsed
			initFromXML(characterXML);
			
			//build the character sprite
			sprite = new MovieClip();
			sprite.addChild(ImageManager.MissingImage());
		}
		private function initFromXML(characterXML:XML):void
		{
			//INITIALIZE THE PLAYER BASED ON PASSED IN XML
			//trace("Player initFromXML function with: " + characterXML);
			
			name   			= characterXML.name[0];
			characterType   = characterXML.type[0];
			characterClass 	= Player.getCharacterClassName(characterType);
			level			= characterXML.level[0];
			curHealth		= characterXML.health[0];
			health			= characterXML.maxHealth[0];
			healthRegen		= characterXML.healthRegen[0]; // charData. @ healthRegen;
			atkPwr 			= characterXML.name[0];// .charData. @ atkPwr;
			speed 			= characterXML.speed[0];// charData. @ speed;
			effectUnder 	= characterXML.statusEffects[0];// charData. @ effectUnder;
			missChance 		= characterXML.chanceMiss[0]; // charData. @ missChance;
			dodgeChance 	= characterXML.chanceDodge[0]; // charData. @ dodgeChance;
			critChance 		= characterXML.chanceCrit[0];// charData. @ critChance;
			speedBoostChance= characterXML.chanceSpeedBoost[0]; // charData. @ speedBoostChance;
			//statusPrevention= characterXML.charData. @ statusPrevention;
			
			//load in the equipment
			initWeaponFromXML(characterXML.equipment[0].weapon[0]);
			initArmorFromXML(characterXML.equipment[0].armor[0]);

			/* THIS IS WHERE YOU STOPPED ON THURSDAY WEEK 10 TRY TO GET IT TO LOAD ARRAYS (FIRST COMBINE MARK'S CODE AND CONSIDER DOING TO WEAPONS WHAT YOU DID TO ITEMS
				<statArray ele1 = "0" />
				<statEffectArray ele1 = "10" />
			*/
				
			lastTimePlayed  = characterXML.lastTimePlayed[0];
		}
		private function initWeaponFromXML(weaponXML:XML):void
		{
			//lol weapons whut?
			//Set the default weapon (later get the weapon/armor from the Player XML)
			currentWeapon = new Weapon(manager, 0, true, 1, "Wooden Staff", true, 15, 1.75, 6);
			manager.populateWeaponArray(currentWeapon);
			
			
			//currentWeapon.onEquip(); //function does not exist yet?!
		}
		private function initArmorFromXML(armorXML:XML):void
		{
			//Load the default armor
			var id:int = armorXML.id[0];// .armorData. @ id;
			var lvl:int = armorXML.level[0]; // .armorData. @ lvl;
			var name:String = armorXML.name[0];// .armorData. @ iName;
			var prof:int = armorXML.prof[0];// .armorData. @ prof;
			
			var tempStatArray:Array;
			var tempStatEffectArray:Array;
			
			var statCount:int =  armorXML.statCount[0];// .armorData. @ statCount;
			if(statCount == 0)
			{
				tempStatArray = null;
				tempStatEffectArray = null;
			}
			else
			{
				//read in the values of the stat changers and set the arrays
			}
			equippedArmor = new Armor(manager, id, true, lvl, name, false, prof, tempStatArray, tempStatEffectArray);
			manager.populateArmorArray(equippedArmor);
			equippedArmor.onEquip(); //changes stats based on the equipped armor
		}
		
		//GLOBAL FUNCTIONS
		public function selectCharacter():void
		{
			//this player has been selected for play...
			//adjust health based on the last time you played this character
			var curDateTime:Date = new Date(); //get the current time
			var curTime:Number = Main.getCurrentTimeValue();
			var timeDifference:Number = (curTime - lastTimePlayed) < 0 ? 0 : curTime - lastTimePlayed;
			curHealth += timeDifference * healthRegen;
			
			//assign the new value
			lastTimePlayed = curTime;
		}
		
		
		//HELPER FUNCTIONS
		public static function getCharacterClassName(classID:int):String
		{
			switch (classID)
			{
				case(CLASS_DRUID): return "Druid";
				case(CLASS_NECRO): return "Necromancer";
				case(CLASS_PRIEST):return "Priest";
				case(CLASS_WIZARD):return "Wizard";
			}
			return "Invalid Class ID";
		}
		public function toString():String
		{
			//converts the character object to a string object
			var toReturn:String = "Character Screen";
			toReturn +=  "\nClass: " + characterClass;
			toReturn +=  "\nLevel: " + level;
			toReturn +=  "\nExp: " + exp;
			toReturn +=  "\nExp to lvl Up: " + expTilNext;
			toReturn +=  "\nMax Health: " + health;
			toReturn +=  "\nHealth: " + curHealth;
			toReturn +=  "\nGold: " + gold;
			toReturn +=  "\nAtk Pwr: " + atkPwr;
			toReturn +=  "\nSpeed: " + speed;
			toReturn +=  "\nStatus Prevention: " + statusPrevention;
			toReturn +=  "\nCrit Chance: " + critChance;
			toReturn +=  "\nHP Regen: " + healthRegen;
			toReturn +=  "\nSpeed Boost Chance: " + speedBoostChance;
			toReturn +=  "\ndodgeChance: " + dodgeChance;

			//hSpells:int;
			//hourlySpells:Array;

			//dSpells:int;
			//dailySpells:Array;

			//expTilNext:int;

			//curWeapon:Weapon;
			//effectUnder:int;
			//missChance:int;

			return toReturn;
		}
		public function toXML():String
		{			
			//convert the character back into an XML character tag
			var characterTag:String = "<character>";
				characterTag += "<type>" + characterType + "</type>";
				characterTag += "<name>" + name + "</name>";
				characterTag += "<level>" + level + "</level>";
				characterTag += "<attack>" + atkPwr + "</attack>";
				characterTag += "<speed>" + speed + "</speed>";
				characterTag += "<health>" + curHealth + "</health>";
				characterTag += "<healthMax>" + health + "</healthMax>";
				characterTag += "<healthRegen>" + healthRegen + "</healthRegen>";
				characterTag += "<statusEffects>" + statusPrevention + "</statusEffects>";
				characterTag += "<chanceMiss>" + missChance + "</chanceMiss>";
				characterTag += "<chanceDodge>" + dodgeChance + "</chanceDodge>";
				characterTag += "<chanceCrit>" + critChance + "</chanceCrit>";
				characterTag += "<chanceSpeedBoost>" + speedBoostChance + "</chanceSpeedBoost>";
				characterTag += "<lastTimePlayed>" + lastTimePlayed + "</lastTimePlayed>";
				characterTag += "<equipment>";
				characterTag += currentWeapon.toXML();
				characterTag += equippedArmor.toXML();
				characterTag += "</equipment>";
				characterTag += "</character>";
			return characterTag;
		}

		//This function will give the player exp and essence for the enemy they have killed
		//the essence code is incomplete
		//later this could take the distance from home to get extra exp
		//later this could check to see if the player has never fought this enemy before, and record kill totals
		public function onMonsterKill(en:Enemy, feared:Boolean):void
		{
			if (! feared)
			{
				var baseXP:int = 10;
				var et:int = en.esscenceType;//1 = Forest, 2 = Wetland, 3 = Mountain 4 = Desert
				
				essencesBiomeArray[en.rarity][en.esscenceType]++;
				
				//WHAT EVEN IS THIS CODE?!! WHO WROTE THIS?!!
				/*switch (en.rarity)
				{
					case 1 ://common
						exp +=  baseXP;
						switch (et)
						{
							case ESSENCE_FOREST ://forest
								//give them a common forest esscence
								essencesBiomeArray[0][ESSENCE_FOREST] = essencesBiomeArray[0][0]++;
								break;
							case 2 ://wetland
								//give them a common wetland esscence
								essencesBiomeArray[0][ESSENCE_WETLAND] = essencesBiomeArray[0][1]++;
								break;
							case 3 ://mountain
								//give them a common mountain esscence
								essencesBiomeArray[0][ESSENCE_MOUNTAIN] = essencesBiomeArray[0][2]++;
								break;
							case 4 ://desert
								//give them a common desert esscence
								essencesBiomeArray[0][ESSEN] = essencesBiomeArray[0][3]++;
								break;
						}
						break;
					case 2 ://uncommon
						exp +=  baseXP * 3;
						switch (et)
						{
							case 1 ://forest
								//give them a uncommon forest esscence
								essencesBiomeArray[1][0] = essencesBiomeArray[1][0]++;
								break;
							case 2 ://wetland
								//give them a uncommon wetland esscence
								essencesBiomeArray[1][1] = essencesBiomeArray[1][1]++;
								break;
							case 3 ://mountain
								//give them a uncommon mountain esscence
								essencesBiomeArray[1][2] = essencesBiomeArray[1][2]++;
								break;
							case 4 ://desert
								//give them a uncommon desert esscence
								essencesBiomeArray[1][3] = essencesBiomeArray[1][3]++;
								break;
						}
						break;
					case 3 ://rare
						exp +=  baseXP * 9;
						switch (et)
						{
							case 1 ://forest
								//give them a rare forest esscence
								essencesBiomeArray[3][0] = essencesBiomeArray[3][0]++;
								break;
							case 2 ://wetland
								//give them a rare wetland esscence
								essencesBiomeArray[3][1] = essencesBiomeArray[3][1]++;
								break;
							case 3 ://mountain
								//give them a rare mountain esscence
								essencesBiomeArray[3][2] = essencesBiomeArray[3][2]++;
								break;
							case 4 ://desert
								//give them a rare desert esscence
								essencesBiomeArray[3][3] = essencesBiomeArray[3][3]++;
								break;
						}
						break;
					case 4 ://boss
						exp +=  baseXP * 27;
						break;
						switch (et)
						{
							case 1 ://forest
								//give them a boss forest esscence
								essencesBiomeArray[4][0] = essencesBiomeArray[4][0]++;
								break;
							case 2 ://wetland
								//give them a boss wetland esscence
								essencesBiomeArray[4][1] = essencesBiomeArray[4][1]++;
								break;
							case 3 ://mountain
								//give them a boss mountain esscence
								essencesBiomeArray[4][2] = essencesBiomeArray[4][2]++;
								break;
							case 4 ://desert
								//give them a boss desert esscence
								essencesBiomeArray[4][3] = essencesBiomeArray[4][3]++;
								break;
						}
				}*/
			}
		}
		
		//this function is used to change values in the essences array
		public function SetEssencesBiomeArray(j:int,k:int,newCount:int):void
		{
			essencesBiomeArray[j][k] = newCount;
		}

		/*
		public function update()
		{
			applyEffects();
		}
		*/
	}
}