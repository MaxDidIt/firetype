package de.maxdidit.hardware.text.glyphbuilders 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareGlyph;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface IGlyphBuilder
	{
		function buildGlyph(paths:Vector.<Vector.<Vertex>>, originalPaths:Vector.<Vector.<Vertex>>):HardwareGlyph;
	}
	
}