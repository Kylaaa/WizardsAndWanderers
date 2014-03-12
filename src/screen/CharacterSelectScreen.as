package screen 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import managers.ImageManager;
	import managers.ShapesManager;
	import rpg.Player;
	/**
	 * ...
	 * @author Kyler
	 */
	public class CharacterSelectScreen extends Screen 
	{
		
		private var characterButtons:Array; //array of SimpleButtons
		private var btnCreateCharacter:SimpleButton;
		private var background:Bitmap;
		
		//scroll variables
		private var scrollPanel:MovieClip;
		private var isScrolling:Boolean;
		private var previousY:int;
		
		//CONSTRUCTOR
		public function CharacterSelectScreen(newManager:Game) 
		{
			super(newManager);
			
			//character select
			/*TO DO: 
			 * - IMPLEMENT MULTIPLE CHARACTERS, NOT JUST TWO
			 * - READ PLAYER INFORMATION FROM FILE AND DYNAMICALLY CHANGE BUTTONS
			 * - - CHARACTER TYPE, NAME, AND LEVEL
			 */
			
			background = ImageManager.TitleScreen();
			 
			//make a container that can scroll 
			isScrolling = false;
			scrollPanel = new MovieClip();
			scrollPanel.x = 0;
			scrollPanel.y = 0;
			previousY = 0;
			
			//build the character buttons from our loaded character XML
			characterButtons = new Array();
			for (var i:int = 0; i < manage.allPlayers.length; i++)
			{
				characterButtons.push(makeButton(0.1 + (i * 0.4), manage.allPlayers[i]));
			}
			
			//make a button for creating new characters
			i = manage.allPlayers.length;
			btnCreateCharacter = makeButton(0.1 + (i * 0.4), null);
		}
		
		//BUTTON FUNCTIONS
		private function makeButton(btnY:Number, character:Player = null):SimpleButton
		{
			//make movie clips for the 3 stages of the button
			var w:Number = .8 * Main.STAGE_RIGHT;
			var h:Number = .3 * Main.STAGE_BOTTOM;
			var bns:MovieClip = new MovieClip(); //button normal state
				bns.graphics.beginFill ( 0xAA5511 );
				bns.graphics.drawRect(0, 0, w, h);
				bns.graphics.endFill();
			var bds:MovieClip = new MovieClip(); //button down state
				bds.graphics.beginFill ( 0x003388 );
				bds.graphics.drawRect(0, 0, w, h);
				bds.graphics.endFill();
					
			var text:String;
			if (character != null)
			{
				//draw the character
				var characterImage:MovieClip = character.sprite;
					characterImage.x = 10;
					characterImage.y = 10;
					characterImage.height = bns.height;
					characterImage.scaleX = characterImage.scaleY;
				
				//make a nice caption
				text = character.name + "\n";
				text += "The Level " + character.level + " " + character.characterClass + "\n";
				text += "Tap To Play!";
			}
			else
			{
				text = "\nCreate New Character";
			}
			
			//make a caption for our button
			var caption:TextField = new TextField();
				caption.setTextFormat(ShapesManager.textFormat_Button);
				caption.x = bns.width * 0.5;
				caption.y = 0;
				caption.width = bns.width * 0.45;
				caption.height = bns.height;
				caption.text = text;
			
			//add all the elements to the different buttons
			bds.addChild(caption);
			bns.addChild(caption);
			if (character != null)
			{
				bds.addChild(characterImage);
				bns.addChild(characterImage);
			}
			//make the button
			var aButton:SimpleButton = new SimpleButton(bns, bns, bds, bns);
			aButton.x = 0.1 * Main.STAGE_RIGHT;
			aButton.y = btnY * Main.STAGE_BOTTOM;
			
			
			return aButton;
		}
		private function choosePlayer(e:MouseEvent):void
		{
			var playerChoice:int = characterButtons.indexOf(e.target);
			if (playerChoice == -1 || playerChoice >= manage.allPlayers.length) 
				return; //something's wrong, escape
			
			//initialize the player information from the character selected
			manage.player = manage.allPlayers[playerChoice];
			manage.player.selectCharacter();
			
			//go to the home screen
			manage.displayScreen(MainScreen);
		}
		private function createPlayer(e:MouseEvent):void
		{
			var message:String = "This will work one day";
			trace(message);
			
			
			//make a character creation screen
			//-add the new character to the manage.allPlayers array
			//-assign the new character to the manage.player variable
			//-call the manage.player.selectCharacter();
			
			//call the makeButton function for the new character
			//move the createCharacter button down
			
			//goto the main screen
		}
		
		//MOUSE / TOUCH FUNCTIONS
		private function beginScroll(e:MouseEvent):void
		{
			isScrolling = true;
			previousY = e.stageY;
		}
		private function scroll(e:MouseEvent):void
		{
			if (!isScrolling) return;
			
			//attempt to scroll the panel
			var differenceY = previousY - e.stageY;
			//if ((scrollPanel.y + scrollPanel.height - differenceY >= Main.STAGE_BOTTOM) && (scrollPanel.y + differenceY < 10))
			//{
				scrollPanel.y -= differenceY;
				previousY = e.stageY;
			//}
		}
		private function endScroll(e:MouseEvent):void
		{
			isScrolling = false;
		}
		
		//SCREEN FUNCTIONS
		override public function bringIn():void 
		{
			super.bringIn();
			background.width = Main.STAGE_RIGHT;
			background.height = Main.STAGE_BOTTOM;
			addChild(background);
			
			//add the scrollPanel to the screen
			addChild(scrollPanel);
			scrollPanel.addEventListener(MouseEvent.MOUSE_DOWN, beginScroll);
			scrollPanel.addEventListener(MouseEvent.MOUSE_OVER, scroll)
			scrollPanel.addEventListener(MouseEvent.MOUSE_UP, 	endScroll);
			
			//add additional event listeners to ensure scrolling
			background.addEventListener(MouseEvent.MOUSE_DOWN, beginScroll);
			background.addEventListener(MouseEvent.MOUSE_MOVE, scroll);
			background.addEventListener(MouseEvent.MOUSE_UP, 	endScroll);
			
			//add the character buttons
			for (var i:int = 0; i < characterButtons.length; i++)
			{
				scrollPanel.addChild(characterButtons[i]);
				characterButtons[i].addEventListener(MouseEvent.CLICK, choosePlayer);
			}
			
			//add the create character button
			//scrollPanel.addChild(btnCreateCharacter);
			//btnCreateCharacter.addEventListener(MouseEvent.CLICK, createPlayer);
		}
		override public function cleanUp():void 
		{	
			//remove event listeners
			background.removeEventListener(MouseEvent.MOUSE_DOWN, beginScroll);
			background.removeEventListener(MouseEvent.MOUSE_MOVE, 	scroll);
			background.removeEventListener(MouseEvent.MOUSE_UP, 	endScroll);
			scrollPanel.removeEventListener(MouseEvent.MOUSE_DOWN, 	beginScroll);
			scrollPanel.removeEventListener(MouseEvent.MOUSE_OVER, 	scroll)
			scrollPanel.removeEventListener(MouseEvent.MOUSE_UP, 	endScroll);
			
			//remove all the buttons
			for (var i:int = 0; i < characterButtons.length - 1; i++)
			{
				characterButtons[i].removeEventListener(MouseEvent.CLICK, choosePlayer);
				scrollPanel.removeChild(characterButtons[i]);
			}

			//btnCreateCharacter.removeEventListner(MouseEvent.CLICK, createPlayer);
			//scrollPanel.removeChild(btnCreateCharacter);
			
			removeChild(scrollPanel);
			super.cleanUp();
		}
	}

}