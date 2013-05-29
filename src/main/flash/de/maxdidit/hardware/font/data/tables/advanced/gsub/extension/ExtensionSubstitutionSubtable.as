package de.maxdidit.hardware.font.data.tables.advanced.gsub.extension 
{
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class ExtensionSubstitutionSubtable implements ILookupSubtable 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _extensionLookupType:uint;
		private var _extensionOffset:uint;
		private var _extensionSubtable:ILookupSubtable;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function ExtensionSubstitutionSubtable() 
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
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.ILookupSubtable */
		
		public function performLookup(characterInstances:LinkedList, parent:ScriptFeatureLookupTable):void 
		{
			_extensionSubtable.performLookup(characterInstances, parent);
		}
		
	}

}