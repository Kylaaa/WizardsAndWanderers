package rpg
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import managers.ImageManager;
	import managers.ShapesManager;
	
	public class Enemy extends GameEntity
	{
		public var selected:Boolean;
		public var enemyNum:int;
		public var dead:Boolean = false;
		public var overShot:Boolean = false;
		public var moveForward:Boolean = false;
		
		public var rarity:int = 0;
		public var esscenceType:int; //1 = Forest, 2 = Wetland, 3 = Mountain 4 = Desert
		protected var backPreferece:Boolean = false;
		
		private var txt_health:TextField;
		
		public var done:Boolean = false;
		
		private var startX:int;
		private var startY:int;
		
		private var moveTick:Timer = new Timer(1000);
		
		public function Enemy(aBattle:Battle, xLoc:Number, yLoc:Number, num:int)
		{
			super(aBattle, xLoc, yLoc);
			
			addEventListener(MouseEvent.CLICK, theChosen);
			
			//setupEnemy();
			enemyNum = num;
			
			startX = xLoc;
			startY = yLoc;
			
			txt_health = new TextField();
			txt_health.setTextFormat(ShapesManager.textFormat);
		}
		
		public function rearrangeLocation(xLoc:Number, yLoc:Number):void
		{
			x = xLoc;
			y = yLoc;
		}
		
		public function setupEnemy(enemyStats:Object):void
		{
			myImage = ImageManager.getImageByName(enemyStats["imagePath"]);//;
			myImage.width = 150;
			myImage.height = 150;
			addChild(myImage);
			
			selected = false;
			
			maxHealth = parseInt(enemyStats["health"]);
			health = maxHealth;
			
			atkPwr = parseInt(enemyStats["attack"]);
			speed = parseInt(enemyStats["speed"]);
			//rarity = enemyStats["rarity"];;
			trace("Name: " + enemyStats["name"]);
			trace("Health: " + health);
			trace("Attack: " + atkPwr);
			trace("Speed: " + speed);
			
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
		
		public function theChosen(e:MouseEvent):void
		{
			//this checks if the enemy is being attacked by something that can hit any target or if it is in the front row
			if(battle.atkType == 4 || battle.atkType == 12 || enemyNum <= 3 || battle.enemies[enemyNum - 4] == null)
			{
				if(battle.attacking || battle.casting)
				{
					if(battle.doubleGoing && battle.doubleEnemyHeld == null)
					{
						battle.doubleEnemyHeld = this;
					}
					else
					{
						if((battle.atkType == 8 && (enemyNum == battle.doubleEnemyHeld.enemyNum + 1 || enemyNum == battle.doubleEnemyHeld.enemyNum - 1)) || battle.atkType != 8)
						{
							battle.selected = true;
							battle.selectedEnemy = this;
						}
						else
						{
							battle.selected = true;
							battle.selectedEnemy = battle.doubleEnemyHeld;
						}
					}
				}
			}
		}
		
		public function goForward():void
		{
			// makes this walk later
			moveForward = true;
		}
		
		// Things the enemy can do (should be moved to enemy class)
		public function enemyOptions():void
		{
			var randGen:int;
							
			// if the enemy is blind, check this
			var blind:Boolean = false;
			
			if(effectUnder == 7)
			{
				randGen = Math.random() * 2;
				
				if(randGen == 0)
					blind = true;
			}
			
			if(!imobile && !blind)
			{
				randGen = Math.random() * 100;
				
				// if they have fear, make it a 50 attack, 50 run away
				if(effectUnder == 8)
				{
					if(randGen > 50)
						randGen = Math.random() * 2;
					else
						randGen = 3;
				}
				else // make it harder to flee
				{
					if(randGen > 10)
						randGen = Math.random() * 2;
					else
						randGen = 3;
				}
				
				randGen = 1; //////////////////////////////////////////////////////////////////////////////// CHANGE THIS FOR THEM TO MAKE CHOICES
				
				switch(randGen)
				{
					case 1:	// attack (eventually show their move)
					case 2:	// magic  (eventually show their move)
						battle.health -= atkPwr;
						
						if(battle.health <= 0)
						{
							battle.cleanUp();
						}
						break;
					case 3:	// flee (50/50 chance to run away)
						randGen = Math.random() * 2;
						if(randGen == 0)
						{
							health = 0;
						}
						break;
				}
			}
			else
			{
				trace("The enemy is imobolized ");
			}
		}
		
		public function moveUp():Boolean
		{
			if (!moveTick.running)
				moveTick.start();
				
			if(x <= startX - 200)
			{
				if(enemyNum > 3)
				{
					enemyNum = enemyNum - 4;
				}
				
				moveTick.stop();
				moveTick.reset();
				
				moveForward = false;
				x = startX - 200;
				return true;
			}
			else
			{
				if(moveTick.currentCount % 2 == 0)
					x -= 3;
				return false;
			}
		}
		
		public function checkDeath():void
		{
			if(health <= 0)
			{
				if(effectUnder == 8)
					battle.manage.player.onMonsterKill(this, true);
				else
					battle.manage.player.onMonsterKill(this, false);
				
				dead = true;
				destroy();
			}
		}
		
		public function update():void
		{
			trace("Enemy " + enemyNum + " health: " + health);
			done = false;
			
			applyEffects();
			
			checkDeath();
			
			txt_health.text = health.toString();
			
			// can have a switch to determine what status is currently happening
			// txt_status.text = "imb";
			
			if(!dead)
			{
				if(moveForward)
				{
					while (moveForward)
					{
						moveUp();
					}
				}
				
				if(battle.player != null)
				{
					enemyOptions();
					done = true;
				}
			}
		}
	}
}