package de.maxdidit.hardware.font.data.tables.required.hhea 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HorizontalHeaderData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _version:Number;
		
		private var _ascender:int;
		private var _descender:int;
		private var _lineGap:int;
		
		private var _advanceWidthMax:uint;
		private var _minLeftSideBearing:int;
		private var _minRightSideBearing:int;
		
		private var _xMaxExtend:int;
		
		private var _caretSlopeRise:int;
		private var _caretSlopeRun:int;
		private var _caretOffset:int;
		
		private var _metricDataFormat:int;
		private var _numberOfHMetrics:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HorizontalHeaderData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// version
		
		public function get version():Number 
		{
			return _version;
		}
		
		public function set version(value:Number):void 
		{
			_version = value;
		}
		
		public function get ascender():int 
		{
			return _ascender;
		}
		
		public function set ascender(value:int):void 
		{
			_ascender = value;
		}
		
		public function get descender():int 
		{
			return _descender;
		}
		
		public function set descender(value:int):void 
		{
			_descender = value;
		}
		
		public function get lineGap():int 
		{
			return _lineGap;
		}
		
		public function set lineGap(value:int):void 
		{
			_lineGap = value;
		}
		
		public function get advanceWidthMax():uint 
		{
			return _advanceWidthMax;
		}
		
		public function set advanceWidthMax(value:uint):void 
		{
			_advanceWidthMax = value;
		}
		
		public function get minLeftSideBearing():int 
		{
			return _minLeftSideBearing;
		}
		
		public function set minLeftSideBearing(value:int):void 
		{
			_minLeftSideBearing = value;
		}
		
		public function get minRightSideBearing():int 
		{
			return _minRightSideBearing;
		}
		
		public function set minRightSideBearing(value:int):void 
		{
			_minRightSideBearing = value;
		}
		
		public function get xMaxExtend():int 
		{
			return _xMaxExtend;
		}
		
		public function set xMaxExtend(value:int):void 
		{
			_xMaxExtend = value;
		}
		
		public function get caretSlopeRise():int 
		{
			return _caretSlopeRise;
		}
		
		public function set caretSlopeRise(value:int):void 
		{
			_caretSlopeRise = value;
		}
		
		public function get caretSlopeRun():int 
		{
			return _caretSlopeRun;
		}
		
		public function set caretSlopeRun(value:int):void 
		{
			_caretSlopeRun = value;
		}
		
		public function get caretOffset():int 
		{
			return _caretOffset;
		}
		
		public function set caretOffset(value:int):void 
		{
			_caretOffset = value;
		}
		
		public function get metricDataFormat():int 
		{
			return _metricDataFormat;
		}
		
		public function set metricDataFormat(value:int):void 
		{
			_metricDataFormat = value;
		}
		
		public function get numberOfHMetrics():uint 
		{
			return _numberOfHMetrics;
		}
		
		public function set numberOfHMetrics(value:uint):void 
		{
			_numberOfHMetrics = value;
		}
		
	}

}