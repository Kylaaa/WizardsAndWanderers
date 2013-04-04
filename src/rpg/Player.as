package rpg
{
	import code.Weapon;
	import code.Armor;
	import flash.utils.ByteArray;
    import flash.net.FileReference;
    import flash.filesystem.File;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class Player
	{
		public var manager:ManagerAlpha;
		
		public var skills:Array = new Array("slash","stab");

		public var characterClass:String;

		public var level:int;

		public var hSpells:int;
		public var hourlySpells:Array;

		public var dSpells:int;
		public var dailySpells:Array;

		public var exp:int;
		public var expTilNext:int;

		public var curHealth:int;
		public var curWeapon:Weapon;

		public var gold:int;

		public var health:int;
		public var atkPwr:int;
		public var speed:int;
		public var effectUnder:int;
		public var missChance:int;

		public var statusPrevention:int;//this is the chance to resist a status effect
		public var critChance:int;//this currently will only take the armor but should also take the weapon
		public var healthRegen:int;
		public var speedBoostChance:int;
		public var dodgeChance:int;

		public var esscencesBiomeArray:Array;//This contains the player's essences

		public var equippedArmor:Armor;

		/// exploration
		public var exploreChargesCurrent:int;
		public var exploreChargesMax:int;
		public var exploreRechargeTime:int;//currently 1 hour
		///

		private var xml:XML;
		private var myData:XML;
		
		//var playerFile:File = File.applicationDirectory;
		//playerFile = playerFile.resolvePath(playerFile.xml);
		
		// access yjr sttsu
		public function Player(man:ManagerAlpha)
		{
			manager = man;
			health = 100;
			atkPwr = 10;
			speed = 10;
			curHealth = 100;

			esscencesBiomeArray = new Array(4);
			esscencesBiomeArray[0] = [1,2,3,0];//lesser
			esscencesBiomeArray[1] = [2,1,2,3];//average
			esscencesBiomeArray[2] = [3,2,1,2];//greater
			esscencesBiomeArray[3] = [0,3,2,1];//grand
			
			loadPlayerXML();
			/*
			xml = <xml>
			<test>lol</test>
			</xml>;*/
		}

		public function loadPlayerXML()
		{
			//Load Code
			var loader:URLLoader =  new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoaded);
			var url:URLRequest = new URLRequest("xml/PlayerData.xml");
			loader.load(url);
			
			//POST DATABASE
			//Store only the armor and weapon id's, both in inventory and equipped
			//Then read them in from the database and add them to the inventory and equipped
			//Right now the entire default armor is in the XML class
		}
		
		public function onLoaded(evt:Event):void
		{
			//maybe make it so that only some values get saved here such as health, equipped item, equipped armor, essccences, and equipped other
			//then have the other stuff all get taken care of when they are equipped
			myData = new XML(evt.target.data);
			gold = myData.charData. @ gold;
			atkPwr = myData.charData. @ atkPwr;
			speed = myData.charData. @ speed;
			effectUnder = myData.charData. @ effectUnder;
			missChance = myData.charData. @ missChance;
			statusPrevention = myData.charData. @ statusPrevention;
			healthRegen = myData.charData. @ healthRegen;
			critChance = myData.charData. @ critChance;
			speedBoostChance = myData.charData. @ speedBoostChance;
			dodgeChance = myData.charData. @ dodgeChance;
			
			
			//Load the default armor
			var id:int = myData.armorData. @ id;
			var lvl:int = myData.armorData. @ lvl;
			var iName:String = myData.armorData. @ iName;
			var prof:int = myData.armorData. @ prof;
			//var tempStatArray:Array = myData.charData. @ tempStatArray; //change this so it actually works for other items later
			//var tempStatEffectArray:Array = myData.charData. @ tempStatEffectArray; //change this so it actually works for other items later
			
			var tempStatArray:Array;
			var tempStatEffectArray:Array;
			
			var statCount:int = myData.armorData. @ statCount;
			if(statCount == 0)
			{
				tempStatArray = null;
				tempStatEffectArray = null;
			}
			else
			{
				//read in the values of the stat changers and set the arrays
			}
			var tempArmor:Armor = new Armor(manager,id,true,lvl,iName,false,prof,tempStatArray,tempStatEffectArray);
			
			manager.populateArmorArray(tempArmor);
			manager.equippedArmorId = tempArmor.idNumber; //equip the default armor
			tempArmor.onEquip(); //changes stats based on the equipped armor
			
			/* THIS IS WHERE YOU STOPPED ON THURSDAY WEEK 10 TRY TO GET IT TO LOAD ARRAYS (FIRST COMBINE MARK'S CODE AND CONSIDER DOING TO WEAPONS WHAT YOU DID TO ITEMS
	<statArray ele1 = "0" />
	<statEffectArray ele1 = "10" />
			*/
		}
		
		public function WriteXML()
		{
			//var file:File = File.documentsDirectory.resolvePath("xml/PlayerData.xml"); 
			//var fileStr:FileStream = new FileStream(); 
			//fileStr.open(file, FileMode.UPDATE);
			
			//fileStr
		}

		// set up the player for the game
		public function setupPlayer()
		{
			missChance = 10;

			/*
			call the database
			
			level = database.level
			
			hSpells = database.numHourSpells
			hourlySpells = database.hourSpells
			
			dSpells = database.numDaySpells
			dailySpells = database.daySpells
			
			health = database.maxHealth
			curHealth = database.health
			
			exp = database.exp
			expTilNext = database.ExpTilNextLevel
			
			atkPwr = database.attack
			*/
			speed = 3;
		}

		public function writeXml()
		{
			var ba:ByteArray = new ByteArray();
			ba.writeUTFBytes(xml);
			var f:File = new File();
			f.save(ba,"TheFile.xml");
			//var fr:FileReference = new FileReference();
			//fr.addEventListener(Event.SELECT, _onRefSelect);
			//fr.addEventListener(Event.CANCEL, _onRefCancel);
	
			//fr.save(ba, "filename.xml");
			trace("done");
		}

		// save the player to the database
		public function savePlayer()
		{
			/*
			database.level = level
			
			database.numHourSpells = hSpells
			database.hourSpells = hourlySpells
			
			database.numDaySpells = dSpells
			database.daySpells = dailySpells
			
			database.maxHealth = health
			database.health = curHealth
			
			database.exp = exp
			database.ExpTilNextLevel = expTilNext
			
			database.attack = atkPwr
			*/
		}

		//This function will give the player exp and essence for the enemy they have killed
		//the essence code is incomplete
		//later this could take the distance from home to get extra exp
		//later this could check to see if the player has never fought this enemy before, and record kill totals
		public function onMonsterKill(en:Enemy, feared:Boolean)
		{
			if (! feared)
			{
				var baseXP:int = 10;
				var et:int = en.esscenceType;//1 = Forest, 2 = Wetland, 3 = Mountain 4 = Desert
				switch (en.rarity)
				{
					case 1 ://common
						exp +=  baseXP;
						switch (et)
						{
							case 1 ://forest
								//give them a common forest esscence
								esscencesBiomeArray[0][0] = esscencesBiomeArray[0][0]++;
								break;
							case 2 ://wetland
								//give them a common wetland esscence
								esscencesBiomeArray[0][1] = esscencesBiomeArray[0][1]++;
								break;
							case 3 ://mountain
								//give them a common mountain esscence
								esscencesBiomeArray[0][2] = esscencesBiomeArray[0][2]++;
								break;
							case 4 ://desert
								//give them a common desert esscence
								esscencesBiomeArray[0][3] = esscencesBiomeArray[0][3]++;
								break;
						}
						break;
					case 2 ://uncommon
						exp +=  baseXP * 3;
						switch (et)
						{
							case 1 ://forest
								//give them a uncommon forest esscence
								esscencesBiomeArray[1][0] = esscencesBiomeArray[1][0]++;
								break;
							case 2 ://wetland
								//give them a uncommon wetland esscence
								esscencesBiomeArray[1][1] = esscencesBiomeArray[1][1]++;
								break;
							case 3 ://mountain
								//give them a uncommon mountain esscence
								esscencesBiomeArray[1][2] = esscencesBiomeArray[1][2]++;
								break;
							case 4 ://desert
								//give them a uncommon desert esscence
								esscencesBiomeArray[1][3] = esscencesBiomeArray[1][3]++;
								break;
						}
						break;
					case 3 ://rare
						exp +=  baseXP * 9;
						switch (et)
						{
							case 1 ://forest
								//give them a rare forest esscence
								esscencesBiomeArray[3][0] = esscencesBiomeArray[3][0]++;
								break;
							case 2 ://wetland
								//give them a rare wetland esscence
								esscencesBiomeArray[3][1] = esscencesBiomeArray[3][1]++;
								break;
							case 3 ://mountain
								//give them a rare mountain esscence
								esscencesBiomeArray[3][2] = esscencesBiomeArray[3][2]++;
								break;
							case 4 ://desert
								//give them a rare desert esscence
								esscencesBiomeArray[3][3] = esscencesBiomeArray[3][3]++;
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
								esscencesBiomeArray[4][0] = esscencesBiomeArray[4][0]++;
								break;
							case 2 ://wetland
								//give them a boss wetland esscence
								esscencesBiomeArray[4][1] = esscencesBiomeArray[4][1]++;
								break;
							case 3 ://mountain
								//give them a boss mountain esscence
								esscencesBiomeArray[4][2] = esscencesBiomeArray[4][2]++;
								break;
							case 4 ://desert
								//give them a boss desert esscence
								esscencesBiomeArray[4][3] = esscencesBiomeArray[4][3]++;
								break;
						}
				}
			}
		}
		//this function is used to change values in the essences array
		public function SetEsscencesBiomeArray(j,k,newCount):void
		{
			esscencesBiomeArray[j][k] = newCount;
		}

		public function SummaryString():String
		{
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
		
		/*
		public function update()
		{
			applyEffects();
		}
		*/
	}
}