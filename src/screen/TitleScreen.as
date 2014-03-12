package screen
{
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import managers.ImageManager;
	import managers.ShapesManager;
	import gps.Mobile;
	
	import Game;
	import rpg.Player;
	import screen.MainScreen;
	
	public class TitleScreen extends Screen
	{
		//SCREEN ELEMENTS
		public var play_btn:SimpleButton;
		private var txtErrorMessage:TextField;
		private var loadingMessage:MovieClip;
		private var background:Bitmap;
		
		//CONSTRUCTORS
		public function TitleScreen(newManager:Game)
		{
			super(newManager);
			
			background = ImageManager.TitleScreen();
			
			//loadingMessage = ShapesManager.drawLabel("Loading...", -0.2, -0.2, 0.4, 0.4, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_CENTER_Y);
			//txtErrorMessage = new TextField();
		}
		
		//BUTTON FUNCTIONS
		public function addPlayButton():void
		{
			//remove our debug stuff
			Tweener.addTween(txtErrorMessage, { alpha:0.0, time:1.0, transition:"linear"} );
			Tweener.addTween(loadingMessage,  { alpha:0.0, time:1.0, transition:"linear"} );
			
			//the play button will wait for the game to tell it that everything is ready
			play_btn = ShapesManager.drawButton( -0.2, -0.21, 0.4, 0.20, "PLAY", manage.device.CurrentBiome.Type, ShapesManager.JUSTIFY_CENTER_X, ShapesManager.JUSTIFY_BOTTOM);
			play_btn.alpha = 0.0;
			
			//add the play button to the stage
			this.addChild(play_btn);
			play_btn.addEventListener(MouseEvent.CLICK, onPlay);
			
			Tweener.addTween(play_btn,  { alpha:1.0, time:1.0, delay:1.0, transition:"linear"} );
		}
		private function onPlay(e:MouseEvent):void
		{
			manage.displayScreen(CharacterSelectScreen);
		}
		
		//SCREEN FUNCTIONS
		override public function bringIn():void 
		{
			super.bringIn();
			
			//format the logo image
			//trace("Stage Dimensions:", stage.stageWidth, stage.stageHeight);
			//************** THERE IS A BUG HERE!!! FIX IT FUTURE ME! ********************
			background.width = stage.stageHeight; //stage.stageWidth;
			background.height = stage.stageWidth; //stage.stageHeight;
			this.addChild(background);
			
			//debug
			/*manage.device.txtOut = txtErrorMessage;
			manage.database.txtOut = txtErrorMessage;
			txtErrorMessage.width = Main.STAGE_RIGHT;
			txtErrorMessage.height = Main.STAGE_BOTTOM;
			
			this.addChild(loadingMessage);
			this.addChild(txtErrorMessage);*/
		}
		override public function cleanUp():void 
		{		
			//remove the connection to the mobile and database debug text
			manage.device.txtOut = null;
			manage.database.txtOut = null;
			
			//remove event listeners
			play_btn.removeEventListener(MouseEvent.CLICK, onPlay);
			
			//clean up the screen
			this.removeChild(play_btn);
			//this.removeChild(txtErrorMessage);
			//this.removeChild(loadingMessage);
			super.cleanUp();
		}
	}
}