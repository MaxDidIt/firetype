package de.maxdidit.list.elements 
{
	import de.maxdidit.list.LinkedListElement;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class UnsignedIntegerListElement extends LinkedListElement 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _value:uint;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function UnsignedIntegerListElement(value:uint) 
		{
			this.value = value;
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// value
		
		public function get value():uint 
		{
			return _value;
		}
		
		public function set value(value:uint):void 
		{
			_value = value;
		}
		
	}

}