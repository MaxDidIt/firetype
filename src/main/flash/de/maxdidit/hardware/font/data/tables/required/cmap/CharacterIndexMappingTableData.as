package de.maxdidit.hardware.font.data.tables.required.cmap 
{
	import de.maxdidit.hardware.font.data.tables.required.cmap.sub.CharacterIndexMappingSubtable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CharacterIndexMappingTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _version:uint;
		private var _numTables:uint;
		
		private var _subTables:Vector.<CharacterIndexMappingSubtable>;
		private var _tableMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CharacterIndexMappingTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// version
		
		public function get version():uint 
		{
			return _version;
		}
		
		public function set version(value:uint):void 
		{
			_version = value;
		}
		
		// numTables
		
		public function get numTables():uint 
		{
			return _numTables;
		}
		
		public function set numTables(value:uint):void 
		{
			_numTables = value;
		}
		
		// subTables
		
		public function get subTables():Vector.<CharacterIndexMappingSubtable> 
		{
			return _subTables;
		}
		
		public function set subTables(value:Vector.<CharacterIndexMappingSubtable>):void 
		{
			if (_subTables != value)
			{
				_subTables = value;
				mapSubTables();
			}
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function getGlyphIndex(charCode:Number, platformID:int, encodingID:int):int
		{
			var subTable:CharacterIndexMappingSubtable = _tableMap[platformID][encodingID];
			var glyphIndex:int = subTable.data.getGlyphIndex(charCode);
			
			return glyphIndex;
		}
		
		private function mapSubTables():void 
		{
			if (!_subTables)
			{
				return;
			}
			
			var tableMap:Object = new Object();
			const l:uint = _subTables.length;
			for (var i:uint = 0; i < l; i++)
			{
				var subtable:CharacterIndexMappingSubtable = _subTables[i];
				
				var platformID:String = String(subtable.platformID);
				var encodingID:String = String(subtable.encodingID);
				
				var subMap:Object;
				if (tableMap.hasOwnProperty(String(platformID)))
				{
					subMap = tableMap[platformID];
				}
				else
				{
					subMap = new Object();
					tableMap[platformID] = subMap;
				}
				
				subMap[encodingID] = subtable;
			}
			
			_tableMap = tableMap;
		}
		
	}

}