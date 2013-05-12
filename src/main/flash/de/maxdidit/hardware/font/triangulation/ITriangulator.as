package de.maxdidit.hardware.font.triangulation 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public interface ITriangulator 
	{
		function triangulatePath(path:Vector.<Vertex>, result:Vector.<uint>, indexOffset:uint):uint
	}
	
}