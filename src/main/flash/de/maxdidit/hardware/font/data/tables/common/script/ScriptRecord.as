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
 
package de.maxdidit.hardware.font.data.tables.common.script  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class ScriptRecord  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _scriptTag:String; 
		private var _scriptOffset:uint; 
		private var _script:ScriptTable; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function ScriptRecord()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get scriptTag():String 
		{ 
			return _scriptTag; 
		} 
		 
		public function set scriptTag(value:String):void  
		{ 
			_scriptTag = value; 
		} 
		 
		public function get scriptOffset():uint  
		{ 
			return _scriptOffset; 
		} 
		 
		public function set scriptOffset(value:uint):void  
		{ 
			_scriptOffset = value; 
		} 
		 
		public function get script():ScriptTable  
		{ 
			return _script; 
		} 
		 
		public function set script(value:ScriptTable):void  
		{ 
			_script = value; 
		} 
		 
	} 
} 
