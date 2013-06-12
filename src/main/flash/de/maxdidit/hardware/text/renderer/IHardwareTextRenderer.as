package de.maxdidit.hardware.text.renderer 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.cache.TextColorMap;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface IHardwareTextRenderer 
	{
		function addPathsToRenderer(paths:Vector.<Vector.<Vertex>>):HardwareGlyph;
		function render(instanceMap:Object, textColorMap:TextColorMap):void;
		
		function clear():void;
	}
	
}