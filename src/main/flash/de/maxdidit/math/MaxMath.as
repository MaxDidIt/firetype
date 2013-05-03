package de.maxdidit.math 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class MaxMath 
	{
		///////////////////////
		// Static Functions
		///////////////////////
		
		public static function calculateBinomialCoefficients(n:uint):Vector.<Number> 
		{
			var result:Vector.<Number> = new Vector.<Number>(n);
			
			var factorialN:Number = factorial(n);
			
			for (var i:uint = 0; i < n; i++)
			{
				result[i] = factorialN / (factorial(i) * factorial(n - i));
			}
			
			return result;
		}
		
		public static function factorial(n:uint):Number
		{
			var result:Number = 1;
			
			for (var i:uint = 1; i < n; i++)
			{
				result *= i;
			}
			
			return result;
		}
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Math() 
		{
			throw new Error("This class should not be instantiated");
		}
		
	}

}