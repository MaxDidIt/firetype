package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AxisAlignedBoundingBox 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		public var left:Number;
		public var right:Number;
		public var top:Number;
		public var bottom:Number;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AxisAlignedBoundingBox(left:Number = 0, top:Number = 0, right:Number = 0, bottom:Number = 0) 
		{
			this.left = left;
			this.top = top;
			this.right = right;
			this.bottom = bottom;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get width():Number
		{
			return right - left;
		}
		
		public function get height():Number
		{
			return top - bottom;
		}
	}

}