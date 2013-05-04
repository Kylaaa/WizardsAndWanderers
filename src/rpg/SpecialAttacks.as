// Mark Spina
package rpg
{
	public class SpecialAttacks
	{
		private var battle:Battle;
		private var manage:ManagerAlpha;
		
		public function SpecialAttacks(newBattle:Battle, newManager:ManagerAlpha)
		{
			battle = newBattle;
			manage = newManager;
		}
		
		// Hit two chosen enemies
		public function doubleHit(doubleEnemyHeld:Enemy, damageDealt:int):void
		{
			doubleEnemyHeld.health -= damageDealt;
			doubleEnemyHeld.flashing();
			
			if(battle.critAttack)
				doubleEnemyHeld.effectUnder = battle.currentCritEffect;
			
			if(doubleEnemyHeld.health <= 0)
				doubleEnemyHeld = null;	
		}
		
		// Deal damage to the 4 enemies in front
		public function multiHit(selectedEnemy:Enemy, damageDealt:int):void
		{
			for(var j:int = 0; j <= battle.enemies.length; j++)
			{
				if(battle.enemies[j] != null && battle.enemies[j] != selectedEnemy)
				{
					if(j <= 3 || battle.enemies[j - 4] == null)
					{
						battle.enemies[j].health -= damageDealt;
						battle.enemies[j].flashing();
						
						if(battle.critAttack)
							battle.enemies[j].effectUnder = battle.currentCritEffect;
					}
				}
			}
		}
		
		// Deal damage to the front and back of a row
		public function piercingHit(chosenEnemy:Enemy, damageDealt:int):void
		{
			if(chosenEnemy != null)
			{
				chosenEnemy.health -= damageDealt;
				
				if(battle.critAttack)
					chosenEnemy.effectUnder = battle.currentCritEffect;
			}
		}
		
		// Deal damage in the 4 cardinal directions
		public function radialHit(chosenEnemy:Enemy, enemyNum:int, damageDealt:int):void
		{
			hitAdjacent(enemyNum, damageDealt, false);
			
			if(chosenEnemy != null)
			{
				chosenEnemy.health -= damageDealt;
				
				if(battle.critAttack)
					chosenEnemy.effectUnder = battle.currentCritEffect;
			}
		}
		
		// If the enemy in front dies, damage the one behind it
		public function trampleHit(selectedEnemy:Enemy, enemyBehind:Enemy, damageDealt:int):void
		{
			if(selectedEnemy.health <= 0)
			{
				if(enemyBehind != null)
				{
					enemyBehind.health -= damageDealt;
					enemyBehind.flashing();
					
					if(battle.critAttack)
						enemyBehind.effectUnder = battle.currentCritEffect;
				}
			}
		}
		
		// Deals damage in to two full rows
		public function meteorHit(selectedEnemy:Enemy, secondEnemy:Enemy, damageDealt:int):void
		{
			secondEnemy.health -= damageDealt;
			
			if(battle.enemies[selectedEnemy.enemyNum + 4] != null)
			{
				battle.enemies[selectedEnemy.enemyNum + 4].health -= damageDealt;
				battle.enemies[selectedEnemy.enemyNum + 4].flashing();
				
				if(battle.critAttack)
					battle.enemies[selectedEnemy.enemyNum + 4].effectUnder = battle.currentCritEffect;
			}
			
			if(battle.enemies[secondEnemy.enemyNum + 4] != null)
			{
				battle.enemies[secondEnemy.enemyNum + 4].health -= damageDealt;
				battle.enemies[secondEnemy.enemyNum + 4].flashing();
				
				if(battle.critAttack)
					battle.enemies[secondEnemy.enemyNum + 4].effectUnder = battle.currentCritEffect;
			}
			
			if(secondEnemy.health <= 0)
				battle.doubleEnemyHeld = null;	
		}
		
		// Deals damage in a specific area
		public function hailHit(selectedEnemy:Enemy, damageDealt:int):void
		{
			hitAdjacent(selectedEnemy.enemyNum, damageDealt, false);
			hitAdjacent(selectedEnemy.enemyNum + 4, damageDealt, false);
			
			if(battle.enemies[selectedEnemy.enemyNum + 4] != null)
			{
				battle.enemies[selectedEnemy.enemyNum + 4].health -= damageDealt;
				
				if(battle.critAttack)
					battle.enemies[selectedEnemy.enemyNum + 4].effectUnder = battle.currentCritEffect;
			}
		}
		
		// Deals damage to all enemies on screen
		public function allHit(damageDealt:int):void
		{
			for(var i:int = 0; i < battle.enemies.length; i++)
			{
				if(battle.enemies[i] != null)
				{
					battle.enemies[i].health -= damageDealt;
					battle.enemies[i].flashing();
					
					if(battle.critAttack)
						battle.enemies[i].effectUnder = battle.currentCritEffect;
				}
			}
		}
		
		// Used for Random 2, Random 3, and Random 6 attack types
		public function randomAtk(enemiesHit:int, damageDealt:int):void
		{
			var i:int;
			var randGen:int;
			
			for(i = 0; i < enemiesHit; i++)
			{
				randGen = Math.random() * 8;
				
				if(battle.enemies[randGen] != null)
				{
					battle.enemies[randGen].health -= damageDealt;
					battle.enemies[randGen].flashing();
					
					if(battle.critAttack)
						battle.enemies[randGen].effectUnder = battle.currentCritEffect;
				}
			}
		}
		
		// Used to hit 3 enemies at a given time
		public function hitAdjacent(selectedNum:int, damageDealt:int, triple:Boolean):void
		{
			var i:int;
			var tempLeft:Enemy;
			var tempRight:Enemy;
			
			for(i = 0; i < battle.enemies.length; i++)
			{
				if(battle.enemies[i] != null)
				{
					if(selectedNum == 1 || selectedNum == 2 || !triple)
					{
						if(battle.enemies[i].enemyNum == selectedNum - 1)
						{
							if((selectedNum >= 4 && battle.enemies[i].enemyNum >= 4) || (selectedNum < 4 && battle.enemies[i].enemyNum < 4))
								tempLeft = battle.enemies[i];
						}
						
						if(battle.enemies[i].enemyNum == selectedNum + 1)
						{
							if((selectedNum >= 4 && battle.enemies[i].enemyNum >= 4) || (selectedNum < 4 && battle.enemies[i].enemyNum < 4))
								tempRight = battle.enemies[i];
						}
					}
					else if(selectedNum == 0)	
					{
						if(battle.enemies[i].enemyNum == selectedNum + 1)
						{
							tempLeft = battle.enemies[i];
						}
						
						if(battle.enemies[i].enemyNum == selectedNum + 2)
						{
							tempRight = battle.enemies[i];
						}
					}
					else
					{
						if(battle.enemies[i].enemyNum == selectedNum- 1)
						{
							tempLeft = battle.enemies[i];
						}
						
						if(battle.enemies[i].enemyNum == selectedNum - 2)
						{
							tempRight = battle.enemies[i];
						}
					}
				}
			}
			
			// damages the other 2 enemies that have been found
			if(tempLeft != null)
			{
				tempLeft.health -= damageDealt;
				tempLeft.flashing();
				
				if(battle.critAttack)
					battle.enemies[tempLeft].effectUnder = battle.currentCritEffect;
			}
			
			if(tempRight != null)
			{
				tempRight.health -= damageDealt;
				tempRight.flashing();
				
				if(battle.critAttack)
					battle.enemies[tempRight].effectUnder = battle.currentCritEffect;
			}
		}
	}
}