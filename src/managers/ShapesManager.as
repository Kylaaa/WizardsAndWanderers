package managers 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.system.Capabilities;
	import flash.text.Font;
	import flash.text.FontType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Kyler
	 */
	public class ShapesManager extends Manager 
	{	
		[Embed(source = '../../lib/fonts/pixelton.ttf', fontName="Pixelton", fontWeight="normal", advancedAntiAliasing="true", mimeType = "application/x-font")] private static var FontPixelton:Class;
		
		
		public static const JUSTIFY_LEFT:String 	= "left";
		public static const JUSTIFY_RIGHT:String 	= "right";
		public static const JUSTIFY_TOP:String 		= "top";
		public static const JUSTIFY_BOTTOM:String 	= "bottom";
		public static const JUSTIFY_CENTER_X:String = "center_x";
		public static const JUSTIFY_CENTER_Y:String = "center_y";
		
		public static const THEME_CANYON:String 	= "Canyon";
		public static const THEME_CAVERN:String 	= "Cave";
		public static const THEME_DESERT:String 	= "Desert";
		public static const THEME_FOREST:String 	= "Forest";
		public static const THEME_HILLS:String 		= "Hills";
		public static const THEME_MOUNTAINS:String 	= "Mountains";
		public static const THEME_PLAINS:String 	= "Plains";
		public static const THEME_SAVANNAH:String 	= "Savanna";
		public static const THEME_SWAMP:String   	= "Swamp";
		public static const THEME_WETLANDS:String 	= "Wetlands";
		
		public function ShapesManager() 
		{
			
		}
		
		//positioning stuff
		private static function getJustifyAmount(type:String):Number
		{
			switch (type)
			{
				case (JUSTIFY_CENTER_X): 	return Main.STAGE_CENTER_X;	break;
				case (JUSTIFY_CENTER_Y): 	return Main.STAGE_CENTER_Y; break;
				case (JUSTIFY_RIGHT): 		return Main.STAGE_RIGHT; 	break;
				case (JUSTIFY_BOTTOM): 		return Main.STAGE_BOTTOM; 	break;
				case (JUSTIFY_LEFT): 		return Main.STAGE_LEFT; 	break; //this returns 0
				case (JUSTIFY_TOP): 		return Main.STAGE_TOP;	 	break; //this returns 0
				//default:					return 0;
			}
			
			return 0;
		}
		
		
		//style stuff
		public static function get textFormat():TextFormat
		{
			var aFormat:TextFormat = new TextFormat();
				aFormat.size = 28;
				aFormat.color = 0x333333;
				aFormat.align = "center";
				aFormat.font = "Pixelton";
				//aFormat.bold = true;
				
			return aFormat;
		}
		public static function get textFormat_Button():TextFormat
		{
			var aFormat:TextFormat = new TextFormat();
				aFormat.size = 32;
				aFormat.color = 0x000000;// 0xFFCC00;
				aFormat.align = "center";
				aFormat.font = "Pixelton";
				//aFormat.bold = true;
				
			return aFormat;
		}
		
		
		//button stuff
		private static function buttonNormalState(w:Number, h:Number, text:String = null, theme:String = THEME_CAVERN):MovieClip
		{
			var bns:MovieClip = new MovieClip();
			/*	bns.graphics.beginFill ( 0x000000 );
				bns.graphics.drawRect(0, 0, w, h);
				bns.graphics.endFill();*/
			
			var backgroundImage:Bitmap;
			switch (theme)
			{
				case (THEME_CANYON):	backgroundImage = ImageManager.LargeButtonCanyon();		break;
				case (THEME_CAVERN):	backgroundImage = ImageManager.LargeButtonCavern();		break;
				case (THEME_DESERT):	backgroundImage = ImageManager.LargeButtonDesert();		break;
				case (THEME_FOREST):	backgroundImage = ImageManager.LargeButtonForest();		break;
				case (THEME_HILLS):		backgroundImage = ImageManager.LargeButtonHills();		break;
				case (THEME_MOUNTAINS):	backgroundImage = ImageManager.LargeButtonMountains();	break;
				case (THEME_PLAINS):	backgroundImage = ImageManager.LargeButtonPlains();		break;
				case (THEME_SAVANNAH):	backgroundImage = ImageManager.LargeButtonSavannah();	break;
				case (THEME_SWAMP):		backgroundImage = ImageManager.LargeButtonSwamp();		break;
				case (THEME_WETLANDS):	backgroundImage = ImageManager.LargeButtonWetlands();	break;
				case ("exit"):			backgroundImage = ImageManager.IconExit();				break;
				default:				backgroundImage = ImageManager.CharacterEssencePanel();	break;
			}
				backgroundImage.x = 0;
				backgroundImage.y = 0;
				backgroundImage.width = w;
				backgroundImage.height = h;
			
			bns.addChild(backgroundImage);
			
			if (text != null)
			{
				var margin:int = 3;
				var tf:TextField = drawText(text, margin, margin, w - (2 * margin), h - (2 * margin));
				
				var tff:TextFormat = textFormat_Button;
				if (text.length > 10) {	tff.size = 12; }
				if (text.length > 20) { tff.size = 6; }
				
				tf.setTextFormat(textFormat_Button);
				verticalAlignTextField(tf);
				bns.addChild(tf);
			}
				
			return bns;
		}
		private static function buttonOverState(w:Number, h:Number, text:String = null, theme:String = THEME_CAVERN):MovieClip
		{
			var bos:MovieClip = new MovieClip();
				bos.graphics.beginFill ( 0x00AAAA  );
				bos.graphics.drawRect(0, 0, w, h);
				bos.graphics.endFill();
				
			var backgroundImage:Bitmap;
			switch (theme)
			{
				case (THEME_CANYON):	backgroundImage = ImageManager.LargeButtonCanyon();		break;
				case (THEME_CAVERN):	backgroundImage = ImageManager.LargeButtonCavern();		break;
				case (THEME_DESERT):	backgroundImage = ImageManager.LargeButtonDesert();		break;
				case (THEME_FOREST):	backgroundImage = ImageManager.LargeButtonForest();		break;
				case (THEME_HILLS):		backgroundImage = ImageManager.LargeButtonHills();		break;
				case (THEME_MOUNTAINS):	backgroundImage = ImageManager.LargeButtonMountains();	break;
				case (THEME_PLAINS):	backgroundImage = ImageManager.LargeButtonPlains();		break;
				case (THEME_SAVANNAH):	backgroundImage = ImageManager.LargeButtonSavannah();	break;
				case (THEME_SWAMP):		backgroundImage = ImageManager.LargeButtonSwamp();		break;
				case (THEME_WETLANDS):	backgroundImage = ImageManager.LargeButtonWetlands();	break;
				case ("exit"):			backgroundImage = ImageManager.IconExit();				break;
				default:				backgroundImage = ImageManager.CharacterEssencePanel();	break;
			}
				backgroundImage.x = 0;
				backgroundImage.y = 0;
				backgroundImage.width = w;
				backgroundImage.height = h;
			bos.addChild(backgroundImage);
				
			if (text != null)
			{
				var margin:int = 3;
				var tf:TextField = drawText(text, margin, margin, w - (2 * margin), h - (2 * margin));
				
				var tff:TextFormat = textFormat_Button;
				if (text.length > 10) {	tff.size = 28; }
				if (text.length > 20) { tff.size = 24; }
				
				tf.setTextFormat(textFormat_Button);
				verticalAlignTextField(tf);
				bos.addChild(tf);
			}
				
			return bos;
			
		}
		private static function buttonDownState(w:Number, h:Number, text:String = null, theme:String = THEME_CAVERN):MovieClip
		{
			var bds:MovieClip = new MovieClip();
			var shading:MovieClip = new MovieClip();
				shading.graphics.beginFill ( 0x000000, 0.25 );
				shading.graphics.drawRect(0, 0, w, h);
				shading.graphics.endFill();
				
			var backgroundImage:Bitmap;
			switch (theme)
			{
				case (THEME_CANYON):	backgroundImage = ImageManager.LargeButtonCanyon();		break;
				case (THEME_CAVERN):	backgroundImage = ImageManager.LargeButtonCavern();		break;
				case (THEME_DESERT):	backgroundImage = ImageManager.LargeButtonDesert();		break;
				case (THEME_FOREST):	backgroundImage = ImageManager.LargeButtonForest();		break;
				case (THEME_HILLS):		backgroundImage = ImageManager.LargeButtonHills();		break;
				case (THEME_MOUNTAINS):	backgroundImage = ImageManager.LargeButtonMountains();	break;
				case (THEME_PLAINS):	backgroundImage = ImageManager.LargeButtonPlains();		break;
				case (THEME_SAVANNAH):	backgroundImage = ImageManager.LargeButtonSavannah();	break;
				case (THEME_SWAMP):		backgroundImage = ImageManager.LargeButtonSwamp();		break;
				case (THEME_WETLANDS):	backgroundImage = ImageManager.LargeButtonWetlands();	break;
				case ("exit"):			backgroundImage = ImageManager.IconExit();				break;
				default:				backgroundImage = ImageManager.CharacterEssencePanel();		break;
			}
				backgroundImage.x = 0;
				backgroundImage.y = 0;
				backgroundImage.width = w;
				backgroundImage.height = h;
			bds.addChild(backgroundImage);
			bds.addChild(shading);
			
			if (text != null)
			{
				var margin:int = 3;
				var tf:TextField = drawText(text, margin, margin, w - (2 * margin), h - (2 * margin));
				
				var tff:TextFormat = textFormat_Button;
				if (text.length > 10) {	tff.size = 12; }
				if (text.length > 20) { tff.size = 6; }
				
				tf.setTextFormat(textFormat_Button);
				verticalAlignTextField(tf);
				bds.addChild(tf);
			}
				
			return bds;			
		}
		public static function verticalAlignTextField(tf: TextField): void 
		{
			//snagged off the interwebs from:
			//http://stackoverflow.com/questions/8452331/how-to-vertical-align-a-textfield-in-as3
			tf.y += Math.round((tf.height - tf.textHeight) / 2);
		}
		
		//draw functions
		public static function drawButton(posX:Number, posY:Number, w:Number, h:Number, caption:String = null, theme:String = THEME_CAVERN, xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP):SimpleButton
		{
			var aButton:SimpleButton = new SimpleButton(buttonNormalState	(w, h, caption, theme),
														buttonOverState		(w, h, caption, theme), 
														buttonDownState		(w, h, caption, theme), 
														buttonNormalState	(w, h, caption, theme));
				aButton.x = getJustifyAmount(xJustify) + posX;
				aButton.y = getJustifyAmount(yJustify) + posY;
				aButton.width = w;
				aButton.height = h;
				aButton.visible = true;
			
			return aButton;
		}
		
		public static function drawButtonFromImage(posX:Number, posY:Number, w:Number, h:Number, caption:String = null, imageSRC:String = "traffic-cones.png", xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP):SimpleButton
		{
			//image stuff
			var theImage:Bitmap = ImageManager.getImageByName(imageSRC);
				theImage.x = 0;
				theImage.y = 0;
				theImage.width = w;
				theImage.height = h;
			var shading:MovieClip = new MovieClip();
				shading.graphics.beginFill ( 0x000000, 0.25 );
				shading.graphics.drawRect(0, 0, w, h);
				shading.graphics.endFill();
				
			//button stuff
			var normalState:MovieClip = new MovieClip();
				normalState.addChild(new Bitmap(theImage.bitmapData));
			var overState:MovieClip = new MovieClip();
				overState.addChild(new Bitmap(theImage.bitmapData));
			var hitState:MovieClip = new MovieClip();
				hitState.addChild(new Bitmap(theImage.bitmapData));
				hitState.addChild(shading);
			
			//construct the button	
			var aButton:SimpleButton = new SimpleButton(normalState, overState, hitState, normalState);
				aButton.addChild(theImage); 
				aButton.x = getJustifyAmount(xJustify) + posX;
				aButton.y = getJustifyAmount(yJustify) + posY;
				aButton.visible = true;
			
			return aButton;
		}
		public static function drawText(caption:String, posX:Number, posY:Number, w:Number, h:Number , xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP, verticalAlign:Boolean = false):TextField
		{
			var someText:TextField = new TextField();
				someText.x = getJustifyAmount(xJustify) + posX;
				someText.y = getJustifyAmount(yJustify) + posY;
				someText.width = w;
				someText.height = h;
				someText.text = caption;
				someText.wordWrap = true;
				someText.visible = true;
				someText.setTextFormat(textFormat);
			
			if (verticalAlign) verticalAlignTextField(someText);
				
			return someText;
			
		}
		public static function drawLabel(caption:String, posX:Number, posY:Number, w:Number, h:Number, xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP, verticalAlign:Boolean = false):MovieClip
		{
			var margin:int = 3;
			var border:int = 5;
			
			var aLabel:MovieClip = new MovieClip();
				aLabel.x = getJustifyAmount(xJustify) + posX;
				aLabel.y = getJustifyAmount(yJustify) + posY;
			
			//draw a border
			aLabel.graphics.beginFill ( 0xFF9900 );
			aLabel.graphics.drawRect(-border, -border, w + (2 * border), h + (2 * border));
			aLabel.graphics.endFill();
			
			//draw the nice background
			/*var imageMask:MovieClip = new MovieClip();
				//imageMask.graphics.moveTo(0, 0);
				imageMask.graphics.beginFill ( 0x111111 );
				imageMask.graphics.drawRect(0, 0, w, h);
				imageMask.graphics.endFill();
				//imageMask.x = 0;
				//imageMask.y = 0;
				imageMask.width = w;
				imageMask.height = h;
				
			var labelImage:Bitmap = ImageManager.GameBoardLight();
				labelImage.x = 0;
				labelImage.y = 0;
				//labelImage.width = w;
				//labelImage.height = h;
				labelImage.mask = imageMask; //display only a chunk of the image
			
			aLabel.addChild(imageMask);
			aLabel.addChild(labelImage);*/
				
			//add the text
			var text:TextField = drawText(caption, margin, margin, w - (2 * margin), h - (2 * margin), JUSTIFY_LEFT, JUSTIFY_TOP, verticalAlign);
			text.name = "text";
			aLabel.addChild(text);
			
			return aLabel;
		}
		
		public static function drawImage(source:String, posX:Number, posY:Number, w:Number = -1, h:Number = -1, xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP):Bitmap
		{
			var anImage:Bitmap = ImageManager.getImageByName(source);
				anImage.x = getJustifyAmount(xJustify) + posX;
				anImage.y = getJustifyAmount(yJustify) + posY;
				
				if (w != -1) anImage.width = w;
				if (h != -1) anImage.height = h;
				anImage.smoothing = true;
			//trace("\t-image drawn at (" + anImage.x + ", " + anImage.y + ")");
			
			return anImage;
		}
	}

}