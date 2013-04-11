package screen
{
	import flash.system.fscommand;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import rpg.Battle;
	import ManagerAlpha;
	
	import screen.Castle;
	import screen.Character;
	import screen.Explore;
	import screen.QuestsRecipes;
	import screen.TitleScreen;
	import code.Manager;
	import gps.mobileViewerScreen;
	
	public class MainScreen extends Screen
	{
		public var playerLoader:URLLoader = new URLLoader();
		public var db:URLRequest = new URLRequest("Player.php");
		
		public var encounter_btn:SimpleButton;
		public var explore_btn:SimpleButton;
		public var exit_btn:SimpleButton;
		public var character_btn:SimpleButton;
		public var quests_btn:SimpleButton;
		public var castle_btn:SimpleButton;
		
		public function MainScreen(newManager:ManagerAlpha)
		{
			super(newManager);
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			
			encounter_btn.addEventListener(MouseEvent.CLICK, onEncounter);
			explore_btn.addEventListener(MouseEvent.CLICK, onExplore);
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
			character_btn.addEventListener(MouseEvent.CLICK, onCharacter);
			quests_btn.addEventListener(MouseEvent.CLICK, onQuests);
			castle_btn.addEventListener(MouseEvent.CLICK, onCastle);
		}
		
		private function onEncounter(e:MouseEvent):void
		{
			if(manage.player.curHealth > 0)
				manage.displayScreen(Battle);
		}
		
		private function onExplore(e:MouseEvent):void
		{
			manage.exploring.Explore();
			manage.displayScreen(Explore);
		}
		
		private function onExit(e:MouseEvent):void
		{
			fscommand("quit");
		}
		
		private function onCharacter(e:MouseEvent):void
		{
			manage.displayScreen(Manager);
		}
		
		private function onQuests(e:MouseEvent):void
		{
			manage.displayScreen(QuestsRecipes);
		}
		
		private function onCastle(e:MouseEvent):void
		{
			manage.displayScreen(mobileViewerScreen);
		}
		
		public override function cleanUp():void
		{
			encounter_btn.removeEventListener(MouseEvent.CLICK, onEncounter);
			explore_btn.removeEventListener(MouseEvent.CLICK, onExplore);
			exit_btn.removeEventListener(MouseEvent.CLICK, onExit);
			character_btn.removeEventListener(MouseEvent.CLICK, onCharacter);
			quests_btn.removeEventListener(MouseEvent.CLICK, onQuests);
			castle_btn.removeEventListener(MouseEvent.CLICK, onCastle);
			
			super.cleanUp();
		}
	}
}