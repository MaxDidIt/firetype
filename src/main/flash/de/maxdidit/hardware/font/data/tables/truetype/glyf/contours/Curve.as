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
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Curve($controlPoints:Vector.<Vertex> = null) 
		{
			if ($controlPoints)
			{
				_controlPoints = $controlPoints;
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
			var n:uint = _controlPoints.length;
			
			// binomial coefficients for each vertex
			var coefficients:Vector.<Number> = MaxMath.calculateBinomialCoefficients(n);
			
			for (var s:uint = 1; s < subdivisions; s++)
			{
				var t:Number = Number(s) / Number(subdivisions);
				var vertex:Vertex = new Vertex();
				
				// iterate over control points
				for (var i:uint = 0; i < n; i++)
				{
					var weight:Number = bernsteinPolynomial(coefficients, i, n, t);
					
					vertex.x += _controlPoints[i].x * weight;
					vertex.y += _controlPoints[i].y * weight;
				}
				
				list.push(_controlPoints);
			}
			
			// add second anchor point
			list.push(_controlPoints[n - 1]);
			
			super.addVerticesToList(list, subdivisions);
		}
		
		private function bernsteinPolynomial(coefficients:Vector.<Number>, i:uint, n:uint, t:Number):Number
		{
			return bernsteinPolynomial[i] * Math.pow(t, i) * Math.pow(1 - t, n - i);
		}
		
	}

}