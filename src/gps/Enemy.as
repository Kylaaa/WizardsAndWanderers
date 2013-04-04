package gps
{
	import flash.events.MouseEvent;
	
	public class Enemy extends GameEntity
	{
		public var selected:Boolean;
		public var enemyNum;
		public var dead:Boolean = false;
		public var overShot = false;
		public var moveForward:Boolean = false;
		
		protected var rarity:int = 0;
		protected var backPreferece:Boolean = false;
		
		public function Enemy(aBattle:Battle, xLoc:Number, yLoc:Number, num:int)
		{
			super(aBattle, xLoc, yLoc);
			
			addEventListener(MouseEvent.CLICK, theChosen);
			
			enemyNum = num;
			
			selected = false;
			
			health = 10;
			atkPwr = 10;
			speed = 10;
		}
		
		public function rearrangeLocation(xLoc:Number, yLoc:Number)
		{
			x = xLoc;
			y = yLoc;
		}
		
		public function setupEnemy(/* take id? */)
		{
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
		} 
		
		public function theChosen(e:MouseEvent)
		{
			if(battle.atkType == 4 || enemyNum <= 3 || battle.enemies[enemyNum - 4] == null)
			{
				if(battle.attacking || battle.casting)
				{
					battle.selected = true;
					battle.selectedEnemy = this;
				}
			}
			
		}
		
		public function goForward()
		{
			// makes this walk later
			moveForward = true;
		}
		
		public function update()
		{
			if(moveForward)
			{
				if(x <= stage.stageWidth - 150)
				{
					enemyNum -= 4;
					moveForward = false;
					x = stage.stageWidth - 150;
				}
				else
				{
					x -= 3;
				}
				
			}
		}
	}
}