/* 
Copyright ©2013 Max Knoblich 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
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