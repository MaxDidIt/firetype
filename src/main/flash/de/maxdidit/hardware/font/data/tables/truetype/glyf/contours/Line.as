package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Line implements IPathSegment
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		protected var _anchorA:Vertex;
		protected var _anchorB:Vertex;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Line($anchorA:Vertex = null, $anchorB:Vertex = null) 
		{
			this._anchorA = $anchorA;
			this._anchorB = $anchorB;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.IPath */
		
		public function get anchorA():Vertex 
		{
			return _anchorA;
		}
		
		public function set anchorA(value:Vertex):void 
		{
			_anchorA = value;
		}
		
		public function get anchorB():Vertex 
		{
			return _anchorB;
		}
		
		public function set anchorB(value:Vertex):void 
		{
			_anchorB = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addVerticesToList(list:Vector.<Vertex>, subdivisions:uint, addBackwards:Boolean):void 
		{
			// ignore subdivisions, a line always has the same number of points.
			// only add anchor B. Anchor A should have been added by the previous path segment.
			if (addBackwards)
			{
				list.unshift(_anchorB);
			}
			else
			{
				list.push(_anchorB);
			}
		}
		
	}

}