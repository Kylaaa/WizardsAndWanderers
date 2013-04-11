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
		
		public function bringIn()
		{
			
		}
		
		public function bringOut()
		{
			cleanUp();
		}
		
		public function cleanUp()
		{
			if(parent != null)
			{
				stage.stageFocusRect = false;
				stage.focus = manage;
				parent.removeChild(this);
			}
		}
	}
}