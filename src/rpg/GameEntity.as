package rpg
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import managers.ImageManager;
	
	public class GameEntity extends Sprite
	{
		// attribute variables
		public var maxHealth:int;
		public var health:int;
		public var atkPwr:int;
		public var speed:int;
		public var effectUnder:int;
		
		public var accuracy:Number = 1;
		
		public var critChance:Number;
		
		protected var myImage:Bitmap;
		
		// variables used for damage that applies multiple turns
		public var imobile:Boolean = false;
		private var alreadyFrozen:Boolean = false;
		private var frozenChance:int;
		
		// the battle screen
		protected var battle:Battle;
		
		public function GameEntity(aBattle:Battle, xLoc:Number, yLoc:Number)
		{
			super();
			
			battle = aBattle;
			x = xLoc;
			y = yLoc;
		}
		
		// applies effects to the entity
		public function applyEffects():void
		{
			var i:int;
			
			// applied effects
			if(this != null)
			{
				switch(this.effectUnder)
				{
					case 0: 
						//this.clearStatusText();
						break;
					case 1:	// freeze
					case 2:	// paralysis
					case 4:	// thorns
					case 5: // snare
						this.imobolized();
						break;
					case 3:	// poison
					case 6: // burn
						this.multiTurnDamage();
						break;
					case 9:	// instant death
						if(this.effectUnder == 8)
						{
							this.health = 0;
						}
						break;
				}
			}
		}
		
		public function imobolized():void
		{
			var randGen:int;
			
			if(effectUnder == 1)	// frozen
			{
				if(!alreadyFrozen)
				{
					frozenChance = 100;
					alreadyFrozen = true;
					imobile = true;
				}
				else
				{
					frozenChance -= 25;
					
					if(frozenChance > 0)
					{
						randGen = Math.random() * 100;
						
						if(randGen >= frozenChance)
						{
							frozenChance = 0;
							alreadyFrozen = false;
							effectUnder = 0;
							imobile = false;
						}
						else
						{
							imobile = true;
						}
					}
					else
					{
						frozenChance = 0;
						alreadyFrozen = false;
						effectUnder = 0;
						imobile = false;
					}
				}
			}
			else if(effectUnder == 2)	// paralyzed
			{
				randGen = Math.random() * 100;
				
				if(randGen <= 25)
					imobile = true;
				else
					imobile = false;
			}
			else if(effectUnder == 4)	// thorns
			{
				health -= battle.atkPwr / 2;
				
				if(!alreadyFrozen)
				{
					frozenChance = 90;
					alreadyFrozen = true;
					imobile = true;
				}
				else
				{
					
					randGen = Math.random() * 90;
					
					if(randGen > frozenChance)
					{
						frozenChance = 0;
						alreadyFrozen = false;
						effectUnder = 0;
						imobile = false;
					}
					else
					{
						frozenChance -= 30;
					}
				}
				
			}
			else	// snare
			{
				if(!alreadyFrozen)
				{
					frozenChance = 90;
					alreadyFrozen = true;
					imobile = true;
				}
				else
				{
					frozenChance -= 30;
					
					if(frozenChance <= 0)
					{
						frozenChance = 0;
						alreadyFrozen = false;
						effectUnder = 0;
						imobile = false;
					}
				}
			}
		}
		
		public function multiTurnDamage():void
		{
			var randGen:int;
			
			health -= battle.atkPwr / 2;
			
			if(effectUnder == 3)	// poison
			{
				if(health < .125 * maxHealth)
					effectUnder = 0;
			}
			else	// burn
			{
				randGen = Math.random() * 2;
				
				if(randGen == 0)
					health -= battle.atkPwr;
			}
		}
		
		public function destroy():void
		{
			battle.characterLayer.removeChild(this);
		}
	}
}