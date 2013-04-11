package gps 
{
	
	import flash.display.MovieClip;
	import flash.data.*; //SQL statements
	import flash.filesystem.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.text.TextField;

 	//File structures
	
	public class Database extends MovieClip 
	{		
		//GLOBAL VARIABLES
		private var txtOut:TextField;
		private var tablesLoadedFromServer:int;
		
		
		//SQL stuff
		private var db_file:File;
		private var db_connection:SQLConnection;
		
		
		//SQL Statement information
		private var dbVersionDataNames:Array;		private var dbVersionDataTypes:Array;
		private var armorDataNames:Array;			private var armorDataTypes:Array;
		private var biomeTypesDataNames:Array;		private var biomeTypesDataTypes:Array;
		private var craftingDataNames:Array; 		private var craftingDataTypes:Array;
		private var enchantingDataNames:Array;		private var enchantingDataTypes:Array;
		private var enemiesDataNames:Array; 		private var enemiesDataTypes:Array;
		private var enemyTypesDataNames:Array;		private var enemyTypesDataTypes:Array;
		private var itemDataNames:Array;			private var itemDataTypes:Array;
		private var spellDataNames:Array;			private var spellDataTypes:Array;
		private var weaponDataNames:Array;			private var weaponDataTypes:Array;
		
		private var tableNames:Array;
		private var currentDBVersion:String;
		
		
		//accessors
		public function get TableNames():Array 			{ return tableNames; }
		public function get CurrentDBVersion():String 	{ return currentDBVersion; }
		public function get DB_Connection():SQLConnection { return db_connection; }
		
		public function get DBVersionDataNames():Array 	{ return dbVersionDataNames; }
		public function get ArmorDataNames():Array 		{ return armorDataNames; }
		public function get BiomeTypesDataNames():Array { return biomeTypesDataNames; }
		public function get CraftingDataNames():Array 	{ return craftingDataNames; }
		public function get EnchantingDataNames():Array	{ return enchantingDataNames; }
		public function get EnemiesDataNames():Array 	{ return enemiesDataNames; }
		public function get EnemyTypesDataNames():Array { return enemyTypesDataNames; }
		public function get ItemDataNames():Array 		{ return itemDataNames; }
		public function get SpellDataNames():Array 		{ return spellDataNames; }
		public function get WeaponDataNames():Array 	{ return weaponDataNames; }
		
		
		
		public function Database(outputTextField:TextField = null) 
		{
			if (outputTextField != null) txtOut = outputTextField;
			
			// constructor code
			writeMessage("Database Constructor...");
			
			//establish a connection to our database
			initArrays(); //initialize all of our local arrays
			initDatabase();
		}
		
		//INIT FUNCTIONS
		private function initArrays():void
		{
			//make sure this matches the gpsLib.php file
			
			tableNames = new Array();
			tableNames.push("DBVersion");
			tableNames.push("Armor");
			tableNames.push("BiomeType"); //not grabbing Biomes- too damn big
			tableNames.push("Crafting");
			tableNames.push("Enchanting");
			tableNames.push("Enemy");
			tableNames.push("EnemyType");
			tableNames.push("Item");
			tableNames.push("Spell");
			tableNames.push("Weapon"); //not grabbing player table either
			
			
			//INITIALIZE SQL DATA ARRAYS
			//database version control stuff
			dbVersionDataNames = new Array();	dbVersionDataTypes = new Array();
			dbVersionDataNames[0] = "id";		dbVersionDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			dbVersionDataNames[1] = "name";		dbVersionDataTypes[1] = "TEXT";
			dbVersionDataNames[2] = "date";		dbVersionDataTypes[2] = "TEXT";
			
			//armor table
			armorDataNames = new Array();			armorDataTypes = new Array();
			armorDataNames[0] = "id";				armorDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			armorDataNames[1] = "name"; 			armorDataTypes[1] = "TEXT";
			armorDataNames[2] = "heroType"; 		armorDataTypes[2] = "TEXT";
			armorDataNames[3] = "proficiency";		armorDataTypes[3] = "INT";
			armorDataNames[4] = "statusPrevention";	armorDataTypes[4] = "TEXT";
			armorDataNames[5] = "critChanceInc";	armorDataTypes[5] = "INT";
			armorDataNames[6] = "healthInc";		armorDataTypes[6] = "INT";
			armorDataNames[7] = "healthRegen"; 		armorDataTypes[7] = "INT";
			armorDataNames[8] = "speedIncChance"; 	armorDataTypes[8] = "INT";
			armorDataNames[9] = "dodgeIncChance"; 	armorDataTypes[9] = "INT";
			armorDataNames[10] = "weaknessType"; 	armorDataTypes[10] = "TEXT";
			armorDataNames[11] = "weaknessDamage";	armorDataTypes[11] = "INT";
			
			//biome type table
			biomeTypesDataNames = new Array(); 	biomeTypesDataTypes = new Array();
			biomeTypesDataNames[0] = "id";		biomeTypesDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			biomeTypesDataNames[1] = "name";	biomeTypesDataTypes[1] = "TEXT";
			biomeTypesDataNames[2] = "color";	biomeTypesDataTypes[2] = "TEXT";
			
			//crafting recipe table
			craftingDataNames = new Array();	craftingDataTypes = new Array();
			craftingDataNames[0] = "id";		craftingDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			craftingDataNames[1] = "name";		craftingDataTypes[1] = "TEXT";
			craftingDataNames[2] = "rarity";	craftingDataTypes[2] = "TEXT";
			craftingDataNames[3] = "fL";		craftingDataTypes[3] = "INT"; //forest
			craftingDataNames[4] = "fA";		craftingDataTypes[4] = "INT";
			craftingDataNames[5] = "fGRE";		craftingDataTypes[5] = "INT";
			craftingDataNames[6] = "fGRA";		craftingDataTypes[6] = "INT";
			craftingDataNames[7] = "wL";		craftingDataTypes[7] = "INT"; //wetland
			craftingDataNames[8] = "wA";		craftingDataTypes[8] = "INT";
			craftingDataNames[9] = "wGRE";		craftingDataTypes[9] = "INT";
			craftingDataNames[10] = "wGRA";		craftingDataTypes[10] = "INT";
			craftingDataNames[11] = "dL";		craftingDataTypes[11] = "INT";//desert
			craftingDataNames[12] = "dA";		craftingDataTypes[12] = "INT";
			craftingDataNames[13] = "dGRE";		craftingDataTypes[13] = "INT";
			craftingDataNames[14] = "dGRA";		craftingDataTypes[14] = "INT";
			craftingDataNames[15] = "mL";		craftingDataTypes[15] = "INT";//mountain
			craftingDataNames[16] = "mA";		craftingDataTypes[16] = "INT";
			craftingDataNames[17] = "mGRE";		craftingDataTypes[17] = "INT";
			craftingDataNames[18] = "mGRA";		craftingDataTypes[18] = "INT";
			craftingDataNames[19] = "gold";		craftingDataTypes[19] = "INT";
			
			//enchantment
			enchantingDataNames = new Array();			enchantingDataTypes = new Array();
			enchantingDataNames[0] = "id";				enchantingDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			enchantingDataNames[1] = "name";			enchantingDataTypes[1] = "TEXT";
			enchantingDataNames[2] = "quest";			enchantingDataTypes[2] = "INT";
			enchantingDataNames[3] = "dmgOld";			enchantingDataTypes[3] = "INT";
			enchantingDataNames[4] = "dmgNew";			enchantingDataTypes[4] = "INT";
			enchantingDataNames[5] = "hpHome";			enchantingDataTypes[5] = "INT";
			enchantingDataNames[6] = "luckHome";		enchantingDataTypes[6] = "INT";
			enchantingDataNames[7] = "speedHome";		enchantingDataTypes[7] = "INT";
			enchantingDataNames[8] = "luckForest";		enchantingDataTypes[8] = "INT";
			enchantingDataNames[9] = "speedForest";		enchantingDataTypes[9] = "INT";
			enchantingDataNames[10] = "luckDesert";		enchantingDataTypes[10] = "INT";
			enchantingDataNames[11] = "speedDesert";	enchantingDataTypes[11] = "INT";
			enchantingDataNames[12] = "luckMountain";	enchantingDataTypes[12] = "INT";
			enchantingDataNames[13] = "speedMountain";	enchantingDataTypes[13] = "INT";
			enchantingDataNames[14] = "luckWetland";	enchantingDataTypes[14] = "INT";
			enchantingDataNames[15] = "speedWetland";	enchantingDataTypes[15] = "INT";
			
			//enemy table
			enemiesDataNames = new Array();			enemiesDataTypes = new Array();
			enemiesDataNames[0] = "id";				enemiesDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			enemiesDataNames[1] = "name";			enemiesDataTypes[1] = "TEXT";
			enemiesDataNames[2] = "imagePath";		enemiesDataTypes[2] = "TEXT";
			enemiesDataNames[3] = "monsterType";	enemiesDataTypes[3] = "TEXT";
			enemiesDataNames[4] = "health";			enemiesDataTypes[4] = "INT";
			enemiesDataNames[5] = "attack";			enemiesDataTypes[5] = "INT";
			enemiesDataNames[6] = "speed";			enemiesDataTypes[6] = "INT";
			enemiesDataNames[7] = "specialAtk";		enemiesDataTypes[7] = "TEXT";
			enemiesDataNames[8] = "powers";			enemiesDataTypes[8] = "TEXT";
			enemiesDataNames[9] = "block";			enemiesDataTypes[9] = "TEXT";
			enemiesDataNames[10] = "backRowTend";	enemiesDataTypes[10] = "TEXT";
			enemiesDataNames[11] = "biomePrimary";	enemiesDataTypes[11] = "TEXT";
			enemiesDataNames[12] = "biomeSecondary";enemiesDataTypes[12] = "TEXT";
			enemiesDataNames[13] = "rarity";		enemiesDataTypes[13] = "TEXT";

			//enemy type table
			enemyTypesDataNames = new Array(); 	enemyTypesDataTypes = new Array();
			enemyTypesDataNames[0] = "id";		enemyTypesDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			enemyTypesDataNames[1] = "name";	enemyTypesDataTypes[1] = "TEXT";
						
			//item table
			itemDataNames = new Array();		itemDataTypes = new Array();
			itemDataNames[0] = "id";			itemDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			itemDataNames[1] = "name";			itemDataTypes[1] = "TEXT";
			itemDataNames[2] = "imagePath";		itemDataTypes[2] = "TEXT";
			
			//spells
			spellDataNames = new Array();			spellDataTypes = new Array();
			spellDataNames[0] = "id";				spellDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL";
			spellDataNames[1] = "name";				spellDataTypes[1] = "TEXT";
			spellDataNames[2] = "description";		spellDataTypes[2] = "TEXT";
			spellDataNames[3] = "heroType";			spellDataTypes[3] = "TEXT";
			spellDataNames[4] = "tier";				spellDataTypes[4] = "INT";
			spellDataNames[5] = "magicType";		spellDataTypes[5] = "TEXT";
			spellDataNames[6] = "spellType";		spellDataTypes[6] = "TEXT";
			spellDataNames[7] = "damage";			spellDataTypes[7] = "INT";
			spellDataNames[8] = "category";			spellDataTypes[8] = "TEXT";
			spellDataNames[9] = "effect";			spellDataTypes[9] = "TEXT";
			spellDataNames[10] = "effectChance";	spellDataTypes[10] = "INT";
			spellDataNames[11] = "hitChance";		spellDataTypes[11] = "INT";
			spellDataNames[12] = "buff1Effect";		spellDataTypes[12] = "TEXT";
			spellDataNames[13] = "buff1Percent";	spellDataTypes[13] = "INT"; 
			spellDataNames[14] = "buff2Effect";		spellDataTypes[14] = "TEXT"; 
			spellDataNames[15] = "buff2Percent";	spellDataTypes[15] = "INT";
			spellDataNames[16] = "buffLength";		spellDataTypes[16] = "INT"; 
			spellDataNames[17] = "continuousHit";	spellDataTypes[17] = "TEXT";
			spellDataNames[18] = "prerequisites";	spellDataTypes[18] = "TEXT";
			
			
			//weapon table
			weaponDataNames = new Array();				weaponDataTypes = new Array();
			weaponDataNames[0] = "id";					weaponDataTypes[0] = "INT PRIMARY KEY AUTOINCREMENT NOT NULL"; 
			weaponDataNames[1] = "name";				weaponDataTypes[1] = "TEXT";
			weaponDataNames[2] = "description";			weaponDataTypes[2] = "TEXT";
			weaponDataNames[3] = "heroType";			weaponDataTypes[3] = "TEXT";
			weaponDataNames[4] = "critChance";			weaponDataTypes[4] = "INT";
			weaponDataNames[5] = "critDamagePercent";	weaponDataTypes[5] = "INT";
			weaponDataNames[6] = "critEffect";			weaponDataTypes[6] = "TEXT";
			weaponDataNames[7] = "critEffectChance";	weaponDataTypes[7] = "INT";
			weaponDataNames[8] = "splashDmgPercent";	weaponDataTypes[8] = "INT";
			weaponDataNames[9] = "splashEffect";		weaponDataTypes[9] = "TEXT";
			weaponDataNames[10] = "splashEffectChance";	weaponDataTypes[10] = "INT";
		}
		private function initDatabase():void
		{
			db_file = File.applicationStorageDirectory.resolvePath("GPS_RPG.db");
			db_connection = new SQLConnection();
			
			try 
			{
				//connect to our file
				db_connection.open(db_file);
				
				if(db_file.exists) 
				{
					//trace("\t-file exists, ready to use");
					appendMessage("\t-database file exists, ready to use");
					appendMessage("\t-file found at: " + db_file.url);
					try 
					{
						createAllTables();
					}
					catch(err1:Error) 
					{
						//trace("\t-error: " + e.message);
						appendMessage("\t-Error Creating Tables: ");
						appendMessage(err1.getStackTrace());
						throw err1;
					}
					try
					{
						checkDatabaseVersion(); //check the online database if we need to update our db
					}
					catch(err2:Error) 
					{
						//trace("\t-error: " + e.message);
						appendMessage("\t-Error Checking Database Version: ");
						appendMessage(err2.getStackTrace());
						throw err2;
					}
				} 
				else 
				{
					//theorically this should never happen. 
					//ResolvePath() creates a file when one doesn't exist
					
					//trace("\t-file doesn't exist, building");			
					appendMessage("\t-database file doesn't exist, building...");
					createAllTables();
					populateDatabase(); //pull information from online database
				}
				
				//trace("\t-connected to file");
				appendMessage("\t-connected to file");
				
				if (db_connection.connected){ appendMessage("\t-successfully connected to database file");	}
				else { appendMessage("\t-could not connect to database file"); 	}
				
			} 
			catch(err:Error) 
			{
				//trace("\t-error: " + e.message);
				appendMessage("\t-Error Initializing Database: ");
				appendMessage(err.message);
			}
		}
		
		
		//create all the necessary SQL Tables
		private function createAllTables(verbose:Boolean=false):void
		{
			appendMessage("Creating All Database Tables...");
			/*createTable("DBVersion",	dbVersionDataNames,		dbVersionDataTypes, verbose);
			createTable("BiomeType",	biomeTypesDataNames,	biomeTypesDataTypes, verbose);
			createTable("EnemyType",	enemyTypesDataNames,	enemyTypesDataTypes, verbose);
			createTable("Enemy",	 	enemiesDataNames,		enemiesDataTypes, verbose);
			createTable("Item",	 		itemDataNames,			itemDataTypes, verbose);
			createTable("Crafting",	 	craftingDataNames,		craftingDataTypes, verbose);*/
			
			for (var i:int = 0; i < tableNames.length; i++)
			{
				createTable(tableNames[i], getTableNamesArray(tableNames[i]), getTableTypesArray(tableNames[i]), verbose);		
			}
		}
		private function dropAllTables(verbose:Boolean=false):void
		{
			appendMessage("Dropping All Database Tables...");
			/*dropTable("DBVersion", verbose);
			dropTable("Armor", verbose);
			dropTable("BiomeType", verbose);
			dropTable("EnemyType", verbose);
			dropTable("Enemy", verbose);
			dropTable("Item", verbose);
			dropTable("Crafting", verbose);*/
			
			for (var i:int = 0; i < tableNames.length; i++)
			{
				dropTable(tableNames[i], verbose);				
			}
		}
		private function checkDatabaseVersion():void
		{
			appendMessage("Checking Database Version");
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = db_connection;
			statement.text = "SELECT * FROM DBVersion ORDER BY date ASC LIMIT 1";
			
			appendMessage("\t-" + statement.text);
			statement.addEventListener(SQLEvent.RESULT, getLocalDBVersion);
	
			try
			{
				statement.execute();
			}
			catch (err:Error)
			{
				//txtResults.text = err.errorID + "\n";
				//txtResults.text += err.message + "\n";
				appendMessage("\t-Error: " + err.getStackTrace());
			}
		}
		private function getLocalDBVersion(e:SQLEvent):void
		{
			//callback function to checkDatabaseVersion()
			//parse our db version
			appendMessage("Getting Local Database Version");
			var stat:SQLStatement = e.currentTarget as SQLStatement;
			stat.removeEventListener(SQLEvent.RESULT, getLocalDBVersion);
			
			var result:SQLResult = stat.getResult();
			if (result == null || result.data == null) 
			{
				appendMessage("\t-no version found. Assigning \"404\"");
				currentDBVersion = "404";
			}
			else
			{
				//trace("The Database result: " + result.data.toString());
				if(result.data[0] != null)
				{
					var entry:Object = result.data[0];
					var versionID:String = entry.id.toString();
					var versionName:String = entry.name.toString();
					var versionDate:String = entry.date.toString();
					appendMessage("\t-ID:" + versionID);
					appendMessage("\t-Name:" + versionName);
					appendMessage("\t-Date:" + versionDate);
					currentDBVersion = versionName;
					
				}
			}
			
			var url:URLRequest = new URLRequest("http://itreallyiskyler.com/games/GPSRPG/database/getDBVersion.php");
			//trace("url: " + url.url);
			var pageLoader:URLLoader = new URLLoader();
			pageLoader.addEventListener(Event.COMPLETE, compareWebDBVersion);
			pageLoader.load(url);
		}
		private function compareWebDBVersion(e:Event):void
		{
			//callback function to urlloader
			appendMessage("Comparing database version to local version");
			appendMessage("Local = " + currentDBVersion + ". Server = " + e.target.data);
			//trace(e.target.data);
			
			//make sure our current dbVersion = the server version
			var serverDBVersion:String = e.target.data;
			if (currentDBVersion != serverDBVersion)
			{
				dropAllTables();  //these two lines are horribly ugly,
				createAllTables();// in the future, optimize by only loading in values that we don't have
				populateDatabase();// best of luck with that solution..... Love, ~Kyler
			}
			else
			{
				appendMessage("\t-versions match. Database is up to date!");				
				
				//throw an event to show that we are done loading the database
				var completedEvent:Event = new Event(Event.COMPLETE);
				//completedEvent.target = this;
				dispatchEvent(completedEvent);
			}
		}
		private function populateDatabase():void
		{			
			//pull data off of server to populate all tables
			//appendMessage("\t-Querying the online database");
			var tableScriptURL:String = "http://itreallyiskyler.com/games/GPSRPG/database/getTable.php?table="
			
			//start our static counter
			tablesLoadedFromServer = 0;
			
			for (var i:int = 0; i < tableNames.length; i++)
			{
				var url:URLRequest = new URLRequest(tableScriptURL + tableNames[i]);
				//trace("url: " + url.url);
				var pageLoader:URLLoader = new URLLoader();
				pageLoader.addEventListener(Event.COMPLETE, addValuesFromServer);
				pageLoader.load(url);
			}
		}
		private function addValuesFromServer(e:Event):void
		{
			//trace("grabbed stuff off the internet");
			appendMessage("\nRetrieved new data from server");
			//e.target is the object that the event listener was attatched to
			//in this case, it is a URLLoader

			var pageData:String = e.target.data.toString();
			var pageLines:Array = pageData.split("\n");
			
			//parse the web page information using specific table values
			var pageTableName:String = pageLines[0]; //the first line is the name of the table
			var dbNamesArray:Array = getTableNamesArray(pageTableName);
			var dbTypesArray:Array = getTableTypesArray(pageTableName);
			var dbValuesArray:Array = new Array();
			
			//parse the database information
			for (var i:int = 1; i < pageLines.length; i++)
			{
				var allValues:Array = pageLines[i].split(",");
				dbValuesArray = new Array();
				appendMessage("Table " + pageTableName + " entry:");
				
				for (var j:int = 0; j < allValues.length - 1; j++)
				{
					appendMessage("\t-" + j + ": " + allValues[j]);
					
					//push only the proper type of value into the dbValuesArray
					if (dbTypesArray[j] == null) break;
					switch ((dbTypesArray[j] as String).substr(0, 3))
					{
						case ("INT"): //parse the value like an int
							appendMessage("\t\t-casting to int: " + parseInt(allValues[j]));
							dbValuesArray.push(parseInt(allValues[j]));
						break;
						
						
						default: //treat it like a string
							dbValuesArray.push(allValues[j]);
						break;
					}
					
				}
				
				//correct for DBVersion input values
				if (pageTableName == "DBVersion" && allValues.length >= 5)
				{
					dbValuesArray = new Array();
					dbValuesArray.push(allValues[0]);
					dbValuesArray.push(allValues[1]);
					dbValuesArray.push(allValues[2] + " " + allValues[3] + " " + allValues[4]);
				}
				
				//add it to the database
				try
				{
					addDataRow(pageTableName, dbNamesArray, dbValuesArray);
				}
				catch (err:Error)
				{
					appendMessage(err.getStackTrace());
					
				}
			}
			
			
			tablesLoadedFromServer ++;
			if (tablesLoadedFromServer == tableNames.length)
			{
				//throw an event to show that we are done loading the database
				var completedEvent:Event = new Event(Event.COMPLETE);
				//completedEvent.target = this;
				dispatchEvent(completedEvent);
				
			}
		}
		
		
		

		//SQL Statements
		private function createTable(tblName:String, tblValueNames:Array, tblValueTypes:Array, verbose:Boolean=true):void
		{
			if (verbose) appendMessage("Creating a Table..." + tblName);
			
			//check to make sure our statement will build properly
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = db_connection;
			var strRequest:String = "CREATE TABLE IF NOT EXISTS " + tblName + " ( ";
			
			//loop through the input arrays to build our request statement
			for (var i:int = 0; i < tblValueNames.length; i++)
			{
				strRequest += tblValueNames[i] + " " + tblValueTypes[i];
				if (i < tblValueNames.length - 1) { strRequest += ", "; } //add commas while there are more values
				
				//sample values
				//"(id TEXT, name TEXT, imagePath TEXT, health INT, strength INT, defense INT)";
			}
			
			strRequest += ")";
			
			//assign our completed request to our SQL connection statement
			statement.text = strRequest;
			
			//attempt to execute our statement
			try 
			{
				if (verbose) appendMessage("\t-" + strRequest);
				statement.execute();
			} 
			catch(e:Error) 
			{
				//trace("Create Table function. SQL Error: ");
				if (verbose) appendMessage("\t-SQL Error: ");
				//trace(e.message);
				if (verbose) appendMessage("\t-" + e.getStackTrace());
			}
		}
		private function dropTable(tblName:String, verbose:Boolean=true):void
		{
			if (verbose) appendMessage("Dropping a Table...");
			
			//check to make sure our statement will build properly
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = db_connection;
			var strRequest:String = "DROP TABLE IF EXISTS " + tblName ;
			
			//assign our completed request to our SQL connection statement
			statement.text = strRequest;
			
			//attempt to execute our statement
			try 
			{
				if (verbose) appendMessage("\t-" + strRequest);
				statement.execute();
			} 
			catch(e:Error) 
			{
				//trace("Create Table function. SQL Error: ");
				if (verbose) appendMessage("\t-SQL Error: ");
				//trace(e.message);
				if (verbose) appendMessage("\t-" + e.getStackTrace());
			}
		}
		public function addDataRow(tblName:String, tblValueNames:Array, tblValues:Array):void 
		{
			//trace("AddData function...");
			appendMessage("AddData function..." + tblName);
			var i:int;
			
			if (tblValueNames.length != tblValues.length)
			{
				//trace("-input value array length error");
				appendMessage("-input value array length error. Expected: " + tblValueNames.length + ". Received: " + tblValues.length);
				return;				
			}
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = db_connection;
			
			
			var strInsert:String = "INSERT INTO " + tblName + " ( ";
			
			//loop through the value names arrays to build our request statement
			for (i = 0; i < tblValueNames.length; i++)
			{
				strInsert += tblValueNames[i];
				if (i < tblValueNames.length - 1) { strInsert += ", "; } //add commas while there are more values
			}
			
			//bridge the two sections
			strInsert += ") VALUES ( ";
			
			
			//loop through the value arrays to finish building our request statement
			for (i = 0; i < tblValues.length; i++)
			{
				strInsert += "\"" + tblValues[i] + "\""; //NEED TO MAKE SURE THAT INPUT VALUES MATCH UP WITH THE CORRECT TYPE ----------------------------------------------------!!!!
				if (i < tblValues.length - 1) { strInsert += ", "; } //add commas while there are more values
			}
			
			//finishthe statement
			strInsert += ")";
			
			//assign our completed request to our SQL connection statement
			statement.text = strInsert;
			statement.execute();
			//trace("-sql insert statement: " + strInsert);
			appendMessage("-sql insert statement: " + strInsert + "\n");
			
		}
		public function getDataRowWithCallBack(callback:Function, tblName:String, rowName:String = null, rowValue:String = null):void 
		{
			//trace("GetData function...");
			appendMessage("GetData function...");
			
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = db_connection;
			
			var sqlStatement:String = "SELECT * FROM " + tblName;
			if (rowName != null && rowValue != null)
			{
				sqlStatement += " WHERE " + rowName + " = " + rowValue;
			}
				
			statement.text = sqlStatement;
			//statement.addEventListener(SQLEvent.RESULT, selectionReceived);
			statement.addEventListener(SQLEvent.RESULT, callback ); //use a callback function instead of the the selectionRecieved function
			statement.execute();
		}
		public function getDataRow(tblName:String, rowName:String = null, rowValue:String = null):void 
		{
			//trace("GetData function...");
			appendMessage("GetData function...");
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = db_connection;
			
			var sqlStatement:String = "SELECT * FROM " + tblName;
			if (rowName != null && rowValue != null)
			{
				sqlStatement += " WHERE " + rowName + " = " + rowValue;
			}
				
			statement.text = sqlStatement;
			statement.addEventListener(SQLEvent.RESULT, selectionReceived);
			statement.execute();
		}
		public function selectionReceived(event:SQLEvent):void 
		{
			//trace("SelectionReceived function...");
			//appendMessage("SelectionReceived function...");
			var stat:SQLStatement = event.currentTarget as SQLStatement;
			stat.removeEventListener(SQLEvent.RESULT, selectionReceived);
			
			var result:SQLResult = stat.getResult();
			if (result != null && result.data != null) 
			{
				//trace("The Database result: " + result.data.toString());
				var rows:int = result.data.length;
				for (var i:int = 0; i < rows; i++) 
				{
					if(result.data[i] != null)
					{
						var row:Object = result.data[i];
						//trace("-row[" + i + "] = " + row);
						appendMessage("-row[" + i + "] = " + row);
						for (var internalValue:Object in row)
						{
							appendMessage("\t-" + internalValue + ": " + row[internalValue]);							
						}
						//row.label = row.id;
						//trace(row.id + " " + row.loc + " " + row.highTemp + " " + row.lowTemp + " " + row.weathConds + " " + row.website);
					}
					
				}
			}
			else 
			{
				// no data came in
				//trace("\t-Result was null or data was null (we deleted)");
				appendMessage("\t-Result was empty/null");
			}
			//_connection.close();
			
			// display Error #3104 if SQLConnection is closed
			//trace(_connection);
		}
		
		
		//other functions
		public function getTableNamesArray(nameOfTable:String):Array
		{
			switch (nameOfTable)
			{
				case ("DBVersion"):		return dbVersionDataNames; break;
				case ("Armor"): 		return armorDataNames; break;
				case ("BiomeType"): 	return biomeTypesDataNames; break;
				case ("Crafting"):		return craftingDataNames; break;
				case ("Enchanting"):	return enchantingDataNames; break;
				case ("Enemy"): 		return enemiesDataNames; break;
				case ("EnemyType"): 	return enemyTypesDataNames; break;
				case ("Item"):			return itemDataNames; break;
				case ("Spell"): 		return spellDataNames; break;
				case ("Weapon"):	 	return weaponDataNames; break;
				
				default: 
					throw new Error("Array does not exist for table: " + nameOfTable);
			}
			
			return new Array();
		}
		public function getTableTypesArray(nameOfTable:String):Array
		{
			switch (nameOfTable)
			{
				case ("DBVersion"):		return dbVersionDataTypes; break;
				case ("Armor"): 		return armorDataTypes; break;
				case ("BiomeType"): 	return biomeTypesDataTypes; break;
				case ("Crafting"):		return craftingDataTypes; break;
				case ("Enchanting"):	return enchantingDataTypes; break;
				case ("Enemy"): 		return enemiesDataTypes; break;
				case ("EnemyType"): 	return enemyTypesDataTypes; break;
				case ("Item"):			return itemDataTypes; break;
				case ("Spell"): 		return spellDataTypes; break;
				case ("Weapon"):	 	return weaponDataTypes; break;
				
				default: 
					throw new Error("Array does not exist for table: " + nameOfTable);
			}
			
			return new Array();
		}
		
		
		
		//odd functions
		public function writeMessage(aMessage:String):void
		{
			//writes out a message to the SQL results window
			if (txtOut != null) txtOut.text = aMessage + "\n";
		}
		public function appendMessage(aMessage:String):void
		{
			//writes out a message to the SQL results window
			if (txtOut != null) txtOut.appendText(aMessage + "\n");
		}
		public function clearMessage():void
		{
			//clears out the SQL results window
			if (txtOut != null) txtOut.text = "";
		}
		
		
	}//end class
} //end package
	

