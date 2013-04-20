package de.maxdidit.hardware.font.data.tables.maxp 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MaximumProfileTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _version:Number;
		
		private var _numGlyphs:uint;
		
		private var _maxPoints:uint; // Maximum points in a non-composite glyph.
		private var _maxContours:uint; // Maximum contours in a non-composite glyph.
		private var _maxCompositePoints:uint; // Maximum points in a composite glyph.
		private var _maxCompositeContours:uint; // Maximum contours in a composite glyph.
		
		private var _maxZones:uint; // 1 if instructions do not use the twilight zone (Z0), or 2 if instructions do use Z0; should be set to 2 in most cases.
		private var _maxTwilightPoint:uint; // Maximum points used in Z0.
		
		private var _maxStorage:uint; // Number of Storage Area locations.
		
		private var _maxFunctionDefs:uint; // Number of FDEFs.
		private var _maxInstructionDefs:uint; // Number of IDEFs.
		
		private var _maxStackElements:uint; // Maximum stack depth^2.
		
		private var _maxSizeOfInstructions:uint; // Maximum byte count for glyph instructions.
		
		private var _maxComponentElements:uint; // Maximum number of components referenced at “top level” for any composite glyph.
		private var _maxComponentDepth:uint; // Maximum levels of recursion; 1 for simple components.
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MaximumProfileTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get version():Number 
		{
			return _version;
		}
		
		public function set version(value:Number):void 
		{
			_version = value;
		}
		
		public function get numGlyphs():uint 
		{
			return _numGlyphs;
		}
		
		public function set numGlyphs(value:uint):void 
		{
			_numGlyphs = value;
		}
		
		public function get maxPoints():uint 
		{
			return _maxPoints;
		}
		
		public function set maxPoints(value:uint):void 
		{
			_maxPoints = value;
		}
		
		public function get maxContours():uint 
		{
			return _maxContours;
		}
		
		public function set maxContours(value:uint):void 
		{
			_maxContours = value;
		}
		
		public function get maxCompositePoints():uint 
		{
			return _maxCompositePoints;
		}
		
		public function set maxCompositePoints(value:uint):void 
		{
			_maxCompositePoints = value;
		}
		
		public function get maxCompositeContours():uint 
		{
			return _maxCompositeContours;
		}
		
		public function set maxCompositeContours(value:uint):void 
		{
			_maxCompositeContours = value;
		}
		
		public function get maxZones():uint 
		{
			return _maxZones;
		}
		
		public function set maxZones(value:uint):void 
		{
			_maxZones = value;
		}
		
		public function get maxTwilightPoint():uint 
		{
			return _maxTwilightPoint;
		}
		
		public function set maxTwilightPoint(value:uint):void 
		{
			_maxTwilightPoint = value;
		}
		
		public function get maxStorage():uint 
		{
			return _maxStorage;
		}
		
		public function set maxStorage(value:uint):void 
		{
			_maxStorage = value;
		}
		
		public function get maxFunctionDefs():uint 
		{
			return _maxFunctionDefs;
		}
		
		public function set maxFunctionDefs(value:uint):void 
		{
			_maxFunctionDefs = value;
		}
		
		public function get maxInstructionDefs():uint 
		{
			return _maxInstructionDefs;
		}
		
		public function set maxInstructionDefs(value:uint):void 
		{
			_maxInstructionDefs = value;
		}
		
		public function get maxStackElements():uint 
		{
			return _maxStackElements;
		}
		
		public function set maxStackElements(value:uint):void 
		{
			_maxStackElements = value;
		}
		
		public function get maxSizeOfInstructions():uint 
		{
			return _maxSizeOfInstructions;
		}
		
		public function set maxSizeOfInstructions(value:uint):void 
		{
			_maxSizeOfInstructions = value;
		}
		
		public function get maxComponentElements():uint 
		{
			return _maxComponentElements;
		}
		
		public function set maxComponentElements(value:uint):void 
		{
			_maxComponentElements = value;
		}
		
		public function get maxComponentDepth():uint 
		{
			return _maxComponentDepth;
		}
		
		public function set maxComponentDepth(value:uint):void 
		{
			_maxComponentDepth = value;
		}
		
	}

}