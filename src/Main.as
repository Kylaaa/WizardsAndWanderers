package 
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	/**
	 * ...
	 * @author Alex, Connor, Kyler, and Mark
	 */
	public class Main extends Sprite 
	{
		//CONSTANTS
		public static var STAGE_CENTER_X:int = 381;
		public static var STAGE_CENTER_Y:int = 240;
		public static var STAGE_LEFT:int = 0;
		public static var STAGE_RIGHT:int = 762;
		public static var STAGE_TOP:int = 0;
		public static var STAGE_BOTTOM:int = 480;
		
		
		//GLOBAL VARIABLES
		private var theGame:Game;
		
		public function Main():void 
		{
			//initialize stage variables
			stage.scaleMode = StageScaleMode.NO_SCALE; //This one line has given me more of a head-ache than I care to say. ~Kyler
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			stage.addEventListener(Event.RESIZE, updateStageDimensions);
			updateStageDimensions();
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			theGame = new Game();
			this.addChild(theGame);
			//theGame.startUp(); //this gets called internally
		}
		
		//EVENT DRIVEN FUNCTIONS
		private function updateStageDimensions(e:Event = null):void
		{
			//when the stage is resized, change a few reference points
			STAGE_CENTER_X 	= stage.stageWidth / 2;
			STAGE_CENTER_Y	= stage.stageHeight / 2;
			STAGE_RIGHT 	= stage.stageWidth;
			STAGE_BOTTOM 	= stage.stageHeight;
		}	
		private function deactivate(e:Event):void 
		{
			// should the app go into the background, start to close things down
			if (theGame.device.IsReady)
				theGame.device.closeAllConnections(e);
			theGame.saveProgress();
			//NativeApplication.nativeApplication.exit();
		}		
		
		//HELPER FUNCTIONS
		public static function getCurrentTimeValue():Number
		{
			//it would be better to use the Julian Date instead of calculating the date, oh well
			var curDateTime:Date = new Date(); //get the current time
			var curTime:Number = (curDateTime.getMonth() * 30 * 24) + 
								 (curDateTime.getDate() * 24) +
								 (curDateTime.getHours());
			return curTime;
		}
		public static function exitGame():void
		{
			NativeApplication.nativeApplication.exit();
		}
	}
	
}