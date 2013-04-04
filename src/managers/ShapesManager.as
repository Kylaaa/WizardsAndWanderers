package managers 
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Kyler
	 */
	public class ShapesManager extends Manager 
	{	
		public static const JUSTIFY_LEFT:String 	= "left";
		public static const JUSTIFY_RIGHT:String 	= "right";
		public static const JUSTIFY_TOP:String 		= "top";
		public static const JUSTIFY_BOTTOM:String 	= "bottom";
		public static const JUSTIFY_CENTER_X:String = "center_x";
		public static const JUSTIFY_CENTER_Y:String = "center_y";
		
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
				aFormat.color = 0xFFFFFF;
				aFormat.font = "Verdana";
				aFormat.size = 17;
				aFormat.align = "center";
				
			return aFormat;
		}
		
		//button stuff
		private static function buttonNormalState(w:Number, h:Number, text:String = null):MovieClip
		{
			var bns:MovieClip = new MovieClip();
				bns.graphics.beginFill ( 0x000000 );
				bns.graphics.drawRect(0, 0, w, h);
				bns.graphics.endFill();
				
			if (text != null)
				bns.addChild(drawText(text, 0, 0, w, h));
				
			return bns;
		}
		private static function buttonOverState(w:Number, h:Number, text:String = null):MovieClip
		{
			var bos:MovieClip = new MovieClip();
				bos.graphics.beginFill ( 0x00AAAA  );
				bos.graphics.drawRect(0, 0, w, h);
				bos.graphics.endFill();
				
			if (text != null)
				bos.addChild(drawText(text, 0,0, w, h));
				
			return bos;
			
		}
		private static function buttonDownState(w:Number, h:Number, text:String = null):MovieClip
		{
			var bds:MovieClip = new MovieClip();
				bds.graphics.beginFill ( 0x000000 );
				bds.graphics.drawRect(0, 0, w, h);
				bds.graphics.endFill();
				
			if (text != null)
				bds.addChild(drawText(text, 0, 0, w, h));
				
			return bds;			
		}
		
		
		//draw functions
		public static function drawButton(posX:Number, posY:Number, w:Number, h:Number, caption:String = null, xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP):SimpleButton
		{
			var aButton:SimpleButton = new SimpleButton(buttonNormalState(w, h, caption),
														buttonOverState(w, h, caption), 
														buttonDownState(w, h, caption), 
														buttonNormalState(w, h, caption));
				aButton.x = getJustifyAmount(xJustify) + posX;
				aButton.y = getJustifyAmount(yJustify) + posY;
				aButton.width = w;
				aButton.height = h;
				aButton.visible = true;
			
			return aButton;
		}
		
		public static function drawText(caption:String, posX:Number, posY:Number, w:Number, h:Number , xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP):TextField
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
				
			return someText;
			
		}
		public static function drawLabel(caption:String, posX:Number, posY:Number, w:Number, h:Number, xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP):MovieClip
		{
			var aLabel:MovieClip = new MovieClip();
				aLabel.graphics.beginFill ( 0x666666 );
				aLabel.graphics.drawRect(getJustifyAmount(xJustify) + posX, getJustifyAmount(yJustify) + posY, w, h);
				aLabel.graphics.endFill();
				
				//add the text
				aLabel.addChild(drawText(caption, getJustifyAmount(xJustify) + posX, getJustifyAmount(yJustify) + posY, w, h));
			
			return aLabel;
		}
		
		public static function drawImage(source:String, posX:Number, posY:Number, w:Number, h:Number, xJustify:String = JUSTIFY_LEFT, yJustify:String = JUSTIFY_TOP):Bitmap
		{
			var anImage:Bitmap = ImageManager.getImageByName(source);
				anImage.x = getJustifyAmount(xJustify) + posX;
				anImage.y = getJustifyAmount(yJustify) + posY;
				anImage.width = w;
				anImage.height = h;
				anImage.smoothing = true;
			//trace("\t-image drawn at (" + anImage.x + ", " + anImage.y + ")");
			
			return anImage;
		}
	}

}