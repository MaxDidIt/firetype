package de.maxdidit.hardware.text 
{
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
		
		private var _useMetricsOfIndex:uint = 0;
		
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
		
		public function get useMetricsOfIndex():uint 
		{
			return _useMetricsOfIndex;
		}
		
		public function set useMetricsOfIndex(value:uint):void 
		{
			_useMetricsOfIndex = value;
		}
		
		public function get useMetricsOfGlyph():HardwareGlyphInstance
		{
			return _instances[_useMetricsOfIndex];
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