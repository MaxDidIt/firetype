package de.maxdidit.hardware.font.data.tables.required.cmap.sub 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ByteEncodingTableData implements ICharacterIndexMappingSubtableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _length:uint;
		private var _language:uint;
		
		private var _glyphIDs:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ByteEncodingTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.cmap.sub.ICharacterIndexMappingSubtableData */
		
		public function get format():uint 
		{
			return 0;
		}
		
		// length
		
		public function get length():uint 
		{
			return _length;
		}
		
		public function set length(value:uint):void 
		{
			_length = value;
		}
		
		// language
		
		public function get language():uint 
		{
			return _language;
		}
		
		public function set language(value:uint):void 
		{
			_language = value;
		}
		
		// glyphIDs
		
		public function get glyphIDs():Vector.<uint> 
		{
			return _glyphIDs;
		}
		
		public function set glyphIDs(value:Vector.<uint>):void 
		{
			_glyphIDs = value;
		}
		
		
		
	}

}