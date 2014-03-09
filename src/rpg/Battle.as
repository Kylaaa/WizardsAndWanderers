package rpg
{
	import caurina.transitions.Tweener;
	import flash.display.SimpleButton;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import managers.ImageManager;
	import managers.ShapesManager;
	import mx.core.ButtonAsset;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.elements.BreakElement;
	
	import screen.MainScreen;
	import screen.Screen;
	import screen.SpellScreen;
	
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
		private var attackBtn:SimpleButton;
		private var magicBtn:SimpleButton;
		private var fleeBtn:SimpleButton;
		private var itemBtn:SimpleButton;
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
		
		private var criticalChance:int; 
		
		private var txt_health:TextField;
		
		private var spellCrit:Boolean = false;
		
		private var gameOver:Boolean;
		
		public function Battle(newManager:Game)
		{
			super(newManager);
			trace("New Battle");
			specAtk = new SpecialAttacks(this, newManager);
			addEventListener(Event.ENTER_FRAME, update);
			
			txt_health = new TextField();
			txt_health.setTextFormat(ShapesManager.textFormat);
			
			gameOver = false;
		}
		override public function bringIn():void 
		{
			super.bringIn();
			initialize();
		}
		public function initialize():void
		{			
			trace("Battle init");
			// adds multiple drawing layers
			addChild(backgroundLayer);
			addChild(characterLayer);
			addChild(foregroundLayer);
			
			backgroundLayer.addChild(manage.biomeBackground);
			
			listening = false;
			generateButtons();
			
			generateEnemies();
			
			player = new PlayerSprite(manage.player.level, 50, stage.stageHeight / 2);
			characterLayer.addChild(player);
			
			health = manage.player.curHealth;
			player.changeHealth(health);
			atkPwr = manage.player.atkPwr;
			speed = manage.player.speed;
			effectUnder = manage.player.effectUnder;
			missChance = manage.player.missChance;
			criticalChance = manage.player.currentWeapon.critChance;
			
			spScreen = new SpellScreen(this);
		}
		
		// Creates enemies by choosing an available enemy and then randomly placing
		// it in one of 8 spaces
		public function generateEnemies():void
		{
			var i:int;
			var j:int;
			var enemyCreator:Enemy;
			
			//read in from our current biome to make some enemies
			var allEnemies:Array = manage.device.CurrentBiome.Enemies; //array of database Objects
			
			// seperate enemies based upon rarity
			var commonEnemies:Array = new Array();
			var uncommonEnemies:Array = new Array();
			var rareEnemies:Array = new Array();
				
			for (i = 0; i < allEnemies.length; i ++)
			{
				
				if (allEnemies[i]["rarity"] == "COMMON")
				{
					commonEnemies.push(allEnemies[i]);
				}
				else if(allEnemies[i]["rarity"] == "UNCOMMON")
				{
					uncommonEnemies.push(allEnemies[i]);
				}
				else
				{
					rareEnemies.push(allEnemies[i]);
				}
				
				/*values include:
				-enemies[i]["health"]		//int but must be parsed from string
				-enemies[i]["speed"]
				-enemies[i]["attack"]
				-enemies[i]["block"] 		//boolean
				-enemies[i]["backRowTend"] 	//boolean
				-enemies[i]["monsterType"]	//String
				-enemies[i]["name"]			//String
				-enemies[i]["imagePath"]	//String
				-enemies[i]["powers"]		//String
				-enemies[i]["rarity"]
				-enemies[i]["id"]			//int but must be parsed
				*/
			}
				
			var enemyAmount:int = (Math.random() * 8) + 1;
			
			for(i = 0; i < enemyAmount; i++)
			{
				// Used to determine which enemy you're fighting
				var newEnemyIs:Object;
				
				var randGen:int = 25;//Math.random() * 100;
				var whichEnemy:int;
				
				if (randGen < 50)
				{
					whichEnemy = Math.random() * commonEnemies.length;
					newEnemyIs = commonEnemies[whichEnemy];
				}
				else if (randGen < 90)
				{
					whichEnemy = Math.random() * uncommonEnemies.length;
					newEnemyIs = uncommonEnemies[whichEnemy];
				}
				else
				{
					whichEnemy = Math.random() * rareEnemies.length;
					newEnemyIs = rareEnemies[whichEnemy];
				}
				
				var placedEnemy:Boolean = false;
				
				while(placedEnemy == false)
				{
					var randLoc:int = (Math.random() * 8);
					
					if(enemies[randLoc] == null)
					{
						var staggering:int;
						
						if(randLoc <= 3)
						{
							staggering = 350;
							if (randLoc % 2 == 0)
							{
								staggering = 400;
							}
							
							enemyCreator = new Enemy(this, manage.stage.stageWidth - staggering, (randLoc * 70) + 85, randLoc);
						}
						else
						{
							staggering = 150;
							if (randLoc % 2 == 0)
							{
								staggering = 200;
							}
							
							enemyCreator = new Enemy(this, manage.stage.stageWidth - staggering, ((randLoc - 4) * 70) + 85, randLoc);
						}
						
						enemyCreator.setupEnemy(newEnemyIs);
						enemies[randLoc] = enemyCreator;
						
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
					//enemies[i].moveForward = true;
					
					//while(enemies[i].moveForward)
					//	enemies[i].update();
					//Tweener.addTween(enemies[i], { x: -200, time: 1.0 } );
					enemies[i].moveUp();
				}
			}
			
			for (j = 0; j < enemies.length; j++)
			{
				if(enemies[j] != null)
					characterLayer.addChild(enemies[j]);
			}
		}
		
		// Creates the buttons that the user can interact with that have different actions
		// depending on the button
		public function generateButtons():void
		{
			var seperationDist:int = 100;
			
			// Attack Button
			
			attackBtn = ShapesManager.drawButton(-stage.stageWidth / 2 + 25, -125, 150, 50, "Attack", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			foregroundLayer.addChild(attackBtn);
			buttonArray.push(attackBtn);
			
			// Magic Button
			magicBtn = ShapesManager.drawButton(-stage.stageWidth / 2 + 185, -125, 150, 50, "Spells", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			foregroundLayer.addChild(magicBtn);
			buttonArray.push(magicBtn);
			
			// Flee Button
			fleeBtn = ShapesManager.drawButton(-stage.stageWidth / 2 + 185, -65, 150, 50, "Flee", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			foregroundLayer.addChild(fleeBtn);
			buttonArray.push(fleeBtn);
			
			// Item Button
			itemBtn = ShapesManager.drawButton(-stage.stageWidth / 2 + 25, -65, 150, 50, "Items", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			foregroundLayer.addChild(itemBtn);
			buttonArray.push(itemBtn);
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
			
			currentCritEffect = manage.player.currentWeapon.critEffect;
		}
		
		// Allows the player to cast a magic spell 
		private function onMagic(e:MouseEvent):void
		{
			//spawns or makes visible both buttons
			addChild(spScreen);
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
				var damageDealt:int = damageDealing(criticalChance, manage.player.currentWeapon.critDamageBonus);	// saves how much damage the player does
				
				damageDealt *= dmgModifier;

				if(dmgModifier != 1)
					dmgModifier = 1;
				
				if(damageDealt > 0 )
				{
					if(atkType < 10)
					{
						selectedEnemy.health -= damageDealt; // damages the clicked upon enemy
						
						selectedEnemy.flashing();
						
						if(critAttack || spellCrit)
							selectedEnemy.effectUnder = currentCritEffect;
							
						if (spellCrit)
							spellCrit = !spellCrit;
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
			//var spellSelected:int = 8; // move this somewhere when done testing
			spellSelected = ss;
			
			spellCrit = true;
			
			switch(spellSelected)
			{
				case 1:	// arcane missles 					
					atkType = 10;
					dmgModifier = 1.5;
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
				case 16:// Rampant Vines
					atkType = 12;
					dmgModifier = 0;
					currentCritEffect = 4;
					break;
				case 17:// Nature's Grasp
					atkType = 4;
					dmgModifier = 2;
					
					var qkRand:int = Math.random() * 2;
					
					if (qkRand % 2 == 0)
					{
						currentCritEffect = 0;
					}
					else
					{
						currentCritEffect = 4;
					}
					break;
				case 18:// Fury of the Wild
					atkPwr += 5;
					criticalChance += 5;
					currentCritEffect = 0;
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
				return;
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
						
						if (i <= 3 && enemies[i + 4] != null)
						{ 	
							enemies[i] = enemies[i + 4];
							// have to increment now or the last enemy isnt seen
							currEnemyAmount++;
							enemies[i + 4] = null;
							
							//enemies[i].moveForward = true;
							//while (enemies[i].moveForward)
							//{
								enemies[i].moveUp();
							//}
							
							for (var j:int = i; j <= enemies.length; j++)
							{
								if (enemies[j] != null)
								{
									var testEnemy:Enemy = enemies[j];
									characterLayer.setChildIndex(testEnemy, characterLayer.numChildren - 1);
								}
							}
						}
					}
				}
				
				player.changeHealth(health);
			}
		
			if(currEnemyAmount <= 0)
			{
				endBattle();
				return;
			}
		}
		
		// Allows the player to run away from the battle
		public function runningAway():void
		{
			var randGen:int = (Math.random() * 2) + 1;
			
			if(randGen == 1)
			{
				endBattle();
				return;
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
			
			if (!gameOver)
			{
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
					//while(checkDeath() == true)
					//{
					checkDeath();
					//}
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
					//while(checkDeath() == true)
					//{
						checkDeath();
					//}
					
					playerTurn = true;
				}
			}
		}
		
		// Destroys everything in the battle screen
		public function destroyAll():void
		{	
			var i:int;
			
			if (characterLayer.contains(player)) characterLayer.removeChild(player);
			
			// removes enemies
			for(i = 0; i < enemies.length; i++)
			{
				if(enemies[i] != null)
					enemies[i].destroy();
			}
			
			// removes buttons
			for(i = 0; i < buttonArray.length; i++)
			{
				if(buttonArray[i] != null && foregroundLayer.contains(buttonArray[i]))
					foregroundLayer.removeChild(buttonArray[i]);
			}
			
			// removes update
			removeEventListener(Event.ENTER_FRAME, update);
		}
		
		public function endBattle():void
		{
			gameOver = true;
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