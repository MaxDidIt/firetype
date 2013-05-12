package de.maxdidit.hardware.text
{
	import de.maxdidit.math.AxisAlignedBoundingBox;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HardwareLine extends TransformedInstance
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _boundingBox:AxisAlignedBoundingBox;
		
		//private var _words:Vector.<HardwareWord>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareLine()
		{
			_boundingBox = new AxisAlignedBoundingBox();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get boundingBox():AxisAlignedBoundingBox
		{
			return _boundingBox;
		}
		
		public function set boundingBox(value:AxisAlignedBoundingBox):void
		{
			_boundingBox = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addWord(word:HardwareWord):void
		{
			//_words.push(word);
			addChild(word);
			
			word.x = _boundingBox.right;
			_boundingBox.right = word.x + word.boundingBox.width;
			
			_boundingBox.expandTopBottom(word.boundingBox);
		}
		
		private function calculateMeasurements():void
		{
		
		}
	}

}