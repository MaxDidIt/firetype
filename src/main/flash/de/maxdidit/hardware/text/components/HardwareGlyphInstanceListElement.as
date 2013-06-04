package de.maxdidit.hardware.text.components 
{
	import de.maxdidit.list.LinkedListElement;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareGlyphInstanceListElement extends LinkedListElement
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphInstance:HardwareGlyphInstance;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareGlyphInstanceListElement(glyphInstance:HardwareGlyphInstance) 
		{
			_glyphInstance = glyphInstance;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get hardwareGlyphInstance():HardwareGlyphInstance 
		{
			return _glyphInstance;
		}
		
		public function set hardwareGlyphInstance(value:HardwareGlyphInstance):void 
		{
			_glyphInstance = value;
		}
		
	}

}