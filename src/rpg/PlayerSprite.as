package rpg
{
	import code.Weapon;
	import flash.display.Bitmap;
	
	import flash.display.Sprite;
	import managers.ImageManager;

	public class PlayerSprite extends Sprite
	{
		private var myImage:Bitmap;
		
		public function PlayerSprite(xLoc:int, yLoc:int)
		{
			//super();
			myImage = ImageManager.MissingImage();
			myImage.x = xLoc;
			myImage.y = yLoc;
			myImage.width = 50;
			myImage.height = 50;
			addChild(myImage);
		}
	}
}