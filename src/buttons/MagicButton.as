package buttons
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class MagicButton extends SimpleButton
	{
		public function MagicButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
		}
	}
}