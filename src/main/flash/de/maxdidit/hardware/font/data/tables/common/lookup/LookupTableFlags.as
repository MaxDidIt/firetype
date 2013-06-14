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
 
package de.maxdidit.hardware.font.data.tables.common.lookup  
{ 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class LookupTableFlags  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _rightToLeft:Boolean; 
		 
		private var _ignoreBaseGlyphs:Boolean; 
		private var _ignoreLigatures:Boolean; 
		private var _ignoreMarks:Boolean; 
		 
		private var _useMarkFilteringSet:Boolean; 
		 
		private var _markAttachmentType:Boolean; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function LookupTableFlags()  
		{ 
			 
		} 
		 
		/////////////////////// 
		// Member Properties 
		/////////////////////// 
		 
		public function get rightToLeft():Boolean  
		{ 
			return _rightToLeft; 
		} 
		 
		public function set rightToLeft(value:Boolean):void  
		{ 
			_rightToLeft = value; 
		} 
		 
		public function get ignoreBaseGlyphs():Boolean  
		{ 
			return _ignoreBaseGlyphs; 
		} 
		 
		public function set ignoreBaseGlyphs(value:Boolean):void  
		{ 
			_ignoreBaseGlyphs = value; 
		} 
		 
		public function get ignoreLigatures():Boolean  
		{ 
			return _ignoreLigatures; 
		} 
		 
		public function set ignoreLigatures(value:Boolean):void  
		{ 
			_ignoreLigatures = value; 
		} 
		 
		public function get ignoreMarks():Boolean  
		{ 
			return _ignoreMarks; 
		} 
		 
		public function set ignoreMarks(value:Boolean):void  
		{ 
			_ignoreMarks = value; 
		} 
		 
		public function get markAttachmentType():Boolean  
		{ 
			return _markAttachmentType; 
		} 
		 
		public function set markAttachmentType(value:Boolean):void  
		{ 
			_markAttachmentType = value; 
		} 
		 
		public function get useMarkFilteringSet():Boolean  
		{ 
			return _useMarkFilteringSet; 
		} 
		 
		public function set useMarkFilteringSet(value:Boolean):void  
		{ 
			_useMarkFilteringSet = value; 
		} 
		 
	} 
} 
