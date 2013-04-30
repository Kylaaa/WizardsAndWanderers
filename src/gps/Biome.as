﻿package gps 
{
	import flash.display.Bitmap;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import gps.Enemy;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Stage;
	import flash.filesystem.File;
	import flash.events.ErrorEvent;
	import managers.ImageManager;
	import managers.ShapesManager;
	
	
	//A WRAPPER OBJECT TO HOLD INFORMATION ABOUT:
	//	-WHAT BIOME YOU ARE IN
	//	-WHAT ENEMIES YOU CAN EXPECT TO FIGHT
	//	-BOSSES
	
	public class Biome extends Object
	{
		private var biomeType:String;
		private var biomeID:String;
		private var enemies:Array;
		
		private const LIBRARY_PATH:String = "lib/sprites/";

		public function Biome(id:String, type:String, listOfEnemies:Array) 
		{
			// constructor code
			biomeID = id;
			biomeType = type;
			enemies = listOfEnemies;
		}

		//accessors
		public function get Type():String { return biomeType; }
		public function get Enemies():Array { return enemies; }
		public function get ID():String { return biomeID; }
		//public function get EnemyAt(index:int):Enemy { return enemies[index] as Enemy; }



		//debug stuff
		public function drawEnemy(aStage:Stage, index:int, inX:int, inY:int):void
		{
			//THERE IS A KNOWN ISSUE HERE WHEN AN IMAGE DRAW IS ATTEMPTED AND THE URL DOES NOT EXIST
			//IT THROWS IOERROREVENT ERROR #2035: URL NOT FOUND
			//CATCHING THIS ERROR HAS PROVEN DIFFICULT
			
			trace("Drawing an enemy to the stage");
			if (index < 0 || index >= enemies.length) { trace("\t-error with index input, exiting."); return; }				
			
			//intantiate a few variables
			//var imageLoader:Loader = new Loader();
			//imageLoader.addEventListener(ErrorEvent.ERROR, errorLoading);
			//trace("\t-the library path:\t" + LIBRARY_PATH);
			
			//set the position
			//imageLoader.x = inX;
			//imageLoader.y = inY;
			
			//load the image and add it to the stage
			//if (File(enemies[index]["imagePath"].toString()).exists)
			//{
			//var imagePathURL:URLRequest = new URLRequest();
			//	imagePathURL.url = LIBRARY_PATH + enemies[index]["imagePath"].toString();
			//	trace("\t-imagePath:\t\t" + imagePathURL.url.toString());
			//	imageLoader.load(imagePathURL);
			//	
			//	aStage.addChild(imageLoader);
			//}
			//else
			//{
			//	trace("image file does not exist at url: " + enemies[index]["imagePath"].toString());
			//}
			var enemyMC:MovieClip = new MovieClip();
			var anImage:Bitmap = ImageManager.getImageByName(enemies[index]["imagePath"].toString());
				anImage.x = 0;
				anImage.y = 0;
			enemyMC.addChild(anImage);
			enemyMC.x = inX;
			enemyMC.y = inY;
			
			aStage.addChild(enemyMC);
		}
		
		//ERROR EVENTS
		private function errorLoading(e:ErrorEvent):void
		{
			trace("Something went wrong so we caught it here:");
			trace(e.toString());
		}
		private function printError(e:IOErrorEvent):void
		{
			trace("something went wrong trying to load our enemy images:");
			trace(e.toString());
		}
		
	}
	
	
}
