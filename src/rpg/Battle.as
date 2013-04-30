package rpg
{
	import flash.display.SimpleButton;
	import flash.text.TextField;
	import managers.ImageManager;
	import managers.ShapesManager;
	import mx.core.ButtonAsset;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.elements.BreakElement;
	
	import screen.MainScreen;
	import screen.Screen;
	import code.SpellScreen;
	
	public class Battle extends Screen
	{
		// layer variables
		public var backgroundLayer:Sprite = new Sprite();	// background images
		public var characterLayer:Sprite = new Sprite();	// player and enemies
		public var foregroundLayer:Sprite = new Sprite();	// attack graphics
		
		// character variables
		public var player:PlayerSprite;
		public var enemies:Array = new Array();
		
		// button variables
		private var buttonArray:Array = new Array();
		private var attackBtn:Sprite;
		private var magicBtn:Sprite;
		private var fleeBtn:Sprite;
		private var listening:Boolean;
		
		// turn variable
		private var playerTurn:Boolean = true;
		public var attacking:Boolean = false;
		public var casting:Boolean = false;
		public var fleeing:Boolean = false;
		
		// attacking/magic variables
		public var selected:Boolean = false;
		public var selectedEnemy:Enemy;
		public var atkType:int = 0;
		public var dmgModifier:Number = 1;
		
			// subset used for choosing 2 enemies
		public var doubleEnemyHeld:Enemy;
		public var doubleGoing:Boolean = false;
		
		public var health:int;
		public var atkPwr:int;
		public var speed:int;
		public var effectUnder:int;
		public var missChance:int;
		
		// for critical attacksy
		public var critAttack:Boolean = false; 
		public var currentCritEffect:int = 0;
		
		// used for special attacks
		private var specAtk:SpecialAttacks;
		
		private var spellSelected:int = 1; // move this somewhere when done testing
		public var spScreen:SpellScreen;
		
		private var txt_health:TextField;
		
		public function Battle(newManager:ManagerAlpha)
		{
			super(newManager);
			
			specAtk = new SpecialAttacks(this, newManager);
			addEventListener(Event.ENTER_FRAME, update);
			
			txt_health = new TextField();
			txt_health.setTextFormat(ShapesManager.textFormat);
		}
		
		public function initialize():void
		{			
			// adds multiple drawing layers
			addChild(backgroundLayer);
			addChild(characterLayer);
			addChild(foregroundLayer);
			
			backgroundLayer.addChild(manage.biomeBackground);
			
			listening = false;
			generateButtons();
			
			generateEnemies();
			
			player = new PlayerSprite(50, manage.stage.stageHeight / 2);
			characterLayer.addChild(player);
			
			health = manage.player.curHealth;
			atkPwr = manage.player.atkPwr;
			speed = manage.player.speed;
			effectUnder = manage.player.effectUnder;
			missChance = manage.player.missChance;
			
			spScreen = new SpellScreen(this);
		}
		
		// Creates enemies by choosing an available enemy and then randomly placing
		// it in one of 8 spaces
		public function generateEnemies():void
		{
			var i:int;
			var enemyCreator:Enemy;
			var rar:int = (Math.random() * 3) + 1; // randomizer variable for rarity, will be read from biome later
			var randGen:int = (Math.random() * 8) + 1; // randomizer variable
			//randGen = 8;
			for(i = 0; i < randGen; i++)
			{
				var placedEnemy:Boolean = false;
				
				while(placedEnemy == false)
				{
					var randLoc:int = (Math.random() * 8);
					
					if(enemies[randLoc] == null)
					{
						if(randLoc <= 3)
						{
							// enemyCreator = database.enemy (check biome, go through numbers, randomize the rarity, etc.)
							enemyCreator = new Enemy(this, manage.stage.stageWidth - 150, (randLoc * 70) + 85, randLoc,rar);
						}
						else
						{
							// enemyCreator = database.enemy (check biome, go through numbers, randomize the rarity, etc.)
							enemyCreator = new Enemy(this, manage.stage.stageWidth - 50, ((randLoc - 4) * 70) + 85, randLoc,rar);
						}
						
						enemies[randLoc] = enemyCreator;
						characterLayer.addChild(enemies[randLoc]);
						
						placedEnemy = true;
					}
				}
			}
			
			// go through and arrange them based on front - back preference (bubble sort)
			
			// if there is no enemy in front, move the one sitting in the back forward
			for(i = 4; i < enemies.length; i++)
			{
				if(enemies[i] != null && enemies[i - 4] == null)
				{
					// make this 'walk' later
					enemies[i].moveForward = true;
					
					while(enemies[i].moveForward)
						enemies[i].update();
				}
			}
		}
		
		// Creates the buttons that the user can interact with that have different actions
		// depending on the button
		public function generateButtons():void
		{
			var seperationDist:int = 100;
			
			// Attack Button
			
			attackBtn = new Sprite();
			attackBtn.addChild(ImageManager.IconCastle());
			attackBtn.x = (attackBtn.width * 0) + seperationDist;
			attackBtn.y = (manage.stage.stageHeight - attackBtn.height / 2) - 10;
			foregroundLayer.addChild(attackBtn);
			buttonArray.push(attackBtn);
			
			// Magic Button
			magicBtn = new Sprite();
			magicBtn.addChild(ImageManager.IconWizard());
			magicBtn.x = (attackBtn.width * 1) + seperationDist;
			magicBtn.y = (manage.stage.stageHeight - magicBtn.height / 2) - 10;
			foregroundLayer.addChild(magicBtn);
			buttonArray.push(magicBtn);
			
			// Flee Button
			fleeBtn = new Sprite();
			fleeBtn.addChild(ImageManager.IconScroll());
			fleeBtn.x = (attackBtn.width * 2) + seperationDist;
			fleeBtn.y = (manage.stage.stageHeight - fleeBtn.height / 2) - 10;
			foregroundLayer.addChild(fleeBtn);
			buttonArray.push(fleeBtn);
		}
		
		// When the player goes to attack, this sets it up as well as what kind
		// of attack it will be
		private function onAttack(e:MouseEvent):void
		{
			// opens up a menu of skills that the player has and continues when one is selected
			attacking = true;
			atkType = 0;
			
			// allows 2 different enemies to be selected on a given turn
			if((atkType == 1 || atkType == 8) && enemies.length >= 2)
			{
					doubleGoing = true;
			}
			
			currentCritEffect = manage.currentWeapon.critEffect;
		}
		
		// Allows the player to cast a magic spell 
		private function onMagic(e:MouseEvent):void
		{
			//spawns or makes visible both buttons
			addChild(spScreen);
			
			// opens up a menu of spells that the player has and continues when one is selected
			casting = true;
		}
		
		// Allows the player to run away
		private function onFlee(e:MouseEvent):void
		{
			fleeing = true;
			endTurn();
		}
		
		// Ends the players turn
		private function endTurn():void
		{
			playerTurn =  false;
		}
		
		private function damageDealing(critChance:int, critDamage:Number):int
		{
			var randGen:int = Math.random() * 100;
			
			if(randGen <= missChance)	// miss attack
			{
				return 0;
			}
			else if(randGen > missChance && randGen <= (critChance + missChance)) // crit attack
			{
				var daCrit:Number = critDamage;
				
				critAttack = true;
				
				if(casting)
					daCrit = 1;
					
				return atkPwr * daCrit;
			}
			else	// normal attack
			{
				return atkPwr;
			}
		}
		
		// Applies damage to enemies depending on the type of attack used
		private function damagingEnemies():void
		{
			var i:int;
			
			if(selected)
			{
				var damageDealt:int = damageDealing(manage.currentWeapon.critChance, manage.currentWeapon.critDamageBonus);	// saves how much damage the player does
				
				damageDealt *= dmgModifier;

				if(dmgModifier != 1)
					dmgModifier = 1;
				
				if(damageDealt > 0 )
				{
					if(atkType < 10)
					{
						selectedEnemy.health -= damageDealt; // damages the clicked upon enemy
						
						if(critAttack)
							selectedEnemy.effectUnder = currentCritEffect;
					}
					
					// originally used to locate where the enemy was, may be redundant now
					var whichSpot:int;
					
					for(i = 0; i < enemies.length; i++)
					{
						if(enemies[i] == selectedEnemy)
						{
							whichSpot = i;
						}
					}
					
					var j:int;
					
					switch(atkType)
					{
						case 1: // double
							if(doubleGoing)
							{
								doubleGoing = false;
								specAtk.doubleHit(doubleEnemyHeld, damageDealt);
							}
							break;
						case 2: // triple
							specAtk.hitAdjacent(selectedEnemy.enemyNum, damageDealt, true);
							break;
						case 3: // multi
							specAtk.multiHit(selectedEnemy, damageDealt);
							break;
						case 5: // piercing
							specAtk.piercingHit(enemies[whichSpot + 4], damageDealt);
							break;
						case 6: // radial
							specAtk.radialHit(enemies[whichSpot + 4], selectedEnemy.enemyNum, damageDealt);
							break;
						case 7: // trample
							specAtk.trampleHit(selectedEnemy, enemies[whichSpot + 4], damageDealt);
							break;
						case 8: // meteor
							if(doubleGoing)
							{
								doubleGoing = false;
								specAtk.meteorHit(selectedEnemy, doubleEnemyHeld, damageDealt);
							}
							break;
						case 9:	// hail
							specAtk.hailHit(selectedEnemy, damageDealt);
							break;
						case 10: // random 2
							specAtk.randomAtk(2, damageDealt);
							break;
						case 11: // random 3
							specAtk.randomAtk(3, damageDealt);
							break;
						case 12: // all
							specAtk.allHit(damageDealt);
							break;
						case 13: // random 6
							specAtk.randomAtk(6, damageDealt);
							break;
					}
				}
				
				if(doubleGoing == false)
				{
					selected = false;
					selectedEnemy = null;
					
					if(attacking)
						attacking = false;
					
					if(casting)
						casting = false;
				}
				
				if(atkType != 0)
					atkType = 0;
				
				if(currentCritEffect != 0)
					currentCritEffect = 0;
					
				endTurn();
			}
		}
		
		// uses a spell to hit an enemy (move this to its own class)
		public function spellAtk(ss:int):void
		{			
			trace(ss);
			//var spellSelected:int = 8; // move this somewhere when done testing
			spellSelected = ss;
			
			switch(spellSelected)
			{
				case 1:	// arcane missles 					
					atkType = 10;
					dmgModifier = 1.75;
					currentCritEffect = 0;
					break;
				case 2: // arcane missles 2
					atkType = 11;
					dmgModifier = 1.75;
					currentCritEffect = 0;
					break;
				case 3:	// freezing spray
					atkType = 2;
					dmgModifier = .8;
					currentCritEffect = 1;
					break;
				case 4:	// freezing spray 2
					atkType = 2;
					dmgModifier = 1;
					currentCritEffect = 1;
					break;
				case 5:	// furious bolt
					atkType = 0;
					dmgModifier = 2.25;
					currentCritEffect = 2;
					break;
				case 6:	// furious bolt 2
					atkType = 0;
					dmgModifier = 2.80;
					currentCritEffect = 2;
					break;
				case 7:	// lightning spear
					atkType = 5;
					dmgModifier = 1.10;
					currentCritEffect = 2;
					break;
				case 8:	// lightning spear 2
					atkType = 5;
					dmgModifier = 1.50;
					currentCritEffect = 2;
					break;
				case 9:	// ice armor (armor buff)
					break;
				case 10:// ice armor 2 (armor buff)
					break;
				case 11:// arcane fireworks
					atkType = 13;
					dmgModifier = 1.50;
					currentCritEffect = 0;
					break;
				case 12:// blizzard
					atkType = 12;
					dmgModifier = 1;
					currentCritEffect = 1;
					break;
				case 13:// chain lightning (needs a new type, random 6 chain)
					//atkType = 0;
					//dmgModifier = .90;
					//currentCritEffect = 2;
					//break;
				case 14:// Arc Boulder
					atkType = 4;
					dmgModifier = 1.75;
					currentCritEffect = 2;
					break;
				case 15:// Creeping Cold
					atkType = 7;
					dmgModifier = 1.25;
					currentCritEffect = 1;
					break;					
				default:
					atkType = 0;
					dmgModifier = 1;
					currentCritEffect = 0;
			}
			
			damagingEnemies();
		}
		
		// Checks to see if an enemy is dead and if they are to remove it from the
		// game
		public function checkDeath():void
		{
			var i:int;
			
			if(player != null && health <= 0)	// if the player is dead then clean up the game
			{
				endBattle();
			}
			
			var currEnemyAmount:int = 0;
			
			for(i = 0; i < enemies.length; i++)
			{
				if (enemies[i] == null) continue;
				if(!enemies[i].dead)
				{
					currEnemyAmount++;
				}
				else
				{
					if(characterLayer.contains(enemies[i]))
					{
						characterLayer.removeChild(enemies[i]);
						enemies[i] = null;
						
						if(i < 3 && enemies[i + 4] != null)
							enemies[i + 4].moveForward = true;
					}
				}
			}
		
			if(currEnemyAmount <= 0)
			{
				endBattle();
			}
		}
		
		// Allows the player to run away from the battle
		public function runningAway():void
		{
			var randGen:int = (Math.random() * 2) + 1;
			
			if(randGen == 1)
			{
				endBattle();
			}
			
			fleeing = false;
		}
		
		
		// currently only applies effects to enemies
		public function applyEffects():void
		{
			var i:int;
			
			// applied effects
			for(i = 0; i < enemies.length; i++)
			{
				if(enemies[i] != null)
				{
					switch(enemies[i].effectUnder)
					{
						case 0: 
							enemies[i].clearStatusText();
							break;
						case 1:	// freeze
						case 2:	// paralysis
						case 4:	// thorns
						case 5: // snare
							enemies[i].imobolized();
							break;
						case 3:	// poison
						case 6: // burn
							enemies[i].multiTurnDamage();
							break;
						case 9:	// instant death
							if(enemies[i].effectUnder == 8)
							{
								enemies[i].health = 0;
							}
							break;
					}
				}
			}
		}
		
		// Updates the game (hurdur)
		public function update(e:Event):void
		{
			/*
				Simplified Update Method
					Player Turn
					Enemy Turn
					playerTurn = true;
			*/
					
			txt_health.text = "Health: " + health;
			var i:int;
			
			var movingEnemies:Boolean = false; // used to not allow the player to go if an enemy is moving forward
			
			// following is what can happen during the players turn
			if(playerTurn)
			{
				if(!listening)
				{
					listening = true;
					
					attackBtn.addEventListener(MouseEvent.CLICK, onAttack);
					magicBtn.addEventListener(MouseEvent.CLICK, onMagic);
					fleeBtn.addEventListener(MouseEvent.CLICK, onFlee);
				}
				
				if(attacking || casting)	// if you're fighting then damage enemies with attacks
				{
					damagingEnemies();
				}
				else if(fleeing)			// otherwise run away
				{
					runningAway();
				}
				
				// makes sure everything is dead if it should be
				while(checkDeath() == true)
				{
					checkDeath();
				}
			}
			else		// if it's the enemies turn remove the ability to click buttons
			{
				if(listening)
				{
					listening = false;
					attackBtn.removeEventListener(MouseEvent.CLICK, onAttack);
					magicBtn.removeEventListener(MouseEvent.CLICK, onMagic);
					fleeBtn.removeEventListener(MouseEvent.CLICK, onFlee);
				}
				
				// checks to see if any back enemies need to move forward
				for(i = 0; i < enemies.length; i++)
				{
					if(enemies[i] != null)
					{
						enemies[i].update();
					}
				}
				
				// makes sure everything is dead if it should be
				while(checkDeath() == true)
				{
					checkDeath();
				}
				
				playerTurn = true;
			}
			
		}
		
		// Destroys everything in the battle screen
		public function destroyAll():void
		{	
			var i:int;
			
			characterLayer.removeChild(player);
			
			// removes enemies
			for(i = 0; i < enemies.length; i++)
			{
				if(enemies[i] != null)
					enemies[i].destroy();
			}
			
			// removes buttons
			for(i = 0; i < buttonArray.length; i++)
			{
				if(buttonArray[i] != null)
					foregroundLayer.removeChild(buttonArray[i]);
			}
			
			// removes update
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		public function endBattle():void
		{
			manage.displayScreen(MainScreen);
		}
		
		// Cleans the current screen
		public override function cleanUp():void
		{
			manage.player.curHealth = health;
			destroyAll();
			txt_health.text = "";
		}
	}
}