package buttons
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import managers.ShapesManager;
	
	public class AttackButton extends SimpleButton
	{
		public function AttackButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
			
			if (upState == null)
			{
				this.upState = ShapesManager.buttonNormalState(200, 200, "attack");
				this.overState = ShapesManager.buttonOverState(200, 200, "attack");
				this.downState = ShapesManager.buttonDownState(200, 200, "attack");
				this.hitTestState = ShapesManager.buttonNormalState(200, 200);
			}
		}
	}
}