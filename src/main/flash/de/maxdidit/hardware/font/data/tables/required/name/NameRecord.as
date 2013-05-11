package de.maxdidit.hardware.font.data.tables.required.name 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class NameRecord 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _platformID:uint;
		private var _encodingID:uint;
		private var _languageID:uint;
		private var _nameID:uint;
		private var _length:uint;
		private var _offset:uint;
		
		private var _string:String;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function NameRecord() 
		{
			
		}
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		public function get platformID():uint 
		{
			return _platformID;
		}
		
		public function set platformID(value:uint):void 
		{
			_platformID = value;
		}
		
		public function get encodingID():uint 
		{
			return _encodingID;
		}
		
		public function set encodingID(value:uint):void 
		{
			_encodingID = value;
		}
		
		public function get languageID():uint 
		{
			return _languageID;
		}
		
		public function set languageID(value:uint):void 
		{
			_languageID = value;
		}
		
		public function get nameID():uint 
		{
			return _nameID;
		}
		
		public function set nameID(value:uint):void 
		{
			_nameID = value;
		}
		
		public function get length():uint 
		{
			return _length;
		}
		
		public function set length(value:uint):void 
		{
			_length = value;
		}
		
		public function get offset():uint 
		{
			return _offset;
		}
		
		public function set offset(value:uint):void 
		{
			_offset = value;
		}
		
		public function get string():String 
		{
			return _string;
		}
		
		public function set string(value:String):void 
		{
			_string = value;
		}
		
	}

}