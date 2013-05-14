package de.maxdidit.hardware.font.data.tables.common.language 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LanguageSystemTable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _requiredFeatureIndex:uint;
		private var _featureCount:uint;
		private var _featureIndex:Vector.<uint>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LanguageSystemTable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get requiredFeatureIndex():uint 
		{
			return _requiredFeatureIndex;
		}
		
		public function set requiredFeatureIndex(value:uint):void 
		{
			_requiredFeatureIndex = value;
		}
		
		public function get featureCount():uint 
		{
			return _featureCount;
		}
		
		public function set featureCount(value:uint):void 
		{
			_featureCount = value;
		}
		
		public function get featureIndex():Vector.<uint> 
		{
			return _featureIndex;
		}
		
		public function set featureIndex(value:Vector.<uint>):void 
		{
			_featureIndex = value;
		}
		
	}

}