package de.maxdidit.hardware.font.data.tables.truetype.glyf.contours 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Vertex 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		public var x:Number;
		public var y:Number;
		
		public var onCurve:Boolean;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Vertex($x:Number = 0, $y:Number = 0, $onCurve:Boolean = true) 
		{
			x = $x;
			y = $y;
			
			onCurve = $onCurve;
		}
		
	}

}