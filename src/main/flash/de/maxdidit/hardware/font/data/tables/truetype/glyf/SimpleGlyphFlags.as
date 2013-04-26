package de.maxdidit.hardware.font.data.tables.truetype.glyf 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SimpleGlyphFlags 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _onCurve:Boolean;
		
		private var _shortXVector:Boolean;
		private var _shortYVector:Boolean;
		
		private var _isRepeated:Boolean;
		private var _numRepeats:uint;
		
		private var _sameXAsPrevious:Boolean;
		private var _sameYAsPrevious:Boolean;
		
		private var _isXPositive:Boolean; // only applies if shortXVector == true
		private var _isYPositive:Boolean; // only applies if shortYVector == true
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SimpleGlyphFlags() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get onCurve():Boolean 
		{
			return _onCurve;
		}
		
		public function set onCurve(value:Boolean):void 
		{
			_onCurve = value;
		}
		
		public function get shortXVector():Boolean 
		{
			return _shortXVector;
		}
		
		public function set shortXVector(value:Boolean):void 
		{
			_shortXVector = value;
		}
		
		public function get shortYVector():Boolean 
		{
			return _shortYVector;
		}
		
		public function set shortYVector(value:Boolean):void 
		{
			_shortYVector = value;
		}
		
		public function get isRepeated():Boolean 
		{
			return _isRepeated;
		}
		
		public function set isRepeated(value:Boolean):void 
		{
			_isRepeated = value;
		}
		
		public function get numRepeats():uint 
		{
			return _numRepeats;
		}
		
		public function set numRepeats(value:uint):void 
		{
			_numRepeats = value;
		}
		
		public function get sameXAsPrevious():Boolean 
		{
			return _sameXAsPrevious;
		}
		
		public function set sameXAsPrevious(value:Boolean):void 
		{
			_sameXAsPrevious = value;
		}
		
		public function get sameYAsPrevious():Boolean 
		{
			return _sameYAsPrevious;
		}
		
		public function set sameYAsPrevious(value:Boolean):void 
		{
			_sameYAsPrevious = value;
		}
		
		public function get isXPositive():Boolean 
		{
			return _isXPositive;
		}
		
		public function set isXPositive(value:Boolean):void 
		{
			_isXPositive = value;
		}
		
		public function get isYPositive():Boolean 
		{
			return _isYPositive;
		}
		
		public function set isYPositive(value:Boolean):void 
		{
			_isYPositive = value;
		}
		
	}

}