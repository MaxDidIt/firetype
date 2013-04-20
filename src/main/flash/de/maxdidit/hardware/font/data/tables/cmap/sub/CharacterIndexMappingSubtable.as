package de.maxdidit.hardware.font.data.tables.cmap.sub 
{
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CharacterIndexMappingSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _platformID:uint;
		private var _encodingID:uint;
		private var _offset:uint;
		
		private var _data:ICharacterIndexMappingSubtableData;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CharacterIndexMappingSubtable()
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// platformID
		
		public function get platformID():uint 
		{
			return _platformID;
		}
		
		public function set platformID(value:uint):void 
		{
			_platformID = value;
		}
		
		// encodingID
		
		public function get encodingID():uint 
		{
			return _encodingID;
		}
		
		public function set encodingID(value:uint):void 
		{
			_encodingID = value;
		}
		
		// offset
		
		public function get offset():uint 
		{
			return _offset;
		}
		
		public function set offset(value:uint):void 
		{
			_offset = value;
		}
		
		// data
		
		public function get data():ICharacterIndexMappingSubtableData 
		{
			return _data;
		}
		
		public function set data(value:ICharacterIndexMappingSubtableData):void 
		{
			_data = value;
		}
	}
	
}