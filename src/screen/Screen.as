package screen
{
	import caurina.transitions.Tweener;
	import flash.display.Sprite;
	import Game;
	
	public class Screen extends Sprite
	{
		public var manage:Game;
		
		public function Screen(newManager:Game)
		{
			super();
			manage = newManager;
			
			this.x = 0;
			this.y = 0;
			this.visible = true;
			this.alpha = 1.0;
		}
		
		public function bringIn():void
		{
			trace("bringing in: " + this);
			Tweener.addTween(this, { alpha:1.0, time:1.0, transition:"linear"} );
		}
		
		public function bringOut():void
		{
			Tweener.addTween(this, { alpha:0.0, time:1.0, transition:"linear", onComplete:cleanUp } );
			//cleanUp();
		}
		
		public function cleanUp():void
		{
			trace("Cleaning up: " + this);
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