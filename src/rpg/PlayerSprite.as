package rpg
{
	import code.Weapon;
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	import managers.ImageManager;
	import managers.ShapesManager;
	
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class PlayerSprite extends Sprite
	{
		private var myImage:Bitmap;
		
		public var txt_health:TextField;
		
		public function PlayerSprite(playerLevel:int, xLoc:int, yLoc:int)
		{
			//super();
			if (playerLevel == 1)
			{
				myImage = ImageManager.WizardBody1();
			}
			else
			{
				myImage = ImageManager.DruidBody1();
			}
			
			myImage.x = xLoc;
			myImage.y = yLoc;
			myImage.width = 150;
			myImage.height = 150;
			addChild(myImage);
			
			var textStyle:TextFormat = new TextFormat(null, 24, 0xFF0000, null, null, null, null, null, "center");
			txt_health = new TextField();
			txt_health.defaultTextFormat = textStyle;
			txt_health.background = true;
			txt_health.backgroundColor = 0xFFFFFF;
			txt_health.border = true;
			txt_health.borderColor = 000000;
			txt_health.width = 50;
			txt_health.height = 25;
			txt_health.x = xLoc + txt_health.width - 10;
			txt_health.y = yLoc - 20;
			txt_health.setTextFormat(ShapesManager.textFormat);
			txt_health.setTextFormat(textStyle);
			addChild(txt_health);
		}
		
		public function changeHealth(newHealth:int):void
		{
			txt_health.text = newHealth.toString();
		}
	}
}