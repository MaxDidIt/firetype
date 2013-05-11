package de.maxdidit.hardware.font.data.tables.required.name
{
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class NamingTableData
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _format:uint;
		private var _count:uint;
		private var _stringOffset:uint;
		
		private var _nameRecords:Vector.<NameRecord>;
		
		private var _platformMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function NamingTableData()
		{
			_platformMap = new Object();
		}
		
		public function get format():uint
		{
			return _format;
		}
		
		public function set format(value:uint):void
		{
			_format = value;
		}
		
		public function get count():uint
		{
			return _count;
		}
		
		public function set count(value:uint):void
		{
			_count = value;
		}
		
		public function get stringOffset():uint
		{
			return _stringOffset;
		}
		
		public function set stringOffset(value:uint):void
		{
			_stringOffset = value;
		}
		
		public function get nameRecords():Vector.<NameRecord>
		{
			return _nameRecords;
		}
		
		public function set nameRecords(value:Vector.<NameRecord>):void
		{
			_nameRecords = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		private function retrieveProperty(map:Object, key:String):Object
		{
			if (map.hasOwnProperty(key))
			{
				return map[key];
			}
			else
			{
				var property:Object = new Object();
				map[key] = property;
				return property;
			}
		}
		
		public function mapNameRecords():void
		{
			const l:uint = _nameRecords.length;
			for (var i:uint = 0; i < l; i++)
			{
				var currentRecord:NameRecord = _nameRecords[i];
				
				var encodingMap:Object = retrieveProperty(_platformMap, String(currentRecord.platformID));
				var languageMap:Object = retrieveProperty(encodingMap, String(currentRecord.encodingID));
				var nameMap:Object = retrieveProperty(languageMap, String(currentRecord.languageID));
				
				nameMap[String(currentRecord.nameID)] = currentRecord.string;
			}
		}
		
		public function retrieveString(platformID:String, encodingID:String, languageID:String, nameID:String):String
		{
			var encodingMap:Object = retrieveProperty(_platformMap, platformID);
			var languageMap:Object = retrieveProperty(encodingMap, encodingID);
			var nameMap:Object = retrieveProperty(languageMap, languageID);
			
			return nameMap[nameID];
		}
	
	}

}