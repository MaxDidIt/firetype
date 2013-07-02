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
 
package de.maxdidit.hardware.font  
{ 
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator; 
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache; 
	import de.maxdidit.hardware.text.HardwareText; 
	import de.maxdidit.hardware.text.renderer.BatchedGlyphRendererFactory; 
	import flash.display.Sprite; 
	import flash.display.Stage3D; 
	import flash.display.StageAlign; 
	import flash.display.StageScaleMode; 
	import flash.display3D.Context3D; 
	import flash.display3D.Context3DRenderMode; 
	import flash.events.ErrorEvent; 
	import flash.events.Event; 
	import flash.geom.Matrix3D; 
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class FiretypeTutorial7 extends Sprite  
	{ 
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _context3d:Context3D; 
		private var _hardwareText1:HardwareText; 
		private var _hardwareText2:HardwareText; 
		private var _cache:HardwareCharacterCache; 
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function FiretypeTutorial7()  
		{ 
			// stage properties 
			this.stage.scaleMode = StageScaleMode.NO_SCALE; 
			this.stage.align = StageAlign.TOP_LEFT; 
			this.stage.frameRate = 60; 
			 
			// init stage3d 
			var stage3d:Stage3D = this.stage.stage3Ds[0]; 
			stage3d.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated); 
			stage3d.addEventListener(ErrorEvent.ERROR, handleContextCreationError); 
			stage3d.requestContext3D(Context3DRenderMode.AUTO); 
		} 
		 
		private function initializeView():void  
		{ 
			_context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 8, false); 
			 
			// Create very basic, orthogonal projection matrix. 
			var viewProjectionRawData:Vector.<Number> = new Vector.<Number>(); 
			viewProjectionRawData.push(	2 / stage.stageWidth, 0, 0, 0, // 
										0, 2 / stage.stageHeight, 0, 0, // 
										0, 0, -2, -1, // 
										0, 0, 0, 1); 
			 
			var viewProjection:Matrix3D = new Matrix3D(viewProjectionRawData); 
			 
			_hardwareText1.calculateTransformations(viewProjection, true); 
			_hardwareText2.calculateTransformations(viewProjection, true); 
		} 
		 
		private function initializeText():void  
		{ 
			_cache = new HardwareCharacterCache(new BatchedGlyphRendererFactory(_context3d)); 
			_hardwareText1 = new HardwareText(null, _cache); 
			 
			_hardwareText1.scaleX = _hardwareText1.scaleY = 0.013; 
			_hardwareText1.x = -320; 
			_hardwareText1.y = 300; 
			_hardwareText1.width = 300; 
			 
			_hardwareText1.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris scelerisque turpis non sem placerat vehicula. In at viverra nunc, ac pulvinar enim. Praesent pulvinar ac leo sed aliquet. Interdum et malesuada fames ac ante ipsum primis in faucibus. Duis scelerisque tincidunt suscipit. Maecenas ac ipsum cursus, rutrum turpis ac, ultricies magna. Quisque sagittis nunc a sagittis feugiat. Etiam tincidunt sit amet lectus a elementum. Vivamus est nisi, tincidunt eget sem non, mattis convallis lorem. Aliquam eu ultrices felis. Maecenas facilisis magna dui, aliquam ornare nisi feugiat vel.\n\n" +  
								"Pellentesque sed accumsan purus. Mauris at porta nunc. In elementum nisl quis nibh facilisis, et euismod nisl eleifend. Ut ac lorem urna. Vestibulum auctor massa quis mi faucibus ultrices. Donec leo magna, egestas et imperdiet in, blandit in ipsum. Pellentesque tempus massa sit amet nunc blandit laoreet. Curabitur feugiat, enim pulvinar venenatis egestas, urna arcu ornare risus, in interdum velit nunc ut leo. Nullam iaculis luctus orci ac faucibus. Nunc vehicula, magna id consequat placerat, tortor ipsum tincidunt leo, eget ultricies leo lectus rutrum eros. Praesent quis elit tellus. Integer lectus est, convallis in eros ac, elementum tincidunt dolor. Vivamus rutrum ullamcorper odio, sed laoreet neque sollicitudin vel. Nulla sagittis, purus et blandit blandit, quam lectus rhoncus erat, vel gravida diam nisl id dolor. Nullam et pretium nulla, et faucibus nisi. Vivamus volutpat massa consequat, iaculis odio quis, dapibus arcu.\n\n" +  
								"Curabitur mattis dolor tellus, sed congue velit condimentum vehicula. Nam ac mollis metus. Nam tempor hendrerit lorem. Nam elementum nec lacus eget interdum. Vestibulum hendrerit porta faucibus. Maecenas pulvinar augue quis auctor iaculis. Donec a nunc pellentesque, consequat mi at, pulvinar lorem. Morbi vulputate dui at lorem placerat consectetur.\n\n" +  
								"Cras tempus malesuada quam ut scelerisque. Fusce consectetur orci libero. Praesent nec enim sed diam suscipit convallis vel id velit. Suspendisse pretium luctus nisl vitae dapibus. Proin sapien risus, varius et arcu non, ullamcorper rhoncus elit. Nam ac arcu scelerisque, aliquet leo sollicitudin, varius risus. Morbi augue augue, hendrerit aliquam turpis et, posuere semper ligula.\n\n" +  
								"Maecenas mollis fermentum interdum. Morbi magna dolor, feugiat eget porta in, mollis sit amet massa. Pellentesque est purus, fringilla vitae cursus ut, bibendum sed arcu. Vestibulum nec posuere dui, non varius leo. Praesent mattis libero sed turpis dictum, ac faucibus dui commodo. Proin purus nisl, rhoncus sit amet rutrum non, adipiscing non eros. Nulla facilisi. Nam luctus quam vel ligula imperdiet eleifend. Donec ultrices placerat rhoncus. Vivamus vitae pretium lorem. Nulla elementum odio eu neque faucibus, et lacinia purus venenatis."; 
			 
			_hardwareText2 = new HardwareText(null, _cache); 
			 
			_hardwareText2.scaleX = _hardwareText2.scaleY = 0.013; 
			_hardwareText2.x = 20; 
			_hardwareText2.y = 300; 
			_hardwareText2.width = 300;				 
								 
			_hardwareText2.text = "Vestibulum sed lorem nec metus lacinia lobortis at sed erat. Praesent in sagittis diam. Donec quis pretium magna, eu dignissim mi. Phasellus nec laoreet justo, vitae ultricies dolor. Fusce nulla felis, facilisis eu suscipit sit amet, porta ut turpis. Integer posuere dolor in leo iaculis ornare. Aliquam in erat dolor. Vivamus iaculis egestas augue, eget aliquam odio rutrum eget. Curabitur scelerisque dui id arcu cursus, vel suscipit libero tincidunt.\n\n" +  
								"Nunc non mauris dui. Fusce ultricies nibh nec magna gravida, eu convallis nulla adipiscing. Proin fermentum est ac elit bibendum venenatis. Maecenas odio purus, pharetra vel cursus non, lacinia eget orci. Sed iaculis, quam sed tempus consequat, urna risus condimentum mauris, vel semper ipsum nisl vitae mi. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed vitae massa eget nunc fringilla dignissim. Praesent volutpat quam vel velit egestas, non accumsan ipsum dignissim. Morbi tincidunt felis nec dapibus lobortis. Etiam sit amet viverra nulla. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Curabitur at pellentesque urna. Sed facilisis enim non leo lacinia, ac varius massa pharetra. In aliquam porta est eget aliquet.\n\n" + 
								"Mauris eu lectus vestibulum urna pretium aliquam ac sit amet orci. Ut vel hendrerit magna. Vivamus congue massa eget tortor mattis fermentum. Aliquam semper porta lacus gravida gravida. Proin aliquet ultricies turpis vitae laoreet. Cras sed ligula in orci malesuada pellentesque. Cras tincidunt erat quis lacus imperdiet, ac porta massa molestie. Quisque et nunc sapien. Praesent fringilla nisl in sapien condimentum faucibus. Donec lobortis eleifend mollis. Praesent a tempor elit. Aliquam convallis tristique mauris, non porttitor mauris dignissim dignissim. Sed eget ligula iaculis, cursus orci id, aliquam sem.\n\n" + 
								"Aliquam erat volutpat. Curabitur mollis sem at ultricies vulputate. Quisque eros felis, tristique eget est eu, volutpat adipiscing ipsum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer gravida adipiscing neque, ut malesuada nisi volutpat vitae. Donec elementum, tortor eu consectetur faucibus, lorem felis iaculis felis, id fringilla nulla nunc vel lacus. Vivamus vulputate facilisis leo, quis feugiat velit egestas ut. Cras quam nisl, elementum non elementum vitae, elementum non lacus. Phasellus blandit feugiat nisi id volutpat. Quisque quam enim, ullamcorper at laoreet ut, ornare sed nunc. Integer pulvinar ullamcorper nulla semper mollis."; 
		} 
		 
		/////////////////////// 
		// Event Handler 
		/////////////////////// 
		 
		private function handleContextCreationError(e:ErrorEvent):void  
		{ 
			// Something went wrong. 
		} 
		 
		private function handleContextCreated(e:Event):void  
		{ 
			_context3d = (e.target as Stage3D).context3D; 
			 
			initializeText(); 
			initializeView(); 
			 
			// react to resizing the stage 
			this.stage.addEventListener(Event.RESIZE, handleResize); 
			 
			// Set up the update loop. 
			addEventListener(Event.ENTER_FRAME, update); 
		} 
		 
		private function handleResize(e:Event):void  
		{ 
			// The view has been scaled, re-initialize the backbuffer and the projection matrix. 
			initializeView(); 
		} 
		 
		private function update(e:Event):void  
		{ 
			// Clear the backbuffer, render the text and then display it. 
			_context3d.clear(1, 1, 1); 
			 
			_cache.render(); 
			 
			_context3d.present(); 
		} 
	} 
} 
