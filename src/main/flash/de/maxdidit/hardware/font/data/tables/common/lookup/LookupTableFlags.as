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