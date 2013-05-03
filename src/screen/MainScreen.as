package screen
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.system.fscommand;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;
	import managers.ImageManager;
	import managers.ShapesManager;
	
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
		public var character_btn:MovieClip;
		public var quests_btn:MovieClip;
		public var castle_btn:MovieClip;
		
		//debug stuff
		private var lblDebugBackground:MovieClip;
		private var txtDebugMessage:TextField;
		
		private var backgroundImg:Bitmap;
		public function get GetBackground():Bitmap {return backgroundImg;}
		
		public function MainScreen(newManager:ManagerAlpha)
		{
			super(newManager);
			
			//USE SOME LOGIC TO FIGURE OUT WHICH IMAGE TO DRAW
			
			backgroundImg = new Bitmap();
			backgroundImg.x = 0;
			backgroundImg.y = 0;
			

			character_btn = new MovieClip();
			character_btn.addChild(ShapesManager.drawImage("iconWizard.png", -250, -130, 80, 130, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM));
			
			quests_btn = 	new MovieClip();
			quests_btn.addChild(ShapesManager.drawImage("iconScroll.png", -50, -100, 110, 100, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM));
			
			castle_btn = 	new MovieClip();
			castle_btn.addChild(ShapesManager.drawImage("iconCastle.png", 150, -150, 150, 150, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM));
			
			//consider drawing a loading screen for now
			lblDebugBackground = ShapesManager.drawLabel("", -100, 0, 150, 100, ShapesManager.JUSTIFY_RIGHT, ShapesManager.JUSTIFY_TOP);
			txtDebugMessage = new TextField();
			txtDebugMessage.width = 150;
			txtDebugMessage.height = 100;
			
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			
			//initialize our theme
			initWithProperBiome();
			
			//format the background image
			this.addChild(backgroundImg);
			
			//add everything to the stage
			this.addChild(encounter_btn);
			this.addChild(explore_btn);
			this.addChild(exit_btn);
			this.addChild(character_btn);
			this.addChild(quests_btn);
			this.addChild(castle_btn);
			
			//add events to the buttons
			encounter_btn.addEventListener(MouseEvent.CLICK, onEncounter);
			explore_btn.addEventListener(MouseEvent.CLICK, onExplore);
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
			character_btn.addEventListener(MouseEvent.CLICK, onCharacter);
			quests_btn.addEventListener(MouseEvent.CLICK, onQuests);
			castle_btn.addEventListener(MouseEvent.CLICK, onCastle);
			
			//attach an eventListener to the device to check when we change locations
			manage.device.addEventListener(Event.CHANGE, updateHomeTheme);
			
			
			//add some debug stuff
			this.addChild(lblDebugBackground);
			this.addChild(txtDebugMessage);
			txtDebugMessage.x = lblDebugBackground.x;
			txtDebugMessage.y = lblDebugBackground.y;
			updateHomeTheme(new Event(Event.CHANGE));
		}
		
		private function initWithProperBiome():void
		{
			trace("Current Biome Type: " + manage.device.CurrentBiome.Type);
			
			encounter_btn =	ShapesManager.drawButton(-100, -75, 200, 75, "Encounter", 	manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			explore_btn =	ShapesManager.drawButton(-100,   0, 200, 75, "Explore", 	manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			exit_btn = 		ShapesManager.drawButton(-100,  75, 200, 75, "Exit",		manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			
			if (manage.device.IsReady)
			{
				//trace("We are currently in a " + manage.device.CurrentBiome.Type + " biome");
				switch(manage.device.CurrentBiome.Type)
				{
					//initialize the background image here
					case (ShapesManager.THEME_CANYON):		backgroundImg = ImageManager.BackgroundCanyon();	break;
					case (ShapesManager.THEME_CAVERN):		backgroundImg = ImageManager.BackgroundCavern();	break;
					case (ShapesManager.THEME_DESERT):		backgroundImg = ImageManager.BackgroundDesert();	break;
					case (ShapesManager.THEME_FOREST):		backgroundImg = ImageManager.BackgroundForest();	break;
					case (ShapesManager.THEME_HILLS):		backgroundImg = ImageManager.BackgroundHills();		break;
					case (ShapesManager.THEME_MOUNTAINS): 	backgroundImg = ImageManager.BackgroundMountains();	break;
					case (ShapesManager.THEME_PLAINS): 		backgroundImg = ImageManager.BackgroundPlains();	break;
					case (ShapesManager.THEME_SAVANNAH): 	backgroundImg = ImageManager.BackgroundSavannah();	break;
					case (ShapesManager.THEME_WETLANDS): 	backgroundImg = ImageManager.BackgroundWetlands();	break;
					
					default:
						backgroundImg = ImageManager.BackgroundCavern();
						break;
				}
			}
			else {	backgroundImg = ImageManager.BackgroundCavern(); }
			
			
			backgroundImg.width = stage.stageWidth;
			backgroundImg.height = stage.stageHeight;
			
			//assign it the the manager alpha value
			manage.biomeBackground = backgroundImg;
		}
		
		private function updateHomeTheme(e:Event):void
		{
			var message:String = "";
			message += "Lat:\t" + manage.device.CurrentLatitude + "\n";
			message += "Long:\t" + manage.device.CurrentLongitude + "\n";
			message += "Type:\t" + manage.device.CurrentBiome.Type;
			txtDebugMessage.text = message;
			trace(message);
			
			//when we enter a new biome, change the background to reflect it
			initWithProperBiome();
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
			Main.exitGame();
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
			//remove everything to the stage
			/*this.removeChild(encounter_btn);
			this.removeChild(explore_btn);
			this.removeChild(exit_btn);
			this.removeChild(character_btn);
			this.removeChild(quests_btn);
			this.removeChild(castle_btn);
			*/
			//remove the event listeners from the stage
			encounter_btn.removeEventListener(MouseEvent.CLICK, onEncounter);
			explore_btn.removeEventListener(MouseEvent.CLICK, onExplore);
			exit_btn.removeEventListener(MouseEvent.CLICK, onExit);
			character_btn.removeEventListener(MouseEvent.CLICK, onCharacter);
			quests_btn.removeEventListener(MouseEvent.CLICK, onQuests);
			castle_btn.removeEventListener(MouseEvent.CLICK, onCastle);
			
			//attach an eventListener to the device to check when we change locations
			manage.device.removeEventListener(Event.CHANGE, updateHomeTheme);
			
			//make sure everything gets cleaned up
			super.cleanUp();
		}
	}
}