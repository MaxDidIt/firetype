/* 
Copyright ©2013 Max Knoblich 
 
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
	import de.maxdidit.math.MaxMath;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Curve implements IPathSegment 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _controlPoints:Vector.<Vertex>;
		//private var _coefficients:Vector.<Number>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Curve($controlPoints:Vector.<Vertex> = null) 
		{
			if ($controlPoints)
			{
				_controlPoints = $controlPoints;
				
				// binomial coefficients for each vertex
				const n:uint = _controlPoints.length - 1;
				//_coefficients = MaxMath.calculateBinomialCoefficients(n);
				
				// bounding box
				calculateBoundingBox();
			}
			else
			{
				_controlPoints = new Vector.<Vertex>();
			}
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.IPathSegment */
		
		public function get anchorA():Vertex 
		{
			return _controlPoints[0];
		}
		
		public function set anchorA(value:Vertex):void 
		{
			if (_controlPoints.length < 1)
			{
				_controlPoints.length = 1;
			}
			
			_controlPoints[0] = value;
		}
		
		public function get anchorB():Vertex 
		{
			if (_controlPoints.length < 1)
			{
				_controlPoints.length = 1;
			}
			
			return _controlPoints[_controlPoints.length - 1];
		}
		
		public function set anchorB(value:Vertex):void 
		{
			if (_controlPoints.length < 1)
			{
				_controlPoints.length = 1;
			}
			
			_controlPoints[_controlPoints.length - 1] = value;
		}
		
		// controlPoints
		
		public function get controlPoints():Vector.<Vertex> 
		{
			return _controlPoints;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addVerticesToList(list:Vector.<Vertex>, vertexDistance:Number, addBackwards:Boolean):void 
		{
			const n:uint = _controlPoints.length - 1;
			
			//const l:uint = subdivisions + 1;
			
			var t:Number = 0;
			var it:Number = 1 - t;
				
			var derivation_X:Number = -2 * _controlPoints[0].x + 2 * _controlPoints[1].x + _controlPoints[2].x;
			var derivation_Y:Number = -2 * _controlPoints[0].y + 2 * _controlPoints[1].y + _controlPoints[2].y;
			var derivation:Number = Math.sqrt(derivation_X * derivation_X + derivation_Y * derivation_Y);
			
			t += vertexDistance / derivation;
			
			while (t < 1)
			{
				var vertex:Vertex = new Vertex();
				it = 1 - t;
				
				vertex.x = it * it * _controlPoints[0].x + 2 * t * it * _controlPoints[1].x + t * t * _controlPoints[2].x;
				vertex.y = it * it * _controlPoints[0].y + 2 * t * it * _controlPoints[1].y + t * t * _controlPoints[2].y;
				
				derivation_X = -2 * it * _controlPoints[0].x + (2 * it - 2 * t) * _controlPoints[1].x + 2 * t * _controlPoints[2].x;
				derivation_Y = -2 * it * _controlPoints[0].y + (2 * it - 2 * t) * _controlPoints[1].y + 2 * t * _controlPoints[2].y;
				derivation = Math.sqrt(derivation_X * derivation_X + derivation_Y * derivation_Y);
				
				t += vertexDistance / derivation;
				
				if (addBackwards)
				{
					list.unshift(vertex);
				}
				else
				{
					list.push(vertex);
				}
			}
			
			// add second anchor point
			if (addBackwards)
			{
				list.unshift(_controlPoints[n]);
			}
			else
			{
				list.push(_controlPoints[n]);
			}
		}
		
		//private function bernsteinPolynomial(coefficients:Vector.<Number>, i:uint, n:uint, t:Number):Number
		//{
			//var factor1:Number = Math.pow(t, i);
			//var factor2:Number = Math.pow(1 - t, n - i);
			//return coefficients[i] * factor1 * factor2;
		//}
		
		private function calculateBoundingBox():void 
		{
			const l:uint = _controlPoints.length;
			
			var minX:Number = Number.MAX_VALUE;
			var minY:Number = Number.MAX_VALUE;
			
			var maxX:Number = Number.MIN_VALUE;
			var maxY:Number = Number.MIN_VALUE;
			
			var currentVertex:Vertex;
			
			for (var i:uint = 0; i < l; i++)
			{
				currentVertex = _controlPoints[i];
				
				minX = currentVertex.x < minX ? currentVertex.x : minX;
				minY = currentVertex.y < minY ? currentVertex.y : minY;
				
				maxX = currentVertex.x < maxX ? currentVertex.x : maxX;
				maxY = currentVertex.y < maxY ? currentVertex.y : maxY;
			}
			
			
		}
		
	}

}