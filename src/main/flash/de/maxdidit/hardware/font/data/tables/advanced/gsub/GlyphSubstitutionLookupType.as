package de.maxdidit.hardware.font.data.tables.advanced.gsub 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class GlyphSubstitutionLookupType 
	{
		///////////////////////
		// Constants
		///////////////////////
	
		public static const SINGLE_SUBSTITUTION:uint						= 1;
		public static const MULTIPLE_SUBSTITUTION:uint						= 2;
		public static const ALTERNATE_SUBSTITUTION:uint						= 3;
		public static const LIGATURE_SUBSTITUTION:uint						= 4;
		public static const CONTEXTUAL_SUBSTITUTION:uint					= 5;
		public static const CHAINING_CONTEXTUAL_SUBSTITUTION:uint			= 6;
		public static const EXTENSION_SUBSTITUTION:uint						= 7;
		public static const REVERSE_CHAINING_CONTEXTUAL_SUBSTITUTION:uint	= 8;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function GlyphSubstitutionLookupType() 
		{
			throw new Error("This class is not supposed to be instantiated.");
		}
		
	}

}