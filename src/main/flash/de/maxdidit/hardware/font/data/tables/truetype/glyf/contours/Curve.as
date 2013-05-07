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
		private var _coefficients:Vector.<Number>;
		
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
				_coefficients = MaxMath.calculateBinomialCoefficients(n);
				
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
		
		public function addVerticesToList(list:Vector.<Vertex>, subdivisions:uint):void 
		{
			const n:uint = _controlPoints.length - 1;
			
			const l:uint = subdivisions + 1;
			
			for (var s:uint = 1; s < l; s++)
			{
				var t:Number = Number(s) / Number(l);
				var vertex:Vertex = new Vertex();
				
				// iterate over control points
				for (var i:uint = 0; i <= n; i++)
				{
					var weight:Number = bernsteinPolynomial(_coefficients, i, n, t);
					
					vertex.x += _controlPoints[i].x * weight;
					vertex.y += _controlPoints[i].y * weight;
				}
				
				list.push(vertex);
			}
			
			// add second anchor point
			list.push(_controlPoints[n]);
		}
		
		private function bernsteinPolynomial(coefficients:Vector.<Number>, i:uint, n:uint, t:Number):Number
		{
			var factor1:Number = Math.pow(t, i);
			var factor2:Number = Math.pow(1 - t, n - i);
			return coefficients[i] * factor1 * factor2;
		}
		
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