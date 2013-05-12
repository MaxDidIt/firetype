package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.HardwareGlyph;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareGlyphInstance extends TransformedInstance
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyph:HardwareGlyph;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareGlyphInstance($glyph:HardwareGlyph) 
		{
			_glyph = $glyph;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// glyph
		
		public function get glyph():HardwareGlyph 
		{
			return _glyph;
		}
		
		public function set glyph(value:HardwareGlyph):void 
		{
			_glyph = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function clone():TransformedInstance 
		{
			var result:HardwareGlyphInstance = new HardwareGlyphInstance(_glyph);
			
			result.x = this.x;
			result.y = this.y;
			
			return result;
		}
		
	}

}