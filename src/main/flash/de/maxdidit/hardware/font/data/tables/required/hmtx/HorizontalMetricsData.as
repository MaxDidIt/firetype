package de.maxdidit.hardware.font.data.tables.required.hmtx 
{
	import de.maxdidit.hardware.text.HardwareCharacterInstance;
	import de.maxdidit.hardware.text.HardwareCharacterInstanceListElement;
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
				return _longHorizontalMetrics[index].advancedWidth;
			}
			
			if (_longHorizontalMetrics.length > 0)
			{
				return _longHorizontalMetrics[_longHorizontalMetrics.length - 1].advancedWidth;
			}
			
			return 0;
		}
		
		public function applyTable(characterInstances:LinkedList):void 
		{
			var currentCharacter:HardwareCharacterInstance = (characterInstances.currentElement as HardwareCharacterInstanceListElement).hardwareCharacterInstance;
				
			var glyphID:uint = currentCharacter.glyphID;
			var leftSideBearing:int = getLeftSideBearing(glyphID);
			var advanceWidth:uint = getAdvanceWidth(glyphID);
			
			var pp1:int;
			if (currentCharacter.hardwareCharacter)
			{
				pp1 += currentCharacter.hardwareCharacter.boundingBox.left;
			}
			pp1 -= leftSideBearing;
			
			var pp2:int = pp1 + advanceWidth;
			
			currentCharacter.leftBearing += pp1;
			currentCharacter.rightBearing += pp2;
		}
		
	}

}