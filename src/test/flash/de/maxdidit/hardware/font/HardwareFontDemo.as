package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.events.FontEvent;
	import de.maxdidit.hardware.font.parser.OpenTypeParser;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DRenderMode;
	import flash.display3D.Program3D;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	
	/**
	 * This is a runnable demo class to test the HardwareFont class.
	 *
	 * @author Max Knoblich
	 */
	public class HardwareFontDemo extends Sprite
	{
		private var stage3d:Stage3D;
		private var context3d:Context3D;
		
		private const VERTEX_SHADER:String = "m44 op, va0, vc0"
		
		private const FRAGMENT_SHADER:String = "mov oc, fc0";
		
		private var vertexAssembly:AGALMiniAssembler = new AGALMiniAssembler();
		private var fragmentAssembly:AGALMiniAssembler = new AGALMiniAssembler();
		private var programPair:Program3D;
		private var hardwareGlyph1:HardwareGlyph;
		private var hardwareGlyph2:HardwareGlyph;
		private var hardwareGlyph3:HardwareGlyph;
		private var hardwareGlyph4:HardwareGlyph;
		private var hardwareGlyph5:HardwareGlyph;
		private var hardwareGlyph6:HardwareGlyph;
		private var hardwareGlyph7:HardwareGlyph;
		private var hardwareGlyph8:HardwareGlyph;
		private var hardwareGlyph9:HardwareGlyph;
		private var hardwareGlyph0:HardwareGlyph;
		private var hardwareGlyphA:HardwareGlyph;
		private var hardwareGlyphB:HardwareGlyph;
		private var hardwareGlyphC:HardwareGlyph;
		private var hardwareGlyphD:HardwareGlyph;
		private var hardwareGlyphE:HardwareGlyph;
		private var hardwareGlyphF:HardwareGlyph;
		
		private var viewProjectionMtx:Matrix3D;
		
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFontDemo()
		{
			// stage properties
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.frameRate = 60;
			
			this.stage.addEventListener(Event.RESIZE, handleResize);
			
			// init stage3d
			stage3d = this.stage.stage3Ds[0];
			stage3d.addEventListener(Event.CONTEXT3D_CREATE, handleContextCreated);
			stage3d.addEventListener(ErrorEvent.ERROR, handleContextCreationError);
			stage3d.requestContext3D(Context3DRenderMode.AUTO);
			
			// init shaders
			vertexAssembly.assemble(Context3DProgramType.VERTEX, VERTEX_SHADER);
			fragmentAssembly.assemble(Context3DProgramType.FRAGMENT, FRAGMENT_SHADER);
		}
		
		private function handleResize(e:Event):void 
		{
			context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 4, false);
			
			viewProjectionMtx = new Matrix3D();
			viewProjectionMtx.appendTranslation(-3000, 2000, -2000);
			var perspectiveMtx:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspectiveMtx.perspectiveFieldOfViewRH(90, stage.stageWidth / stage.stageHeight, 1000, 3000);
			viewProjectionMtx.append(perspectiveMtx);
		}
		
		private function handleContextCreated(e:Event):void
		{
			context3d = (e.target as Stage3D).context3D;
			
			context3d.enableErrorChecking = true;
			context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 4, false);
			
			var hardwareParser:OpenTypeParser = new OpenTypeParser(context3d, new EarClippingTriangulator());
			
			hardwareParser.addEventListener(FontEvent.FONT_PARSED, handleFontParsed);
			//hardwareParser.loadFont("arial.ttf");
			//hardwareParser.loadFont("impact.ttf");
			//hardwareParser.loadFont("newscycle-bold.ttf");
			hardwareParser.loadFont("DAUNPENH.TTF");
			
			programPair = context3d.createProgram();
			programPair.upload(vertexAssembly.agalcode, fragmentAssembly.agalcode);
			context3d.setProgram(programPair);
			
			viewProjectionMtx = new Matrix3D();
			viewProjectionMtx.appendTranslation(-3000, 2000, -2000);
			var perspectiveMtx:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspectiveMtx.perspectiveFieldOfViewRH(90, stage.stageWidth / stage.stageHeight, 1000, 3000);
			viewProjectionMtx.append(perspectiveMtx);
			
			var color:Vector.<Number> = new Vector.<Number>();
			color.push(0.0, 0.0, 0.0, 1.0);
			
			context3d.setProgramConstantsFromMatrix( Context3DProgramType.VERTEX, 0, viewProjectionMtx, true );
			context3d.setProgramConstantsFromVector( Context3DProgramType.FRAGMENT, 0, color, 1 );
		}
		
		private function handleContextCreationError(e:ErrorEvent):void
		{
			trace("Yaahrg");
		}
		
		private function handleFontParsed(e:FontEvent):void
		{
			var font:HardwareFont = e.font;
			
			hardwareGlyph1 = font.getHardwareGlyph("a".charCodeAt(0), 0);
			hardwareGlyph2 = font.getHardwareGlyph("a".charCodeAt(0), 1);
			hardwareGlyph2.position = new Vector3D(1200, 0, 0);
			hardwareGlyph3 = font.getHardwareGlyph("a".charCodeAt(0), 2);
			hardwareGlyph3.position = new Vector3D(2400, 0, 0);
			hardwareGlyph4 = font.getHardwareGlyph("a".charCodeAt(0), 2);
			hardwareGlyph4.position = new Vector3D(3600, 0, 0);
			hardwareGlyph5 = font.getHardwareGlyph("a".charCodeAt(0), 2);
			hardwareGlyph5.position = new Vector3D(4800, 0, 0);
			
			hardwareGlyph6 = font.getHardwareGlyph("B".charCodeAt(0), 0);
			hardwareGlyph6.position = new Vector3D(0, -2000, 0);
			hardwareGlyph7 = font.getHardwareGlyph("B".charCodeAt(0), 1);
			hardwareGlyph7.position = new Vector3D(1200, -2000, 0);
			hardwareGlyph8 = font.getHardwareGlyph("B".charCodeAt(0), 2);
			hardwareGlyph8.position = new Vector3D(2400, -2000, 0);
			hardwareGlyph9 = font.getHardwareGlyph("B".charCodeAt(0), 3);
			hardwareGlyph9.position = new Vector3D(3600, -2000, 0);
			hardwareGlyph0 = font.getHardwareGlyph("B".charCodeAt(0), 4);
			hardwareGlyph0.position = new Vector3D(4800, -2000, 0);
			
			hardwareGlyphA = font.getHardwareGlyph("i".charCodeAt(0), 2);
			hardwareGlyphA.position = new Vector3D(0, -4000, 0);
			hardwareGlyphB = font.getHardwareGlyph("%".charCodeAt(0), 2);
			hardwareGlyphB.position = new Vector3D(1200, -4000, 0);
			hardwareGlyphC = font.getHardwareGlyph("&".charCodeAt(0), 2);
			hardwareGlyphC.position = new Vector3D(2400, -4000, 0);
			hardwareGlyphD = font.getHardwareGlyph("@".charCodeAt(0), 2);
			hardwareGlyphD.position = new Vector3D(3600, -4000, 0);
			hardwareGlyphE = font.getHardwareGlyph("8".charCodeAt(0), 2);
			hardwareGlyphE.position = new Vector3D(4800, -4000, 0);
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		private function handleEnterFrame(e:Event):void 
		{
			context3d.clear(1, 1, 1);
			
			hardwareGlyph1.render(context3d, viewProjectionMtx);
			hardwareGlyph2.render(context3d, viewProjectionMtx);
			hardwareGlyph3.render(context3d, viewProjectionMtx);
			hardwareGlyph4.render(context3d, viewProjectionMtx);
			hardwareGlyph5.render(context3d, viewProjectionMtx);
			
			hardwareGlyph6.render(context3d, viewProjectionMtx);
			hardwareGlyph7.render(context3d, viewProjectionMtx);
			hardwareGlyph8.render(context3d, viewProjectionMtx);
			hardwareGlyph9.render(context3d, viewProjectionMtx);
			hardwareGlyph0.render(context3d, viewProjectionMtx);
			
			hardwareGlyphA.render(context3d, viewProjectionMtx);
			hardwareGlyphB.render(context3d, viewProjectionMtx);
			hardwareGlyphC.render(context3d, viewProjectionMtx);
			hardwareGlyphD.render(context3d, viewProjectionMtx);
			hardwareGlyphE.render(context3d, viewProjectionMtx);
			
			context3d.present();
		}
	
	}

}