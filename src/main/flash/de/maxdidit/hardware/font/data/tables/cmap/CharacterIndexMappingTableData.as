package de.maxdidit.hardware.font.data.tables.cmap 
{
	import de.maxdidit.hardware.font.data.tables.cmap.sub.CharacterIndexMappingSubtable;
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
			_subTables = value;
		}
		
	}

}