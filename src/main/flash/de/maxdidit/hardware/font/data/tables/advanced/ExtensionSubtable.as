package de.maxdidit.hardware.font.data.tables.advanced 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.LookupTable;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ExtensionSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _extensionLookupType:uint;
		private var _extensionOffset:uint;
		private var _extensionSubtable:ILookupSubtable;
		
		private var _parent:LookupTable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ExtensionSubtable() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get extensionLookupType():uint 
		{
			return _extensionLookupType;
		}
		
		public function set extensionLookupType(value:uint):void 
		{
			_extensionLookupType = value;
		}
		
		public function get extensionOffset():uint 
		{
			return _extensionOffset;
		}
		
		public function set extensionOffset(value:uint):void 
		{
			_extensionOffset = value;
		}
		
		public function get extensionSubtable():ILookupSubtable 
		{
			return _extensionSubtable;
		}
		
		public function set extensionSubtable(value:ILookupSubtable):void 
		{
			_extensionSubtable = value;
			if (_extensionSubtable)
			{
				_extensionSubtable.parent = _parent;
			}
		}
		
		public function get parent():LookupTable 
		{
			return _parent;
		}
		
		public function set parent(value:LookupTable):void 
		{
			_parent = value;
			if (_extensionSubtable)
			{
				_extensionSubtable.parent = _parent;
			}
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		//public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		//{
			//_extensionSubtable.performLookup(characterInstances, parent);
		//}
		
		public function resolveDependencies(parent:ScriptFeatureLookupTable, font:HardwareFont):void 
		{
			_extensionSubtable.resolveDependencies(parent, font);
		}
		
		public function retrieveGlyphLookup(glyphIndex:uint, coverageIndex:uint, font:HardwareFont):IGlyphLookup 
		{
			return _extensionSubtable.retrieveGlyphLookup(glyphIndex, coverageIndex, font);
		}
		
	}

}