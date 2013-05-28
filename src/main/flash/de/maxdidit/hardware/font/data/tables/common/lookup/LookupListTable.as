package de.maxdidit.hardware.font.data.tables.common.lookup 
{
	import de.maxdidit.hardware.font.parser.tables.ISubTableParser;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LookupListTable
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _lookupCount:uint;
		private var _lookupOffsets:Vector.<uint>;
		private var _lookupTables:Vector.<LookupTable>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LookupListTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get lookupCount():uint 
		{
			return _lookupCount;
		}
		
		public function set lookupCount(value:uint):void 
		{
			_lookupCount = value;
		}
		
		public function get lookupOffsets():Vector.<uint> 
		{
			return _lookupOffsets;
		}
		
		public function set lookupOffsets(value:Vector.<uint>):void 
		{
			_lookupOffsets = value;
		}
		
		public function get lookupTables():Vector.<LookupTable> 
		{
			return _lookupTables;
		}
		
		public function set lookupTables(value:Vector.<LookupTable>):void 
		{
			_lookupTables = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function retrieveLookupTables(indices:Vector.<uint>):Vector.<LookupTable>
		{
			const l:uint = indices.length;
			var result:Vector.<LookupTable> = new Vector.<LookupTable>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				var index:uint = indices[i];
				result[i] = _lookupTables[index];
			}
			
			return result;
		}
	}

}