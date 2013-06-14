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
 
package de.maxdidit.hardware.text.layout  
{ 
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData; 
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable; 
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable; 
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTable; 
	import de.maxdidit.hardware.font.HardwareFont; 
	import de.maxdidit.hardware.font.parser.tables.TableNames; 
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance; 
	import de.maxdidit.hardware.text.components.HardwareLine; 
	import de.maxdidit.hardware.text.components.HardwareWord; 
	import de.maxdidit.hardware.text.components.TextSpan; 
	import de.maxdidit.hardware.text.format.HardwareTextFormat; 
	import de.maxdidit.list.LinkedList; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class Printhead  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		public var lineX:Number = 0; 
		public var wordX:Number = 0; 
		public var y:Number = 0; 
		 
		public var currentLine:HardwareLine; 
		public var currentWord:HardwareWord; 
		 
		private var _textSpan:TextSpan; 
		public var textFormat:HardwareTextFormat; 
		public var font:HardwareFont; 
		 
		public var lookupIndices:Vector.<int>; 
		public var characterInstances:LinkedList; 
		public var glyphInstances:Vector.<HardwareGlyphInstance>; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function Printhead()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get textSpan():TextSpan  
		{ 
			return _textSpan; 
		} 
		 
		public function set textSpan(value:TextSpan):void  
		{ 
			_textSpan = value; 
			 
			textFormat = _textSpan.textFormat; 
			font = textFormat.font; 
			 
			characterInstances = _textSpan.characterInstances; 
		} 
		 
		/////////////////////// 
		// Member Functions 
		/////////////////////// 
	} 
} 
