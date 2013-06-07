package de.maxdidit.hardware.text.components 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.TransformedInstance;
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
				instance.hardwareGlyph = glyph;
				instance.glyph = null;
				
				instance.x = 0;
				instance.y = 0;
				
				instance.scaleX = 1;
				instance.scaleY = 1;
				
				instance.shearX = 0;
				instance.shearY = 0;
				
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
		
		private var _hardwareGlyph:HardwareGlyph;
		private var _glyph:Glyph;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareGlyphInstance($glyph:HardwareGlyph) 
		{
			_hardwareGlyph = $glyph;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// glyph
		
		public function get hardwareGlyph():HardwareGlyph 
		{
			return _hardwareGlyph;
		}
		
		public function set hardwareGlyph(value:HardwareGlyph):void 
		{
			_hardwareGlyph = value;
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
		
		override public function clone():TransformedInstance 
		{
			var result:HardwareGlyphInstance = getHardwareGlyphInstance(_hardwareGlyph);
			
			result.x = this.x;
			result.y = this.y;
			
			return result;
		}
		
	}

}