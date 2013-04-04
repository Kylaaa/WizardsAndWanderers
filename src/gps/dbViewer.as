package gps {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.data.*; //SQL statements
	
	import gps.Database;
	
	public class dbViewer extends MovieClip 
	{
		//GLOBAL VARIABLES
		var db:Database;
		
		public function dbViewer() 
		{
			//grab our database / initialize it
			try
			{
				db = new Database(txtResults);
				db.addEventListener(Event.COMPLETE, flagAsCompleted);
			}
			catch (err1:Error)
			{
				appendMessage("An error occurred initializing the database:");
				appendMessage(err1.getStackTrace());
			}
			
			
			// constructor code
			initScreenElements();
			
			
			try
			{
				buildSQLStatement(menuValues.text);
			}
			catch(err2:Error)
			{
				//trace("-error building SQL Statement");
				appendMessage("Error: cannot pre build SQL Statement");
				//appendMessage("\t-" + err.getStackTrace());
				//throw(err);
			}
		}
		
		private function flagAsCompleted(e:Event)
		{
			writeMessage("Database done loading");
			lblCurrentDBVersion.text = db.CurrentDBVersion;
		}
		
		
		//init functions
		private function initScreenElements():void 
		{
			//trace("initializing on screen elements");
			appendMessage("Init Screen Elements");
			
			//set things to be visible or not
			chkWhere1.visible = true;			chkWhere2.visible = false;			chkWhere3.visible = false; 			//Where stuff
			menuWhereName1.visible = false;		menuWhereName2.visible = false;		menuWhereName3.visible = false;
			menuWhereSign1.visible = false;		menuWhereSign2.visible = false;		menuWhereSign3.visible = false;
			txtWhereValue1.visible = false;		txtWhereValue2.visible = false;		txtWhereValue3.visible = false;
			lblWhere.visible = false;			menuAndOr2.visible = false;			menuAndOr3.visible = false;
			
			lblLimit.visible = false;
			menuLimitResults.visible = false;
			
			
			//populate our drop down menus
			menuTables.dataProvider.addItem({label:"Armor", data:"Armor"});
			menuTables.dataProvider.addItem({label:"Biome Type", data:"BiomeType"});
			menuTables.dataProvider.addItem({label:"Crafting", data:"Crafting"});
			menuTables.dataProvider.addItem({label:"Database Version", data:"DBVersion"});
			menuTables.dataProvider.addItem({label:"Enchanting", data:"Enchanting"});
			menuTables.dataProvider.addItem({label:"Enemy", data:"Enemy"});
			menuTables.dataProvider.addItem({label:"Enemy Type", data:"EnemyType"});
			menuTables.dataProvider.addItem({label:"Item", data:"Item"});
			menuTables.dataProvider.addItem({label:"Spell", data:"Spell"});
			menuTables.dataProvider.addItem({label:"Weapon", data:"Weapon"});
			
			
			//add event listeners
			menuTables.addEventListener(Event.CHANGE, updateDropMenus);
			
			menuValues.addEventListener(Event.CHANGE, updateSQLStatement);
			menuWhereName1.addEventListener(Event.CHANGE, updateSQLStatement);
			menuWhereSign1.addEventListener(Event.CHANGE, updateSQLStatement);
			txtWhereValue1.addEventListener(Event.CHANGE, updateSQLStatement);
			menuWhereName2.addEventListener(Event.CHANGE, updateSQLStatement);
			menuWhereSign2.addEventListener(Event.CHANGE, updateSQLStatement);
			txtWhereValue2.addEventListener(Event.CHANGE, updateSQLStatement);
			menuWhereName3.addEventListener(Event.CHANGE, updateSQLStatement);
			menuWhereSign3.addEventListener(Event.CHANGE, updateSQLStatement);
			txtWhereValue3.addEventListener(Event.CHANGE, updateSQLStatement);
			menuAndOr2.addEventListener(Event.CHANGE, updateSQLStatement);
			menuAndOr3.addEventListener(Event.CHANGE, updateSQLStatement);
			menuLimitResults.addEventListener(Event.CHANGE, updateSQLStatement);
			
			btnExecuteSQL.addEventListener(MouseEvent.CLICK, executeSQLStatement);
			
			chkLimit.addEventListener(MouseEvent.CLICK,  toggleVisLimit);
			chkWhere1.addEventListener(MouseEvent.CLICK, toggleVisWhere1);
			chkWhere2.addEventListener(MouseEvent.CLICK, toggleVisWhere2);
			chkWhere3.addEventListener(MouseEvent.CLICK, toggleVisWhere3);			
		}
		
		
		//SCREEN ELEMENT FUNCTIONS
		private function toggleVisLimit(e:MouseEvent):void 
		{ 
			lblLimit.visible = chkLimit.selected; 
			menuLimitResults.visible = chkLimit.selected;
			
			buildSQLStatement();
		}
		private function toggleVisWhere1(e:MouseEvent = null):void 
		{ 
			lblWhere.visible = chkWhere1.selected; 
			menuWhereName1.visible = chkWhere1.selected; 
			menuWhereSign1.visible = chkWhere1.selected; 
			txtWhereValue1.visible = chkWhere1.selected; 
			
			chkWhere2.visible = chkWhere1.selected; 
			if (!chkWhere1.selected)
			{
				chkWhere2.selected = chkWhere1.selected; 
				toggleVisWhere2();
			}
			
			if (!chkWhere1.selected)
			{
				chkWhere3.visible = chkWhere1.selected; 
				chkWhere3.selected = chkWhere1.selected
				toggleVisWhere3();
			}
			
			buildSQLStatement();
		}
		private function toggleVisWhere2(e:MouseEvent = null):void 
		{ 
			menuAndOr2.visible = chkWhere2.selected;
			menuWhereName2.visible = chkWhere2.selected; 
			menuWhereSign2.visible = chkWhere2.selected; 
			txtWhereValue2.visible = chkWhere2.selected; 
			
			chkWhere3.visible = chkWhere2.selected; 
			if (!chkWhere2.selected)
			{
				chkWhere3.selected = chkWhere2.selected
				toggleVisWhere3();
			}
			
			buildSQLStatement();
		}
		private function toggleVisWhere3(e:MouseEvent = null):void 
		{ 
			menuAndOr3.visible = chkWhere3.selected;
			menuWhereName3.visible = chkWhere3.selected; 
			menuWhereSign3.visible = chkWhere3.selected; 
			txtWhereValue3.visible = chkWhere3.selected; 
			
			buildSQLStatement();
		}
		private function updateDropMenus(e:Event):void 
		{
			//trace("updating all the Drop Menus");
			
			//trace("-selected index: " + menuTables.selectedIndex);
			//trace("-text: " + menuTables.text);
			//trace("-value: " + menuTables.value);
			var loopArray:Array;
			loopArray = db.getTableNamesArray(menuTables.value);
			
			/*switch(menuTables.value)
			{
				case("DBVersion"):  loopArray = db.DBVersionDataNames;		break;
				case("BiomeType"): 	loopArray = db.BiomeTypesDataNames;		break;
				case("Crafting"): 	loopArray = db.CraftingDataNames; 		break;
				case("Enemy"): 		loopArray = db.EnemiesDataNames; 		break;
				case("EnemyType"): 	loopArray = db.EnemyTypesDataNames; 	break;
				case("Item"): 		loopArray = db.ItemDataNames; 			break;
				default:  			loopArray = new Array(); 				break;
			}*/
			
			//clear out each of our drop menus
			menuValues.dataProvider.removeAll();
			menuWhereName1.dataProvider.removeAll();
			menuWhereName2.dataProvider.removeAll();
			menuWhereName3.dataProvider.removeAll();

			
			//repopulate them with actual values
			menuValues.dataProvider.addItem({label:"*", data:"*"});
			menuWhereName1.dataProvider.addItem({label:" ", data:" "});
			menuWhereName2.dataProvider.addItem({label:" ", data:" "});
			menuWhereName3.dataProvider.addItem({label:" ", data:" "});
			
			for (var i:int = 0; i < loopArray.length; i++)
			{
				menuValues.dataProvider.addItem(	{label: loopArray[i].toString(), data: loopArray[i].toString()});
				menuWhereName1.dataProvider.addItem({label: loopArray[i].toString(), data: loopArray[i].toString()});
				menuWhereName2.dataProvider.addItem({label: loopArray[i].toString(), data: loopArray[i].toString()});
				menuWhereName3.dataProvider.addItem({label: loopArray[i].toString(), data: loopArray[i].toString()});
			}
			
			//update our sql statement
			//try
			//{
				buildSQLStatement(menuValues.text);
			//}
			//catch(err:Error)
			//{
			//	trace("-error building SQL Statement");
			//}
		}
		private function updateSQLStatement(e:Event):void 
		{
			//trace("updating the SQL statement");
			buildSQLStatement();
		}
		private function buildSQLStatement(tblName:String = null):void 
		{
			if (tblName == null) { tblName = menuValues.value; }
			
			var sqlStatement:String = "SELECT ";
			//sqlStatement += menuValues.value + " ";
			sqlStatement += tblName + " ";
			sqlStatement += "FROM " + menuTables.value + " ";
			
			if (chkWhere1.selected)
				sqlStatement += "WHERE " + menuWhereName1.value + " " + menuWhereSign1.value + " " + txtWhereValue1.text + " ";
			if (chkWhere2.selected)
				sqlStatement += menuAndOr2.value + " " + menuWhereName2.value + " " + menuWhereSign2.value + " " + txtWhereValue2.text + " ";
			if (chkWhere3.selected)
				sqlStatement += menuAndOr3.value + " " + menuWhereName3.value + " " + menuWhereSign3.value + " " + txtWhereValue3.text + " ";
			
			if (chkLimit.selected)
				sqlStatement += "LIMIT " + menuLimitResults.value;
				
			
			//put our new SQL Statement into our text box
			txtStatement.text = sqlStatement;
		}
		private function executeSQLStatement(e:MouseEvent):void 
		{		
			writeMessage("Executing SQL statement");
			var statement:SQLStatement = new SQLStatement();
			statement.sqlConnection = db.DB_Connection;
			statement.text = txtStatement.text;
			
			appendMessage("\t-" + statement.text);
			statement.addEventListener(SQLEvent.RESULT, db.selectionReceived);
			
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
		
		
		
		
		//odd functions
		public function writeMessage(aMessage:String):void
		{
			//writes out a message to the SQL results window
			txtResults.text = aMessage + "\n";
		}
		public function appendMessage(aMessage:String):void
		{
			//writes out a message to the SQL results window
			txtResults.appendText(aMessage + "\n");
		}
		public function clearMessage():void
		{
			//clears out the SQL results window
			txtResults.text = "";
		}
	}
	
}
