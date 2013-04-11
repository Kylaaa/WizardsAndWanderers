package screen
{
	import caurina.transitions.Tweener;
	import flash.display.Sprite;
	import ManagerAlpha;
	
	public class Screen extends Sprite
	{
		public var manage:ManagerAlpha;
		
		public function Screen(newManager:ManagerAlpha)
		{
			super();
			manage = newManager;
		}
		
		public function bringIn():void
		{
			
		}
		
		public function bringOut():void
		{
			cleanUp();
		}
		
		public function cleanUp():void
		{
			if(parent != null)
			{
				stage.stageFocusRect = false;
				stage.focus = manage;
				
				while (this.numChildren > 0 ) {	this.removeChildAt(0);	}
				parent.removeChild(this);
			}
		}
	}
}