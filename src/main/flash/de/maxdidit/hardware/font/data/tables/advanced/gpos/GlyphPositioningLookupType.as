package de.maxdidit.hardware.font.data.tables.advanced.gpos 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphPositioningLookupType 
	{
		///////////////////////
		// Constants
		///////////////////////
		
		public static const SINGLE_ADJUSTMENT:uint				= 1;
		public static const PAIR_ADJUSTMENT:uint				= 2;
		public static const CURSIVE_ATTACHMENT:uint				= 3;
		public static const MARK_TO_BASE_ATTACHMENT:uint		= 4;
		public static const MARK_TO_LIGATURE_ATTACHMENT:uint	= 5;
		public static const MARK_TO_MARK_ATTACHMENT:uint		= 6;
		public static const CONTEXT_POSITIONING:uint			= 7;
		public static const CHAINED_CONTEXT_POSITIONING:uint	= 8;
		public static const EXTENSION_POSITIONING:uint			= 9;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphPositioningLookupType() 
		{
			throw new Error("This class is not supposed to be instantiated.");
		}
		
	}

}