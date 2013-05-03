package code
{

	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import managers.ShapesManager;
	import rpg.Battle;
	import flash.events.MouseEvent;	

	public class SpellScreen extends MovieClip
	{
		private var bMan:Battle;
		private var btn_cC:SimpleButton;
		private var btn_lS:SimpleButton;
		
		public function SpellScreen(baMa:Battle)
		{
			// constructor code
			bMan = baMa;
			
			btn_cC = ShapesManager.drawButton(0,   0, 200, 100, "Creeping Cold");
			btn_lS = ShapesManager.drawButton(0, 100, 200, 100, "Lightning Strike");
			
			this.addChild(btn_cC);
			this.addChild(btn_lS);
			
			btn_cC.addEventListener(MouseEvent.CLICK, spellDemoButton15);
			btn_lS.addEventListener(MouseEvent.CLICK, spellDemoButton14);
		}
		
		private function spellDemoButton15(event:MouseEvent):void
		{
			bMan.spellAtk(15);
			bMan.removeChild(this);
		}
		private function spellDemoButton14(event:MouseEvent):void
		{
			bMan.spellAtk(14);
			bMan.removeChild(this);
		}
	}

}