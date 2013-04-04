package buttons
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class FleeButton extends SimpleButton
	{
		public function FleeButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
		}
	}
}