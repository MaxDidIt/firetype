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
			
			for (var i:uint = 0; i <= n; i++)
			{
				result[i] = factorialN / (factorial(i) * factorial(n - i));
			}
			
			return result;
		}
		
		public static function factorial(n:uint):Number
		{
			var result:Number = 1;
			
			for (var i:uint = 1; i <= n; i++)
			{
				result *= i;
			}
			
			return result;
		}
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function MaxMath() 
		{
			throw new Error("This class should not be instantiated");
		}
		
	}

}