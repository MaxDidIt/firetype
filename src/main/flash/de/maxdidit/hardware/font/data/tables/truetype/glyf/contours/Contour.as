package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours 
{
	import de.maxdidit.list.CircularLinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Contour 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _vertices:CircularLinkedList;
		private var _segments:Vector.<IPathSegment>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Contour() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get segments():Vector.<IPathSegment> 
		{
			return _segments;
		}
		
		public function set segments(value:Vector.<IPathSegment>):void 
		{
			_segments = value;
		}
		
		public function get vertices():CircularLinkedList
		{
			return _vertices;
		}
		
		public function set vertices(value:CircularLinkedList):void 
		{
			_vertices = value;
		}
		
	}

}