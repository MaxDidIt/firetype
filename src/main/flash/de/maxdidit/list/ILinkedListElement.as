package de.maxdidit.list 
{
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ILinkedListElement 
	{
		// next
		
		function get next():ILinkedListElement;
		function set next(value:ILinkedListElement):void;
		
		// previous
		
		function get previous():ILinkedListElement;
		function set previous(value:ILinkedListElement):void;
	}
	
}