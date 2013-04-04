package code
{

	import flash.display.MovieClip;
	import rpg.Battle;
	import flash.events.MouseEvent;	

	public class SpellScreen extends MovieClip
	{

		private var bMan:Battle;
		public function SpellScreen(baMa:Battle)
		{
			// constructor code
			bMan = baMa;
			btn_cC.addEventListener(MouseEvent.CLICK, spellDemoButton15);
			btn_lS.addEventListener(MouseEvent.CLICK, spellDemoButton14);
		}

		function spellDemoButton15(event:MouseEvent):void
		{
			bMan.spellAtk(15);
			bMan.removeChild(this);
		}
		function spellDemoButton14(event:MouseEvent):void
		{
			bMan.spellAtk(14);
			bMan.removeChild(this);
		}
	}

}