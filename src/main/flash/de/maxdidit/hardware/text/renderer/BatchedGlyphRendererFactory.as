/* 
'firetype' is an ActionScript 3 library which loads font files and renders characters via the GPU. 
Copyright ©2013 Max Knoblich 
www.maxdid.it 
me@maxdid.it 
 
This file is part of 'firetype' by Max Did It. 
  
'firetype' is free software: you can redistribute it and/or modify 
it under the terms of the GNU Lesser General Public License as published by 
the Free Software Foundation, either version 3 of the License, or 
(at your option) any later version. 
  
'firetype' is distributed in the hope that it will be useful, 
but WITHOUT ANY WARRANTY; without even the implied warranty of 
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
GNU Lesser General Public License for more details. 
 
You should have received a copy of the GNU Lesser General Public License 
along with 'firetype'.  If not, see <http://www.gnu.org/licenses/>. 
*/ 
 
package de.maxdidit.hardware.text.renderer  
{ 
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator; 
	import de.maxdidit.hardware.font.triangulation.ITriangulator; 
	import flash.display3D.Context3D; 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class BatchedGlyphRendererFactory implements IHardwareTextRendererFactory 
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var context3d:Context3D; 
		private var triangulator:ITriangulator; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function BatchedGlyphRendererFactory(context3d:Context3D, triangulator:ITriangulator)  
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
			var renderer:BatchedGlyphRenderer = new BatchedGlyphRenderer(context3d, triangulator); 
			return renderer; 
		} 
		 
	} 
} 
