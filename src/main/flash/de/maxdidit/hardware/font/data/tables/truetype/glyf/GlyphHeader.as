package de.maxdidit.hardware.font.data.tables.truetype.glyf 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphHeader 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _index:int;
		
		private var _numCountours:int; // If the number of contours is greater than or equal to zero, this is a single glyph; if negative, this is a composite glyph.
		
		// bounding box
		
		private var _xMin:int;
		private var _yMin:int;
		private var _xMax:int;
		private var _yMax:int;
		
		// has contour?
		private var _hasContour:Boolean;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphHeader() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// numContours
		
		public function get numCountours():int 
		{
			return _numCountours;
		}
		
		public function set numCountours(value:int):void 
		{
			_numCountours = value;
		}
		
		// xMin
		
		public function get xMin():int 
		{
			return _xMin;
		}
		
		public function set xMin(value:int):void 
		{
			_xMin = value;
		}
		
		// yMin
		
		public function get yMin():int 
		{
			return _yMin;
		}
		
		public function set yMin(value:int):void 
		{
			_yMin = value;
		}
		
		// xMax
		
		public function get xMax():int 
		{
			return _xMax;
		}
		
		public function set xMax(value:int):void 
		{
			_xMax = value;
		}
		
		// yMax
		
		public function get yMax():int 
		{
			return _yMax;
		}
		
		public function set yMax(value:int):void 
		{
			_yMax = value;
		}
		
		// hasContour
		
		public function get hasContour():Boolean 
		{
			return _hasContour;
		}
		
		public function set hasContour(value:Boolean):void 
		{
			_hasContour = value;
		}
		
		// index
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
	}

}