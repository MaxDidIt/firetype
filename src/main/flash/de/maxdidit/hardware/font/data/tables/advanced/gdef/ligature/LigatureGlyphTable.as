package de.maxdidit.hardware.font.data.tables.advanced.gdef.ligature 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gdef.caret.ICaretValue;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureGlyphTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _caretCount:uint;
		private var _caretValueOffsets:Vector.<uint>;
		private var _caretValues:Vector.<ICaretValue>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureGlyphTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// caretCount
		
		public function get caretCount():uint 
		{
			return _caretCount;
		}
		
		public function set caretCount(value:uint):void 
		{
			_caretCount = value;
		}
		
		// caretValueOffsets
		
		public function get caretValueOffsets():Vector.<uint> 
		{
			return _caretValueOffsets;
		}
		
		public function set caretValueOffsets(value:Vector.<uint>):void 
		{
			_caretValueOffsets = value;
		}
		
		// caretValues
		
		public function get caretValues():Vector.<ICaretValue> 
		{
			return _caretValues;
		}
		
		public function set caretValues(value:Vector.<ICaretValue>):void 
		{
			_caretValues = value;
		}
		
	}

}