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
 
package de.maxdidit.hardware.font 
{ 
	import org.flexunit.rules.IMethodRule; 
	import org.mockito.integrations.flexunit4.MockitoRule; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	 
	public class HardwareFontTest 
	{ 
		/////////////////////// 
		// Rules 
		/////////////////////// 
		 
		[Rule] 
		public var mockitoRule:IMethodRule = new MockitoRule(); 
		 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _hardwareFont:HardwareFont; 
		 
		/////////////////////// 
		// Start Up 
		/////////////////////// 
		 
		[Before] 
		 
		public function startUp():void 
		{ 
			//_hardwareFont = new HardwareFont(); 
		} 
		 
		/////////////////////// 
		// Tear Down 
		/////////////////////// 
		 
		[After] 
		 
		public function tearDown():void 
		{ 
			//_hardwareFont = null; 
		} 
		 
		/////////////////////// 
		// Unit Tests 
		/////////////////////// 
		 
		[Test] 
		 
		public function testLoadFont():void 
		{ 
			 
		} 
	 
	} 
} 
