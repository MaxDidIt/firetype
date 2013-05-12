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
		
		// bounding box
		
		private var _boundingBox:AxisAlignedBoundingBox;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareCharacter() 
		{
			_instances = new Vector.<HardwareGlyphInstance>();
			_boundingBox = new AxisAlignedBoundingBox();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get instances():Vector.<HardwareGlyphInstance> 
		{
			return _instances;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addGlyphInstance(glyphInstance:HardwareGlyphInstance):void 
		{
			_instances.push(glyphInstance);
			
			// expand bounding box, if necessary
			_boundingBox.expand(glyphInstance.glyph.boundingBox);
		}
		
		public function get boundingBox():AxisAlignedBoundingBox 
		{
			return _boundingBox;
		}
		
		public function set boundingBox(value:AxisAlignedBoundingBox):void 
		{
			_boundingBox = value;
		}
		
	}

}