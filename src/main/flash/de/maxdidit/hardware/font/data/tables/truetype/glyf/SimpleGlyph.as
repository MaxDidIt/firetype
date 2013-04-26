package de.maxdidit.hardware.font.data.tables.truetype.glyf 
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SimpleGlyph extends Glyph 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _endPointsOfContours:Vector.<uint>;
		
		private var _instructionLength:uint;
		private var _instructions:ByteArray;
		
		private var _flagData:Vector.<uint>;
		private var _flags:Vector.<SimpleGlyphFlags>;
		
		private var _xCoordinates:Vector.<int>;
		private var _yCoordinates:Vector.<int>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SimpleGlyph() 
		{
			super();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// endPointsOfContours
		
		public function get endPointsOfContours():Vector.<uint> 
		{
			return _endPointsOfContours;
		}
		
		public function set endPointsOfContours(value:Vector.<uint>):void 
		{
			_endPointsOfContours = value;
		}
		
		// instructionLength
		
		public function get instructionLength():uint 
		{
			return _instructionLength;
		}
		
		public function set instructionLength(value:uint):void 
		{
			_instructionLength = value;
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
		
		// flagData
		
		public function get flagData():Vector.<uint> 
		{
			return _flagData;
		}
		
		public function set flagData(value:Vector.<uint>):void 
		{
			_flagData = value;
		}
		
		// flags
		
		public function get flags():Vector.<SimpleGlyphFlags> 
		{
			return _flags;
		}
		
		public function set flags(value:Vector.<SimpleGlyphFlags>):void 
		{
			_flags = value;
		}
		
		// xCoordinates
		
		public function get xCoordinates():Vector.<int> 
		{
			return _xCoordinates;
		}
		
		public function set xCoordinates(value:Vector.<int>):void 
		{
			_xCoordinates = value;
		}
		
		// yCoordinates
		
		public function get yCoordinates():Vector.<int> 
		{
			return _yCoordinates;
		}
		
		public function set yCoordinates(value:Vector.<int>):void 
		{
			_yCoordinates = value;
		}
		
	}

}