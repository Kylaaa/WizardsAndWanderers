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
		private var theGame:ManagerAlpha;
		
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			stage.addEventListener(Event.RESIZE, updateStageDimensions);
			updateStageDimensions();
			
			// entry point
			theGame = new ManagerAlpha();
			this.addChild(theGame);
			//theGame.startUp(); //this gets called internally
		}
		
		private function updateStageDimensions(e:Event = null):void
		{
			STAGE_CENTER_X 	= stage.stageWidth / 2;
			STAGE_CENTER_Y	= stage.stageHeight / 2;
			STAGE_RIGHT 	= stage.stageWidth;
			STAGE_BOTTOM 	= stage.stageHeight;
		}
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			//NativeApplication.nativeApplication.exit();
			theGame.device.closeAllConnections(e);
		}
		
		public static function exitGame():void
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}