package de.maxdidit.hardware.font.data.tables.advanced.gpos.marktoligature 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class LigatureArray 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _ligatureCount:uint;
		private var _ligatureAttachmentOffsets:Vector.<uint>;
		private var _ligatureAttachments:Vector.<LigatureAttachment>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function LigatureArray() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get ligatureCount():uint 
		{
			return _ligatureCount;
		}
		
		public function set ligatureCount(value:uint):void 
		{
			_ligatureCount = value;
		}
		
		public function get ligatureAttachmentOffsets():Vector.<uint> 
		{
			return _ligatureAttachmentOffsets;
		}
		
		public function set ligatureAttachmentOffsets(value:Vector.<uint>):void 
		{
			_ligatureAttachmentOffsets = value;
		}
		
		public function get ligatureAttachments():Vector.<LigatureAttachment> 
		{
			return _ligatureAttachments;
		}
		
		public function set ligatureAttachments(value:Vector.<LigatureAttachment>):void 
		{
			_ligatureAttachments = value;
		}
		
	}

}