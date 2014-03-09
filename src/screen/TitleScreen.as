package screen
{
	import flash.display.Bitmap;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import managers.ImageManager;
	import managers.ShapesManager;
	import gps.Mobile;
	
	import Game;
	import rpg.Player;
	import screen.MainScreen;
	
	public class TitleScreen extends Screen
	{
		public var play_btn:SimpleButton;
		
		private var characterButtons:Array; //array of SimpleButtons
		//private var wizBtn:SimpleButton;
		//private var druBtn:SimpleButton;
		private var background:Bitmap;
		
		public function TitleScreen(newManager:Game)
		{
			super(newManager);
			
			background = ImageManager.TitleScreen();
			background.x = 0;
			background.y = 0;
			
			trace("Current Biome Type: " + manage.device.CurrentBiome.Type);
			play_btn = ShapesManager.drawButton(-0.2, -0.21, 0.4, 0.20, "PLAY", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
		}
		
		override public function bringIn():void 
		{
			super.bringIn();
			trace("");
			
			//format the logo image
			background.width = stage.stageWidth;
			background.height = stage.stageHeight;
			this.addChild(background);
			
			//add the play button
			this.addChild(play_btn);
			play_btn.addEventListener(MouseEvent.CLICK, onPlay);
		}
		
		private function onPlay(e:MouseEvent):void
		{
			//character select
			/*TO DO: 
			 * - IMPLEMENT MULTIPLE CHARACTERS, NOT JUST TWO
			 * - READ PLAYER INFORMATION FROM FILE AND DYNAMICALLY CHANGE BUTTONS
			 * - - CHARACTER TYPE, NAME, AND LEVEL
			 */
			
			characterButtons = new Array();
			
			
			//priest
			characterButtons.push(ShapesManager.drawButton(0.0, 0.0, 0.25, .25, null, "wizard"));
			characterButtons[0].addEventListener(MouseEvent.CLICK, choosePlayer);
			addChild(characterButtons[0]);
			
			//necromancer
			characterButtons.push(ShapesManager.drawButton(0.0, 0.0, 0.25, .25, null, "wizard"));
			characterButtons[1].addEventListener(MouseEvent.CLICK, choosePlayer);
			addChild(characterButtons[1]);
			
			//wizard
			characterButtons.push(ShapesManager.drawButton(0.0, 0.0, 0.25, .25, null, "wizard"));
			characterButtons[2].addEventListener(MouseEvent.CLICK, choosePlayer);
			addChild(characterButtons[2]);
			
			//druid
			characterButtons.push(ShapesManager.drawButton(0.5, 0.0, 0.25, .25, null, "druid"));
			characterButtons[3].addEventListener(MouseEvent.CLICK, choosePlayer);
			addChild(characterButtons[3]);
		}
		
		
		private function choosePlayer(e:MouseEvent):void
		{
			var playerChoice:int = characterButtons.indexOf(e.target);
			if (playerChoice == -1) return; //something's wrong, escape
			/*switch(e.target)
			{
				case(characterButtons[0]): playerChoice = Player.CLASS_PRIEST; break; //priest
				case(characterButtons[1]): playerChoice = Player.CLASS_NECRO;  break; //necromancer
				case(characterButtons[2]): playerChoice = Player.CLASS_WIZARD; break; //wizard
				case(characterButtons[3]): playerChoice = Player.CLASS_DRUID;  break; //druid
				default: return; break; //do nothing
			}*/
			
			//initialize the player information from the character selected
			loadPlayerStats(playerChoice);
			
			//go to the home screen
			manage.displayScreen(MainScreen);
		}
		
		private function loadPlayerStats(characterType:int):void
		{
			//open up the database or player stats and load in the player's level, health, etc.
			
			manage.player.level = 10;
			manage.displayScreen(MainScreen);
		}
		
		override public function cleanUp():void 
		{		
			//remove event listeners
			play_btn.removeEventListener(MouseEvent.CLICK, onPlay);
			for (var i:int = 0; i < characterButtons.length; i++)
			{
				characterButtons[i].removeEventListener(MouseEvent.CLICK, choosePlayer);
			}
			
			//clean up the screen
			this.removeChild(play_btn);
			super.cleanUp();
		}
	}
}