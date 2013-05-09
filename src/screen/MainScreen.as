package screen
{
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.events.GeolocationEvent;
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
	
	import screen.CastleScreen;
	import screen.CharacterScreen;
	import screen.ExploreScreen;
	import screen.QuestsRecipes;
	import screen.TitleScreen;
	
	public class MainScreen extends Screen
	{
		//buttons
		public var encounter_btn:SimpleButton;
		public var explore_btn:SimpleButton;
		public var exit_btn:SimpleButton;
		public var character_btn:SimpleButton;
		public var quests_btn:SimpleButton;
		public var castle_btn:SimpleButton;
		
		//draw layers
		private var backgroundLayer:MovieClip;
		private var enemyLayer:MovieClip;
		private var buttonLayer:MovieClip;
		
		//debug stuff
		private var lblDebugBackground:MovieClip;
		private var txtDebugMessage:TextField;
		private var btnDebugChangeLocation:SimpleButton;
		private var btnDebugHealth:SimpleButton;
		
		private var backgroundImg:Bitmap;
		public function get GetBackground():Bitmap {return backgroundImg;}
		
		
		
		public function MainScreen(newManager:ManagerAlpha)
		{
			super(newManager);
			
			//USE SOME LOGIC TO FIGURE OUT WHICH IMAGE TO DRAW
			
			backgroundImg = new Bitmap();
			backgroundImg.x = 0;
			backgroundImg.y = 0;
			

			character_btn = ShapesManager.drawButtonFromImage( -250, -130,  80, 130, "", "iconWizard.png", ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			quests_btn = 	ShapesManager.drawButtonFromImage(  -50, -100, 110, 100, "", "iconScroll.png", ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			castle_btn = 	ShapesManager.drawButtonFromImage(  150, -150, 150, 150, "", "iconCastle.png",ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			
			encounter_btn =	ShapesManager.drawButton(-100, -75, 200, 50, "Encounter", 	manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			explore_btn =	ShapesManager.drawButton(-100,   0, 200, 50, "Explore", 	manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			exit_btn = 		ShapesManager.drawButton(-100,  75, 200, 50, "Exit",		manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			
			//consider drawing a loading screen for now
			lblDebugBackground = ShapesManager.drawLabel("", -100, 0, 150, 100, ShapesManager.JUSTIFY_RIGHT, ShapesManager.JUSTIFY_TOP);
			txtDebugMessage = new TextField();
			txtDebugMessage.width = 150;
			txtDebugMessage.height = 100;
			btnDebugChangeLocation = ShapesManager.drawButton( -150, 110, 150, 100, "Change Location", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_RIGHT, ShapesManager.JUSTIFY_TOP);
			btnDebugHealth = ShapesManager.drawButton(-150, 0, 150, 100, "Full Health", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_RIGHT, ShapesManager.JUSTIFY_TOP);
		}
		
		public override function bringIn():void
		{
			super.bringIn();
			
			backgroundLayer = new MovieClip();
			enemyLayer = new MovieClip();
			buttonLayer = new MovieClip();
			
			//add the draw layers in the proper order
			this.addChild(backgroundLayer);
			this.addChild(enemyLayer);
			this.addChild(buttonLayer);
			
			//initialize our theme
			initWithProperBiome();
			
			//add everything to the stage
			buttonLayer.addChild(character_btn);
			buttonLayer.addChild(quests_btn);
			buttonLayer.addChild(castle_btn);
			
			//add events to the buttons
			character_btn.addEventListener(MouseEvent.CLICK, onCharacter);
			quests_btn.addEventListener(MouseEvent.CLICK, onQuests);
			castle_btn.addEventListener(MouseEvent.CLICK, onCastle);
			
			//attach an eventListener to the device to check when we change locations
			manage.device.addEventListener(Event.CHANGE, updateHomeTheme);
			
			
			//add some debug stuff
			/*backgroundLayer.addChild(lblDebugBackground);
			backgroundLayer.addChild(txtDebugMessage);
			
			
			txtDebugMessage.x = lblDebugBackground.x;
			txtDebugMessage.y = lblDebugBackground.y;*/
			backgroundLayer.addChild(btnDebugChangeLocation);
			btnDebugChangeLocation.addEventListener(MouseEvent.CLICK, fireChangeLocationEvent);
			//updateHomeTheme(new Event(Event.CHANGE)); 
			backgroundLayer.addChild(btnDebugHealth);
			btnDebugHealth.addEventListener(MouseEvent.CLICK, fullHealth);
		}
		
		private function fullHealth(e:MouseEvent):void
		{
			manage.player.curHealth = manage.player.health;
		}
		
		private function initWithProperBiome():void
		{
			//fade out the background
			if (backgroundLayer.contains(backgroundImg))	{	Tweener.addTween(backgroundImg, { 	alpha: 0.0, time: 0.5, onComplete: cleanUpBackgroundImage 	} );	}
			if (buttonLayer.contains(encounter_btn)) 		{	Tweener.addTween(encounter_btn, { 	alpha: 0.0, time: 0.5, onComplete: cleanUpButtonEncounter 	} );	}
			if (buttonLayer.contains(explore_btn))			{	Tweener.addTween(explore_btn, 	{ 	alpha: 0.0, time: 0.5, onComplete: cleanUpButtonExplore   	} ); 	}
			if (buttonLayer.contains(exit_btn))				{	Tweener.addTween(exit_btn, 		{ 	alpha: 0.0, time: 0.5, onComplete: cleanUpButtonExit 		} );	}
			else
			{
				fadeInNewBiome();
			}
		}
		
		private function cleanUpBackgroundImage():void	{	backgroundLayer.removeChild(backgroundImg);	}
		private function cleanUpButtonEncounter():void	{	buttonLayer.removeChild(encounter_btn);	encounter_btn.removeEventListener(MouseEvent.CLICK, onEncounter); 						}
		private function cleanUpButtonExplore():void	{	buttonLayer.removeChild(explore_btn);	explore_btn.removeEventListener(MouseEvent.CLICK, 	onExplore); 						}
		private function cleanUpButtonExit():void		{	buttonLayer.removeChild(exit_btn);		exit_btn.removeEventListener(MouseEvent.CLICK, 		onExit);		fadeInNewBiome();	}

		private function fadeInNewBiome():void
		{
			trace("Current Biome Type: " + manage.device.CurrentBiome.Type);
			
			encounter_btn =	ShapesManager.drawButton(-100, -75, 200, 75, "Encounter", 	manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			explore_btn =	ShapesManager.drawButton(-100,   0, 200, 75, "Explore", 	manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			exit_btn = 		ShapesManager.drawButton(-100,  75, 200, 75, "Exit",		manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			
			encounter_btn.alpha = 0.0;
			explore_btn.alpha = 0.0;
			exit_btn.alpha = 0.0;
			
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
					case (ShapesManager.THEME_SWAMP):		backgroundImg = ImageManager.BackgroundSwamp();		break;
					case (ShapesManager.THEME_WETLANDS): 	backgroundImg = ImageManager.BackgroundWetlands();	break;
					
					default:
						backgroundImg = ImageManager.BackgroundCavern();
						break;
				}
			}
			else {	backgroundImg = ImageManager.BackgroundCavern(); }
			
			backgroundImg.alpha = 0.0;
			backgroundImg.width = stage.stageWidth;
			backgroundImg.height = stage.stageHeight;
			
			//assign it the the manager alpha value
			manage.biomeBackground = backgroundImg;
			
			//add stuff to the stage
			backgroundLayer.addChildAt(backgroundImg, 0);
			buttonLayer.addChild(encounter_btn);
			buttonLayer.addChild(explore_btn);
			buttonLayer.addChild(exit_btn);
			
			//fade it in nicely
			Tweener.addTween(backgroundImg, { delay: 1.0, time: 0.5, alpha:1.0 } );
			Tweener.addTween(encounter_btn, { delay: 1.0, time: 0.5, alpha:1.0 } );
			Tweener.addTween(explore_btn, 	{ delay: 1.0, time: 0.5, alpha:1.0 } );
			Tweener.addTween(exit_btn, 		{ delay: 1.0, time: 0.5, alpha:1.0 } );
			
			encounter_btn.addEventListener(MouseEvent.CLICK, onEncounter);
			explore_btn.addEventListener(MouseEvent.CLICK, onExplore);
			exit_btn.addEventListener(MouseEvent.CLICK, onExit);
		}
		
		private function updateHomeTheme(e:Event):void
		{
			trace("UPDATING HOME THEME");
			var message:String = "";
			message += "Lat:\t" + manage.device.CurrentLatitude + "\n";
			message += "Long:\t" + manage.device.CurrentLongitude + "\n";
			message += "Type:\t" + manage.device.CurrentBiome.Type + "\n";
			message += "Biome ID:\t" + manage.device.CurrentBiome.ID;
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
			//manage.exploring.Explore();
			manage.displayScreen(ExploreScreen);
		}
		
		private function onExit(e:MouseEvent):void
		{
			fscommand("quit");
			Main.exitGame();
		}
		
		private function onCharacter(e:MouseEvent):void
		{
			manage.displayScreen(CharacterScreen);
		}
		
		private function onQuests(e:MouseEvent):void
		{
			manage.displayScreen(QuestsRecipes);
		}
		
		private function onCastle(e:MouseEvent):void
		{
			manage.displayScreen(CastleScreen);
		}
		
		public override function cleanUp():void
		{
			//remove everything to the stage
			if (this.contains(backgroundLayer)) this.removeChild(backgroundLayer);
			if (this.contains(enemyLayer)) 		this.removeChild(enemyLayer);
			if (this.contains(buttonLayer)) 	this.removeChild(buttonLayer);
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
			
			//debug stuff
			btnDebugChangeLocation.removeEventListener(MouseEvent.CLICK, fireChangeLocationEvent);
			
			//make sure everything gets cleaned up
			super.cleanUp();
		}
		
		
		//debug functions
		private function fireChangeLocationEvent(e:MouseEvent):void
		{
			//make a bunch of locations
			var locations:Array = new Array();
				locations.push(new GeolocationEvent(GeolocationEvent.UPDATE, false, false, 42.994, -77.680)); //1
				locations.push(new GeolocationEvent(GeolocationEvent.UPDATE, false, false, 43.140, -77.645)); //4
				locations.push(new GeolocationEvent(GeolocationEvent.UPDATE, false, false, 43.156, -77.770)); //5
				locations.push(new GeolocationEvent(GeolocationEvent.UPDATE, false, false, 43.066, -77.700)); //6
				locations.push(new GeolocationEvent(GeolocationEvent.UPDATE, false, false, 43.012, -77.752)); //9
				locations.push(new GeolocationEvent(GeolocationEvent.UPDATE, false, false, 43.012, -77.700)); //10
				
				
			//grab a random location
			var aRndIndex:int = Math.floor(Math.random() * locations.length);
			var aNewLocation:GeolocationEvent = locations[aRndIndex] as GeolocationEvent;
			
			//send the device a new location
			manage.device.onGeoLocationUpdate(aNewLocation);
		}
	}
}