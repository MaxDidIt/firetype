package de.maxdidit.hardware.font.data.tables.required.cmap.sub 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HighByteMappingTableData implements ICharacterIndexMappingSubtableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _length:uint;
		private var _language:uint;
		
		private var _subHeaderKeys:Vector.<uint>;
		
		private var _subHeaders:Vector.<HighByteSubHeader>;
		private var _glyphIndexArray:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HighByteMappingTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.cmap.sub.ICharacterIndexMappingSubtableData */
		
		// format
		
		public function get format():uint 
		{
			return 2;
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
		
		// subHeaderKeys
		
		public function get subHeaderKeys():Vector.<uint> 
		{
			return _subHeaderKeys;
		}
		
		public function set subHeaderKeys(value:Vector.<uint>):void 
		{
			_subHeaderKeys = value;
		}
		
		// subHeaders
		
		public function get subHeaders():Vector.<HighByteSubHeader> 
		{
			return _subHeaders;
		}
		
		public function set subHeaders(value:Vector.<HighByteSubHeader>):void 
		{
			_subHeaders = value;
		}
		
		// glyphIndexArray
		
		public function get glyphIndexArray():Vector.<uint> 
		{
			return _glyphIndexArray;
		}
		
		public function set glyphIndexArray(value:Vector.<uint>):void 
		{
			_glyphIndexArray = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.required.cmap.sub.ICharacterIndexMappingSubtableData */
		
		public function getGlyphIndex(charCode:Number):int 
		{
			throw new Error("This function is not yet implemented.");
		}
	}

}