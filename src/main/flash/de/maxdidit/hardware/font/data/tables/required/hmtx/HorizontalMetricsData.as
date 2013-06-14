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
 
package de.maxdidit.hardware.font.data.tables.required.hmtx 
{
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HorizontalMetricsData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _longHorizontalMetrics:Vector.<LongHorizontalMetric>;
		private var _leftSideBearings:Vector.<int>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HorizontalMetricsData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get longHorizontalMetrics():Vector.<LongHorizontalMetric> 
		{
			return _longHorizontalMetrics;
		}
		
		public function set longHorizontalMetrics(value:Vector.<LongHorizontalMetric>):void 
		{
			_longHorizontalMetrics = value;
		}
		
		public function get leftSideBearings():Vector.<int> 
		{
			return _leftSideBearings;
		}
		
		public function set leftSideBearings(value:Vector.<int>):void 
		{
			_leftSideBearings = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function getLeftSideBearing(index:uint):int
		{
			if (index < _longHorizontalMetrics.length)
			{
				return _longHorizontalMetrics[index].leftSideBearing;
			}
			
			if (index < (_longHorizontalMetrics.length + _leftSideBearings.length))
			{
				return _leftSideBearings[index - _longHorizontalMetrics.length];
			}
			
			return 0;
		}
		
		public function getAdvanceWidth(index:uint):uint
		{
			if (index < _longHorizontalMetrics.length)
			{
				return _longHorizontalMetrics[index].advanceWidth;
			}
			
			if (_longHorizontalMetrics.length > 0)
			{
				return _longHorizontalMetrics[_longHorizontalMetrics.length - 1].advanceWidth;
			}
			
			return 0;
		}
		
	}

}