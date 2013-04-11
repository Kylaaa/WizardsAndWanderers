package code
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import ManagerAlpha;

	public class CharacterStatsScreen extends MovieClip
	{

		protected var manager:ManagerAlpha;

		private var txt_stats:TextField;
		private var btn_Back_Character:TextField;
		
		public function CharacterStatsScreen(man:ManagerAlpha)
		{
			// constructor code
			manager = man;
			txt_stats.text = manager.player.SummaryString();
			btn_Back_Character.addEventListener(MouseEvent.CLICK, bButton);
		}

		private function bButton(event:MouseEvent):void
		{
			manager.removeChild(this);
		}
	}

}