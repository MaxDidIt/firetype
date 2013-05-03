package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours 
{
	import de.maxdidit.list.LinkedListElement;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class VertexListElement extends LinkedListElement 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _vertex:Vertex;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function VertexListElement($vertex:Vertex) 
		{
			this.vertex = $vertex;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get vertex():Vertex 
		{
			return _vertex;
		}
		
		public function set vertex(value:Vertex):void 
		{
			_vertex = value;
		}
		
	}

}