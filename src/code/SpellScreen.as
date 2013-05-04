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
		
		private var exit:SimpleButton;
		
		private var spellOne:SimpleButton;
		private var spellTwo:SimpleButton;
		private var spellThree:SimpleButton;
		
		public function SpellScreen(baMa:Battle)
		{
			// constructor code
			bMan = baMa;
			
			if (bMan.manage.player.level == 1)
			{
				spellOne = ShapesManager.drawButton(bMan.manage.stage.stageWidth / 2 - 100,   150, 200, 100, "Arcane Missles - 3h", "spell");
				spellOne.addEventListener(MouseEvent.CLICK, spellDemoButton14);
				this.addChild(spellOne);
				
				exit = ShapesManager.drawButton(bMan.manage.stage.stageWidth / 2 - 100,   150, 200, 100, null, "exit");
				this.addChild(exit);
			}
			else
			{
				spellOne = ShapesManager.drawButton(bMan.manage.stage.stageWidth / 2 - 205,   75, 200, 100, "Fury of the Wild - 3h", "spell");
				spellTwo = ShapesManager.drawButton(bMan.manage.stage.stageWidth / 2 + 5,   75, 200, 100, "Nature's Grasp - 3h", "spell");
				spellThree = ShapesManager.drawButton(bMan.manage.stage.stageWidth / 2 - 100,   175, 200, 100, "Rampant Vines - D", "spell");
				
				spellOne.addEventListener(MouseEvent.CLICK, spellDemoButton14);
				spellTwo.addEventListener(MouseEvent.CLICK, spellDemoButton15);
				spellThree.addEventListener(MouseEvent.CLICK, spellDemoButton16);
				
				exit = ShapesManager.drawButton(bMan.manage.stage.stageWidth / 2 + 210,   70, 50, 50, null, "exit");
				this.addChild(exit);
				
				this.addChild(spellOne);
				this.addChild(spellTwo);
				this.addChild(spellThree);
			}
			
			exit.addEventListener(MouseEvent.CLICK, quit);
		}
		
		private function quit(event:MouseEvent):void
		{
			bMan.removeChild(this);
		}
		
		private function spellDemoButton14(event:MouseEvent):void
		{
			if (bMan.manage.spellOne)
			{
				if (bMan.manage.player.level == 1)
				{
					bMan.spellAtk(1);
				}
				else
				{
					bMan.spellAtk(16);
				}
				
				bMan.manage.spellOne = false;
				bMan.manage.threeHourSpellOne.start();
				
				bMan.casting = true;
				bMan.removeChild(this);
			}
		}
		private function spellDemoButton15(event:MouseEvent):void
		{
			if (bMan.manage.spellTwo)
			{
				bMan.spellAtk(17);
				bMan.removeChild(this);
				
				bMan.manage.spellTwo = false;
				bMan.manage.threeHourSpellTwo.start();
				
				bMan.casting = true;
			}
		}
		
		private function spellDemoButton16(event:MouseEvent):void
		{
			if (bMan.manage.spellDaily)
			{
				bMan.spellAtk(18);
				bMan.removeChild(this);
				
				bMan.manage.spellDaily = false;
				bMan.manage.dailySpell.start();
				
				bMan.casting = true;
			}
		}
		
		
	}

}