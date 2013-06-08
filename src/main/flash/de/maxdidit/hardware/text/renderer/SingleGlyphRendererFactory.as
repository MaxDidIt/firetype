package de.maxdidit.hardware.text.renderer 
{
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import flash.display3D.Context3D;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SingleGlyphRendererFactory implements IHardwareTextRendererFactory
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var context3d:Context3D;
		private var triangulator:ITriangulator;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SingleGlyphRendererFactory(context3d:Context3D, triangulator:ITriangulator) 
		{
			this.context3d = context3d;
			this.triangulator = triangulator;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.text.renderer.IHardwareTextRendererFactory */
		
		public function retrieveHardwareTextRenderer():IHardwareTextRenderer 
		{
			var renderer:SingleGlyphRenderer = new SingleGlyphRenderer(context3d, triangulator);
			return renderer;
		}
		
	}

}