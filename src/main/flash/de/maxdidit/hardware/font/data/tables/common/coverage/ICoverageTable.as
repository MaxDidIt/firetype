package de.maxdidit.hardware.font.data.tables.common.coverage 
{
	import de.maxdidit.hardware.font.data.tables.common.lookup.IGlyphLookup;
	import de.maxdidit.hardware.font.HardwareFont;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ICoverageTable 
	{
		function getCoverageIndex(glyphIndex:uint):int;
		function iterateOverCoveredIndices(callback:Function, font:HardwareFont):void;
	}

}