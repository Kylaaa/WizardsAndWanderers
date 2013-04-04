package managers 
{
	import flash.display.Bitmap;
	/**
	 * a library class to deal with images
	 * 
	 * the majority of this class is static so that it can be referenced anywhere within the 
	 *  project without having to initialize a manager object
	 * 
	 * @author Kyler Mulherin
	 */
	
	 
	public class ImageManager extends Manager 
	{
		//IMAGE FILES ARE EMBEDDED AT COMPILE TIME, NOT AT RUN-TIME
		[Embed(source = "../../lib/traffic-cones.png", 			mimeType = "image/png")] 	private static var ImgMissing:Class; 
		
		
		//accessors
		public static function Nothing():Bitmap				{ return new Bitmap(); }					//debug graphics
		public static function MissingImage():Bitmap 		{ return new ImgMissing(); }
		
		
		
		private static var images:Object = new Array();
			images["nothing"]					= Nothing();				//debug
			images["traffic-cones.png"] 		= MissingImage();
			
			
		
		public static function getImageByName(fileName:String):Bitmap
		{
			if (images[fileName] == null) 
			{
				trace("getImageByName(" + fileName + ")...");
				trace("\t-missing bitmap.");
				return ImgMissing();
			}
			
			return images[fileName];
		}
			
		public function ImageManager() 
		{
			
		}
		
		
		override public function cleanUp():void 
		{
			//super.cleanUp();
		}

		
		
		
	}

}