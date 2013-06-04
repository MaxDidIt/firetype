package de.maxdidit.hardware.text.tags 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class TextTag 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const ID_FORMAT:uint = 0;
		public static const ID_FORMAT_CLOSED:uint = 1;
		
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _id:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function TextTag() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get id():uint 
		{
			return _id;
		}
		
		public function set id(value:uint):void 
		{
			_id = value;
		}
		
	}

}