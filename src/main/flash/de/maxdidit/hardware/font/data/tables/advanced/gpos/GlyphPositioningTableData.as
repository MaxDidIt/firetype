package de.maxdidit.hardware.font.data.tables.advanced.gpos 
{
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptListTableData;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphPositioningTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _version:Number;
		
		private var _scriptListOffset:uint;
		private var _featuresListOffset:uint;
		private var _lookupListOffset:uint;
		
		private var _scriptList:ScriptListTableData;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphPositioningTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get version():Number 
		{
			return _version;
		}
		
		public function set version(value:Number):void 
		{
			_version = value;
		}
		
		public function get scriptListOffset():uint 
		{
			return _scriptListOffset;
		}
		
		public function set scriptListOffset(value:uint):void 
		{
			_scriptListOffset = value;
		}
		
		public function get featuresListOffset():uint 
		{
			return _featuresListOffset;
		}
		
		public function set featuresListOffset(value:uint):void 
		{
			_featuresListOffset = value;
		}
		
		public function get lookupListOffset():uint 
		{
			return _lookupListOffset;
		}
		
		public function set lookupListOffset(value:uint):void 
		{
			_lookupListOffset = value;
		}
		
		public function get scriptListTable():ScriptListTableData 
		{
			return _scriptList;
		}
		
		public function set scriptListTable(value:ScriptListTableData):void 
		{
			_scriptList = value;
		}
		
	}

}