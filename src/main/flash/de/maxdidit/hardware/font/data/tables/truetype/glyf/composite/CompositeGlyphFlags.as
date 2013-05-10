package de.maxdidit.hardware.font.data.tables.truetype.glyf.composite 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CompositeGlyphFlags 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _argumentsAreWords:Boolean;
		private var _argumentsAreXYValues:Boolean;
		
		private var _roundXYToGrids:Boolean;
		private var _weHaveAScale:Boolean;
		
		private var _moreComponents:Boolean;
		
		private var _weHaveAnXAndYScale:Boolean;
		private var _weHaveATwoByTwo:Boolean;
		private var _weHaveInstructions:Boolean;
		
		private var _useMyMetrics:Boolean;
		
		private var _overlapCompound:Boolean;
		
		private var _scaledComponentOffset:Boolean;
		private var _unscaledComponentOffset:Boolean;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CompositeGlyphFlags() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// argumentsAreWords
		
		public function get argumentsAreWords():Boolean 
		{
			return _argumentsAreWords;
		}
		
		public function set argumentsAreWords(value:Boolean):void 
		{
			_argumentsAreWords = value;
		}
		
		// argumentsAreXYValues
		
		public function get argumentsAreXYValues():Boolean 
		{
			return _argumentsAreXYValues;
		}
		
		public function set argumentsAreXYValues(value:Boolean):void 
		{
			_argumentsAreXYValues = value;
		}
		
		// roundXYToGrids
		
		public function get roundXYToGrids():Boolean 
		{
			return _roundXYToGrids;
		}
		
		public function set roundXYToGrids(value:Boolean):void 
		{
			_roundXYToGrids = value;
		}
		
		// weHaveAScale
		
		public function get weHaveAScale():Boolean 
		{
			return _weHaveAScale;
		}
		
		public function set weHaveAScale(value:Boolean):void 
		{
			_weHaveAScale = value;
		}
		
		// moreComponents
		
		public function get moreComponents():Boolean 
		{
			return _moreComponents;
		}
		
		public function set moreComponents(value:Boolean):void 
		{
			_moreComponents = value;
		}
		
		// weHaveAnXAndYScale
		
		public function get weHaveAnXAndYScale():Boolean 
		{
			return _weHaveAnXAndYScale;
		}
		
		public function set weHaveAnXAndYScale(value:Boolean):void 
		{
			_weHaveAnXAndYScale = value;
		}
		
		// weHaveATwoByTwo
		
		public function get weHaveATwoByTwo():Boolean 
		{
			return _weHaveATwoByTwo;
		}
		
		public function set weHaveATwoByTwo(value:Boolean):void 
		{
			_weHaveATwoByTwo = value;
		}
		
		// weHaveInstructions
		
		public function get weHaveInstructions():Boolean 
		{
			return _weHaveInstructions;
		}
		
		public function set weHaveInstructions(value:Boolean):void 
		{
			_weHaveInstructions = value;
		}
		
		// useMyMetrics
		
		public function get useMyMetrics():Boolean 
		{
			return _useMyMetrics;
		}
		
		public function set useMyMetrics(value:Boolean):void 
		{
			_useMyMetrics = value;
		}
		
		// overlapCompound
		
		public function get overlapCompound():Boolean 
		{
			return _overlapCompound;
		}
		
		public function set overlapCompound(value:Boolean):void 
		{
			_overlapCompound = value;
		}
		
		// scaledComponentOffset
		
		public function get scaledComponentOffset():Boolean 
		{
			return _scaledComponentOffset;
		}
		
		public function set scaledComponentOffset(value:Boolean):void 
		{
			_scaledComponentOffset = value;
		}
		
		// unscaledComponentOffset
		
		public function get unscaledComponentOffset():Boolean 
		{
			return _unscaledComponentOffset;
		}
		
		public function set unscaledComponentOffset(value:Boolean):void 
		{
			_unscaledComponentOffset = value;
		}
		
	}

}