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
	import de.maxdidit.hardware.font.parser.OpenTypeParser;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator; 
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache; 
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
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
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	 
	/** 
	 * ... 
	 * @author Max Knoblich 
	 */ 
	public class FiretypeBenchmark1C extends Sprite  
	{
		/////////////////////// 
		// Embed 
		/////////////////////// 
		 
		[Embed(source="../../../../../resources/fonts/newscycle/newscycle-bold.ttf", mimeType="application/octet-stream")] 
        private static const fontNewsCycleBoldData : Class; 
		
		/////////////////////// 
		// Member Fields 
		/////////////////////// 
		 
		private var _context3d:Context3D; 
		private var _cache:HardwareCharacterCache; 
		private var _textField1:HardwareText; 
		private var _textField2:HardwareText; 
		private var _textField3:HardwareText;
		private var _textField4:HardwareText;
		 
		/////////////////////// 
		// Constructor 
		/////////////////////// 
		 
		public function FiretypeBenchmark1C()  
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
			 
			_textField1.calculateTransformations(viewProjection, true); 
			_textField2.calculateTransformations(viewProjection, true); 
			_textField3.calculateTransformations(viewProjection, true); 
			_textField4.calculateTransformations(viewProjection, true); 
		} 
		 
		private function initializeText():void  
		{ 
			_cache = new HardwareCharacterCache(new BatchedGlyphRendererFactory(_context3d, new EarClippingTriangulator())); 
			
			var textFormat:HardwareTextFormat = new HardwareTextFormat();
			textFormat.font = new OpenTypeParser().parseFont(new fontNewsCycleBoldData() as ByteArray);
			textFormat.scale = 0.75;
			
			_textField1 = new HardwareText(null, _cache); 
			 
			_textField1.scaleX = _textField1.scaleY = 0.013;
			_textField1.width = 400; 
			_textField1.standardFormat = textFormat;
			_textField1.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque erat ac sapien blandit, vitae egestas arcu adipiscing. Aenean ac lobortis urna. Pellentesque lacinia, ante eu malesuada molestie, sapien metus volutpat est, eu elementum libero tortor ac mauris. Mauris risus nisl, ultricies vel pretium posuere, imperdiet vitae magna. Pellentesque interdum, risus in venenatis egestas, erat felis rhoncus nisi, sit amet tempus nulla sapien viverra orci. Sed pellentesque laoreet congue. In ante neque, interdum et scelerisque sed, aliquet vitae sapien. Mauris nec iaculis sem. Proin pretium faucibus enim ac sollicitudin. Donec mattis est eget nisl pulvinar pellentesque. Vestibulum ut orci at urna eleifend laoreet eget a metus. Aenean eu vehicula nisl. Suspendisse a felis ac tellus sodales eleifend."
			 
			_textField2 = new HardwareText(null, _cache); 
			 
			_textField2.scaleX = _textField2.scaleY = 0.013;
			_textField2.width = 400;
			_textField2.standardFormat = textFormat;
			_textField2.text = "Ut lobortis molestie nibh, et lacinia libero consectetur et. Nullam ut risus eget leo lobortis adipiscing nec sed sem. Sed in dui eu eros tincidunt egestas. Pellentesque rutrum pretium est, a lacinia quam auctor eget. Curabitur sed commodo sem. Quisque id diam bibendum, lobortis tortor nec, iaculis urna. Proin iaculis, eros nec pretium gravida, ante eros varius purus, vel sagittis sapien nibh ut augue. Sed a lorem congue, imperdiet turpis non, elementum lorem. Fusce fringilla, odio ac ullamcorper imperdiet, ante ligula posuere odio, ac hendrerit turpis nibh quis dolor. Suspendisse potenti. Donec et accumsan ipsum. Sed fermentum odio non diam luctus condimentum. Sed interdum, diam in aliquet dignissim, turpis lorem cursus lacus, sed pretium elit arcu eu purus. Cras tempor magna in dolor laoreet fringilla. Suspendisse in scelerisque enim, vel varius velit. Sed malesuada tellus iaculis, semper nunc vitae, ullamcorper nisi. Donec facilisis eros sit amet erat tempus suscipit. Phasellus vitae vehicula nisi, a convallis nisl. Cras eget metus a dui semper gravida a sit amet nisl."
			
			_textField3 = new HardwareText(null, _cache); 
			 
			_textField3.scaleX = _textField3.scaleY = 0.013;
			_textField3.width = 400;
			_textField3.standardFormat = textFormat;
			_textField3.text = "Mauris malesuada eu lorem non sagittis. Nulla fringilla augue sit amet magna mollis, nec accumsan nisl elementum. Duis sit amet condimentum dui. Cras sed turpis eget neque porttitor pharetra. Vestibulum tempus feugiat dui, luctus mollis felis mattis in. Curabitur porttitor feugiat dui sed tincidunt. Pellentesque eget quam vel lectus scelerisque suscipit. Etiam euismod mi in lectus sodales mollis. Aliquam erat volutpat. Phasellus tristique orci erat, id accumsan quam vulputate ac. Nam sodales porttitor tellus, sit amet posuere justo placerat in. Proin egestas sapien nec suscipit dictum. Curabitur euismod ligula eu nunc ullamcorper bibendum. Pellentesque eleifend dui vitae felis aliquet ullamcorper. Mauris sollicitudin lectus vitae tellus dapibus aliquam. Nulla rutrum turpis vel odio viverra, ut convallis lectus gravida. Curabitur libero nibh, blandit at mi eget, ultricies tristique mauris. Maecenas ut dolor scelerisque, dignissim dolor adipiscing, varius lacus. Aliquam odio nibh, accumsan sed felis vel, tincidunt aliquam orci. Vestibulum eu libero quis lacus semper molestie eu vitae dui. Integer sodales euismod magna, in cursus nulla dictum sed. Ut malesuada nunc vitae nibh congue, ac placerat sapien cursus. Cras rutrum vestibulum dui, ac venenatis velit tincidunt tincidunt. Maecenas rutrum massa et dolor congue volutpat."
			
			_textField4 = new HardwareText(null, _cache); 
			 
			_textField4.scaleX = _textField4.scaleY = 0.013;
			_textField4.width = 400;
			_textField4.standardFormat = textFormat;
			_textField4.text = "Suspendisse fermentum commodo fringilla. Mauris mattis tristique nisi at eleifend. Donec mauris lectus, ullamcorper in porttitor nec, porta ut diam. Integer elementum laoreet justo, id varius massa dignissim in. Duis et tempor justo. Morbi quis mattis purus. In semper gravida diam, ut dignissim justo semper eget. Nam porttitor luctus magna, at placerat leo mattis sit amet. Nullam non sagittis tortor. Praesent cursus ornare ipsum, nec accumsan diam venenatis ultrices. Morbi vehicula sapien et vestibulum condimentum. Vivamus gravida ipsum eget molestie vestibulum. Pellentesque sodales augue eget dapibus semper. Pellentesque vel aliquet elit, id tempus mauris. Ut feugiat odio nibh, id laoreet magna dapibus vitae. Ut aliquet erat non mauris viverra porta nec eu ante. Quisque vel tortor sit amet augue condimentum hendrerit ut in libero. Donec adipiscing nunc id varius rhoncus. Aenean fermentum mattis mi, a tristique leo mollis et. Suspendisse in libero lectus. Nulla convallis est eu est adipiscing aliquam. Aliquam mattis sagittis orci at feugiat."
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
			const centerX:Number = stage.stageWidth / 2;
			const centerY:Number = stage.stageHeight / 2;
			const time:Number = Number(getTimer());
			
			_textField1.x = Math.sin(time / 2000) * centerY;
			_textField1.y = -Math.cos(time / 2000) * centerY;
			
			_textField2.x = Math.sin(time / 3000) * centerY;
			_textField2.y = -Math.cos(time / 3000) * centerY;
			
			_textField3.x = Math.sin(-time / 3000) * centerY;
			_textField3.y = -Math.cos(-time / 3000) * centerY;
			
			_textField4.x = Math.sin(-time / 1000) * centerY;
			_textField4.y = -Math.cos(-time / 1000) * centerY;
			
			// Clear the backbuffer, render the text and then display it. 
			_context3d.clear(1, 1, 1); 
			 
			_cache.render(); 
			 
			_context3d.present(); 
		} 
	} 
} 
