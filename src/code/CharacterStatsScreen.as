package code
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import ManagerAlpha;

	public class CharacterStatsScreen extends MovieClip
	{

		protected var manager:ManagerAlpha;

		public function CharacterStatsScreen(man:ManagerAlpha)
		{
			// constructor code
			manager = man;
			txt_stats.text = manager.player.SummaryString();
			btn_Back_Character.addEventListener(MouseEvent.CLICK, bButton);
		}

		function bButton(event:MouseEvent):void
		{
			manager.removeChild(this);
		}
	}

}