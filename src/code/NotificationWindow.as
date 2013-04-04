//Alex Goldberger
package code {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import rpg.ManagerAlpha;
	
	public class NotificationWindow extends MovieClip {
		
		protected var manager:ManagerAlpha;
		
		public function NotificationWindow(man:ManagerAlpha, notification:String) {
			// constructor code
			manager = man;
			btn_Back.addEventListener(MouseEvent.CLICK, bButton);
			txt_notification.text = notification;
		}
		
		function bButton(event:MouseEvent):void{
			manager.removeChild(this);
		}		
	}
}