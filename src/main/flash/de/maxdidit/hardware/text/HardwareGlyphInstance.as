package de.maxdidit.hardware.text 
{
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareGlyphInstance extends TransformedInstance
	{
		///////////////////////
		// Static Variables
		///////////////////////
		
		private static var _pool:LinkedList = new LinkedList();
		
		///////////////////////
		// Static Functions
		///////////////////////
		
		public static function getHardwareGlyphInstance(glyph:HardwareGlyph):HardwareGlyphInstance
		{
			var instance:HardwareGlyphInstance;
			
			if (_pool.firstElement)
			{
				var element:HardwareGlyphInstanceListElement = _pool.firstElement as HardwareGlyphInstanceListElement;
				instance = element.hardwareGlyphInstance;
				instance.glyph = glyph;
				
				_pool.removeElement(element);
			}
			else
			{
				instance = new HardwareGlyphInstance(glyph);
			}
			
			return instance;
		}
		
		public static function returnHardwareGlyphInstance(instance:HardwareGlyphInstance):void
		{
			var element:HardwareGlyphInstanceListElement = new HardwareGlyphInstanceListElement(instance);
			_pool.addElement(element);
		}
		
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
			var result:HardwareGlyphInstance = getHardwareGlyphInstance(_glyph);
			
			result.x = this.x;
			result.y = this.y;
			
			return result;
		}
		
	}

}