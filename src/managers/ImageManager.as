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
		[Embed(source = "../../lib/traffic-cones.png", 									mimeType = "image/png")] 	private static var ImgMissing:Class; 
		[Embed(source = "../../lib/sprites/navigation/buttons/iconCastle.png", 			mimeType = "image/png")] 	private static var ImgIconCastle:Class; 
		[Embed(source = "../../lib/sprites/navigation/buttons/iconScroll.png", 			mimeType = "image/png")] 	private static var ImgIconScroll:Class; 
		[Embed(source = "../../lib/sprites/navigation/buttons/iconWizard.png", 			mimeType = "image/png")] 	private static var ImgIconWizard:Class; 
		[Embed(source = "../../lib/sprites/navigation/panels/backgroundCavern.png", 	mimeType = "image/png")] 	private static var ImgBackgroundCavern:Class; 
		[Embed(source = "../../lib/sprites/navigation/panels/titleScreen.png", 			mimeType = "image/png")] 	private static var ImgTitleScreen:Class; 
		
		//accessors
		public static function Nothing():Bitmap				{ return new Bitmap(); }					//debug graphics
		public static function MissingImage():Bitmap 		{ return new ImgMissing(); }
		
		public static function BackgroundCavern():Bitmap	{ return new ImgBackgroundCavern(); } 		//background images
		public static function TitleScreen():Bitmap			{ return new ImgTitleScreen(); }
		
		public static function IconCastle():Bitmap 			{ return new ImgIconCastle(); }				//navigation icons
		public static function IconScroll():Bitmap 			{ return new ImgIconScroll(); }
		public static function IconWizard():Bitmap 			{ return new ImgIconWizard(); }
		
		
		private static var images:Object = new Array();
			images["nothing"]					= Nothing;				//debug
			images["traffic-cones.png"] 		= MissingImage;
			
			images["backgroundCavern.png"]		= BackgroundCavern;	//background images
			images["titleScreen.png"]			= TitleScreen;
			
			images["iconCastle.png"]			= IconCastle;           //navigation icons
			images["iconScroll.png"]			= IconScroll;
			images["iconWizard.png"]			= IconWizard;
			
		
		public static function getImageByName(fileName:String):Bitmap
		{
			if (images[fileName] == null) 
			{
				trace("getImageByName(" + fileName + ")...");
				trace("\t-missing bitmap.");
				return ImgMissing();
			}
			
			return (images[fileName] as Function).call();
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