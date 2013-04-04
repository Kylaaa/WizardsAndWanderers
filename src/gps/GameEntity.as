package gps
{
	import flash.display.Sprite;
	
	public class GameEntity extends Sprite
	{
		// attribute variables
		public var health:Number;
		public var atkPwr:Number;
		public var speed:Number;
		public var critChance:Number;
		public var effectUnder:String;
		
		// the battle screen
		protected var battle:Battle;
		
		public function GameEntity(aBattle:Battle, xLoc:Number, yLoc:Number)
		{
			super();
			
			battle = aBattle;
			x = xLoc;
			y = yLoc;
		}
		
		public function destroy():void
		{
			battle.characterLayer.removeChild(this);
		}
	}
}