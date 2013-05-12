package de.maxdidit.math 
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
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function setValues($left:Number, $bottom:Number, $right:Number, $top:Number):void 
		{
			left = $left;
			bottom = $bottom;
			right = $right;
			top = $top;
		}
		
		public function expandTopBottom(boundingBox:AxisAlignedBoundingBox):void
		{
			var yNotYetSet:Boolean = (top == 0 && bottom == 0);
			
			// top/bottom			
			if (top < boundingBox.top || yNotYetSet)
			{
				top = boundingBox.top;
			}
			
			if (bottom > boundingBox.bottom || yNotYetSet)
			{
				bottom = boundingBox.bottom;
			}
		}
		
		public function expandLeftRight(boundingBox:AxisAlignedBoundingBox):void
		{
			var xNotYetSet:Boolean = (left == 0 && right == 0);
			
			// left/right
			if (left > boundingBox.left || xNotYetSet)
			{
				left = boundingBox.left;
			}
			
			if (right < boundingBox.right || xNotYetSet)
			{
				right = boundingBox.right;
			}
		}
		
		public function expand(boundingBox:AxisAlignedBoundingBox):void 
		{
			expandLeftRight(boundingBox);
			expandTopBottom(boundingBox);
		}
		
	}

}