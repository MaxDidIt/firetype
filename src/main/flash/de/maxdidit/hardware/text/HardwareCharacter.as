package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.math.AxisAlignedBoundingBox;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareCharacter 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _instances:Vector.<HardwareGlyphInstance>;
		
		private var _glyph:Glyph;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacter() 
		{
			_instances = new Vector.<HardwareGlyphInstance>();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get instances():Vector.<HardwareGlyphInstance> 
		{
			return _instances;
		}
		
		public function get glyph():Glyph 
		{
			return _glyph;
		}
		
		public function set glyph(value:Glyph):void 
		{
			_glyph = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addGlyphInstance(glyphInstance:HardwareGlyphInstance):void 
		{
			_instances.push(glyphInstance);
		}
		
	}

}