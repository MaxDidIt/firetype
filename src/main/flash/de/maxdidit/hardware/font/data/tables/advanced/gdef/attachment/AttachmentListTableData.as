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
 
package de.maxdidit.hardware.font.data.tables.advanced.gdef.attachment 
{
	import de.maxdidit.hardware.font.data.tables.common.coverage.ICoverageTable;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class AttachmentListTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _glyphCoverageOffset:uint;
		private var _glyphCount:uint;
		
		private var _coverage:ICoverageTable;
		
		private var _attachmentPointOffsets:Vector.<uint>;
		private var _attachmentPointTables:Vector.<AttachmentPointTableData>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function AttachmentListTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// glyphCoverageOffset
		
		public function get glyphCoverageOffset():uint 
		{
			return _glyphCoverageOffset;
		}
		
		public function set glyphCoverageOffset(value:uint):void 
		{
			_glyphCoverageOffset = value;
		}
		
		// glyphCount
		
		public function get glyphCount():uint 
		{
			return _glyphCount;
		}
		
		public function set glyphCount(value:uint):void 
		{
			_glyphCount = value;
		}
		
		// attachmentPointOffsets
		
		public function get attachmentPointOffsets():Vector.<uint> 
		{
			return _attachmentPointOffsets;
		}
		
		public function set attachmentPointOffsets(value:Vector.<uint>):void 
		{
			_attachmentPointOffsets = value;
		}
		
		// attachmentPointTables
		
		public function get attachmentPointTables():Vector.<AttachmentPointTableData> 
		{
			return _attachmentPointTables;
		}
		
		public function set attachmentPointTables(value:Vector.<AttachmentPointTableData>):void 
		{
			_attachmentPointTables = value;
		}
		
		// coverage
		
		public function get coverage():ICoverageTable 
		{
			return _coverage;
		}
		
		public function set coverage(value:ICoverageTable):void 
		{
			_coverage = value;
		}
		
		
		
	}

}