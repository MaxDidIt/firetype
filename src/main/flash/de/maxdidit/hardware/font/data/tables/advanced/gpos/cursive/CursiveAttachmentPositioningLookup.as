package de.maxdidit.hardware.font.data.tables.advanced.gpos.cursive 
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.list.LinkedList;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class CursiveAttachmentPositioningLookup implements IGlyphLookup 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _entryExitRecord:EntryExitRecord;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function CursiveAttachmentPositioningLookup() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get entryExitRecord():EntryExitRecord 
		{
			return _entryExitRecord;
		}
		
		public function set entryExitRecord(value:EntryExitRecord):void 
		{
			_entryExitRecord = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup */
		
		public function performLookup(characterInstances:LinkedList):void 
		{
			throw new Error("Not yet implemented.");
		}
	}

}