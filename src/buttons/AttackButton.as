package buttons
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class AttackButton extends SimpleButton
	{
		public function AttackButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
		}
	}
}