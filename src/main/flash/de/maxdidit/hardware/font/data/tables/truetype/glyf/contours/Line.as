/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
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
		 
		public function addVerticesToList(list:Vector.<Vertex>, vertexDistance:Number, addBackwards:Boolean):void  
		{ 
			if (_anchorA.x == _anchorB.x)
			{
				if (_anchorA.y == _anchorB.y)
				{
					return;
				}
			}
			
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
