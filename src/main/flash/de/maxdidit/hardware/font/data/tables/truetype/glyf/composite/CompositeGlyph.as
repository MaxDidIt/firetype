package de.maxdidit.hardware.font.data.tables.truetype.glyf.composite 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CompositeGlyph extends Glyph 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _components:Vector.<CompositeGlyphComponent>;
		
		private var _numInstructions:uint;
		private var _instructions:ByteArray;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CompositeGlyph() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// components
		
		public function get components():Vector.<CompositeGlyphComponent> 
		{
			return _components;
		}
		
		public function set components(value:Vector.<CompositeGlyphComponent>):void 
		{
			_components = value;
		}
		
		// numInstructions
		
		public function get numInstructions():uint 
		{
			return _numInstructions;
		}
		
		public function set numInstructions(value:uint):void 
		{
			_numInstructions = value;
		}
		
		// instructions
		
		public function get instructions():ByteArray 
		{
			return _instructions;
		}
		
		public function set instructions(value:ByteArray):void 
		{
			_instructions = value;
		}
		
	}

}