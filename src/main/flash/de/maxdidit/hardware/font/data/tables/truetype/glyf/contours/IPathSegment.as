package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours 
{
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface IPathSegment 
	{
		function get anchorA():Vertex;
		function set anchorA(anchor:Vertex):void;
		
		function get anchorB():Vertex;
		function set anchorB(anchor:Vertex):void;
		
		function addVerticesToList(list:Vector.<Vertex>, vertexDistance:Number, addBackwards:Boolean):void;
	}
	
}