package de.maxdidit.hardware.text.tags 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FormatTag extends TextTag 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _formatId:String;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FormatTag() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get formatId():String 
		{
			return _formatId;
		}
		
		public function set formatId(value:String):void 
		{
			_formatId = value;
		}
		
	}

}