//Alex Goldberger
package screen {
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import Game;
	
	public class NotificationWindow extends MovieClip {
		
		protected var manager:Game;
		private var btn_Back:SimpleButton;
		private var txt_notification:TextField;
		
		public function NotificationWindow(man:Game, notification:String) {
			// constructor code
			manager = man;
			btn_Back.addEventListener(MouseEvent.CLICK, bButton);
			txt_notification.text = notification;
		}
		
		private function bButton(event:MouseEvent):void{
			manager.removeChild(this);
		}		
	}
}