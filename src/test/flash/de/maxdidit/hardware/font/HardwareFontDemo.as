package de.maxdidit.hardware.font
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureRecord;
	import de.maxdidit.hardware.font.data.tables.common.features.FeatureTag;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageTag;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTag;
	import de.maxdidit.hardware.font.events.FontEvent;
	import de.maxdidit.hardware.font.parser.OpenTypeParser;
	import de.maxdidit.hardware.font.triangulation.EarClippingTriangulator;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.text.cache.HardwareTextFormatMap;
	import de.maxdidit.hardware.text.HardwareText;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.hardware.text.renderer.BatchedGlyphRenderer;
	import de.maxdidit.hardware.text.renderer.BatchedGlyphRendererFactory;
	import de.maxdidit.hardware.text.renderer.SingleGlyphRenderer;
	import de.maxdidit.hardware.text.renderer.SingleGlyphRendererFactory;
	import de.maxdidit.hardware.text.Typesetter;
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
	import flash.events.MouseEvent;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	
	/**
	 * This is a runnable demo class to test the HardwareFont class.
	 *
	 * @author Max Knoblich
	 */
	public class HardwareFontDemo extends Sprite
	{
		private var stage3d:Stage3D;
		private var context3d:Context3D;
		
		private var viewProjectionMtx:Matrix3D;
		private var cache:HardwareCharacterCache;
		private var hardwareText:HardwareText;
		
		private var mouseDown:Boolean;
		private var textClickY:Number;
		private var mouseClickY:Number;
		private var baseFont:HardwareFont;
		private var hardwareParser:OpenTypeParser;
		
		
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
		}
		
		private function handleResize(e:Event):void 
		{
			context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 4, false);
			
			viewProjectionMtx = new Matrix3D();
			viewProjectionMtx.appendTranslation(-3000, 2000, -2000);
			var perspectiveMtx:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspectiveMtx.perspectiveFieldOfViewRH(90, stage.stageWidth / stage.stageHeight, 1000, 3000);
			viewProjectionMtx.append(perspectiveMtx);
			
			if (hardwareText)
			{
				hardwareText.calculateTransformations(viewProjectionMtx, true);
			}
		}
		
		private function handleContextCreated(e:Event):void
		{
			context3d = (e.target as Stage3D).context3D;
			
			context3d.enableErrorChecking = true;
			context3d.configureBackBuffer(stage.stageWidth, stage.stageHeight, 8, false);
			
			hardwareParser = new OpenTypeParser();
			
			//hardwareParser.addEventListener(FontEvent.FONT_PARSED, handleFontParsed);
			//hardwareParser.loadFont("L_10646.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("arial.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("DAUNPENH.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("TIMES.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			hardwareParser.loadFont("newscycle-regular.ttf").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			hardwareParser.loadFont("newscycle-bold.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("WBV4.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("CAMBRIAB.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("CAMBRIAZ.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("CONSOLA.TTF").addEventListener(FontEvent.FONT_PARSED, handleBaseFontParsed);
			//hardwareParser.loadFont("COURBD.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("impact.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("TIMESI.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("ariali.ttf").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			//hardwareParser.loadFont("TLPSMB.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			
			// Buggy
			//hardwareParser.loadFont("HDZB_5.TTF").addEventListener(FontEvent.FONT_PARSED, handleHighlightFontParsed);
			
			viewProjectionMtx = new Matrix3D();
			viewProjectionMtx.appendTranslation(-3000, 2000, -2000);
			var perspectiveMtx:PerspectiveMatrix3D = new PerspectiveMatrix3D();
			perspectiveMtx.perspectiveFieldOfViewRH(90, stage.stageWidth / stage.stageHeight, 1000, 3000);
			viewProjectionMtx.append(perspectiveMtx);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		private function handleMouseUp(e:MouseEvent):void 
		{
			mouseDown = false;
		}
		
		private function handleMouseDown(e:MouseEvent):void 
		{
			textClickY = hardwareText.y;
			
			mouseClickY = e.stageY;
			
			mouseDown = true;
		}
		
		private function handleContextCreationError(e:ErrorEvent):void
		{
			trace("Yaahrg");
		}
		
		private function handleBaseFontParsed(e:FontEvent):void 
		{
			baseFont = e.font;
		}
		
		private function handleHighlightFontParsed(e:FontEvent):void
		{
			var hardwareFontFormat:HardwareTextFormat = new HardwareTextFormat();
			hardwareFontFormat.font = baseFont;
			hardwareFontFormat.subdivisions = 2;
			//hardwareFontFormat.scale = 2;
			hardwareFontFormat.color = 0xFF000000;
			
			hardwareFontFormat.script = ScriptTag.LATIN;
			hardwareFontFormat.language = LanguageTag.ENGLISH;
			
			hardwareFontFormat.id = "standardFont";
			hardwareFontFormat.features.addFeature(FeatureTag.STANDARD_LIGATURES);
			
			var fractionFontFormat:HardwareTextFormat = new HardwareTextFormat();
			fractionFontFormat.font = baseFont;
			fractionFontFormat.subdivisions = 2;
			fractionFontFormat.color = 0xFF666680;
			
			fractionFontFormat.script = ScriptTag.LATIN;
			fractionFontFormat.language = LanguageTag.ENGLISH;
			
			fractionFontFormat.id = "fractions";
			//fractionFontFormat.features.addFeature(FeatureTag.NUMERATORS);
			fractionFontFormat.features.addFeature(FeatureTag.FRACTIONS);
			
			var redFontFormat:HardwareTextFormat= new HardwareTextFormat();
			redFontFormat.font = e.font;
			redFontFormat.subdivisions = 2;
			redFontFormat.color = 0xFFFF0000;
			
			redFontFormat.script = ScriptTag.LATIN;
			redFontFormat.language = LanguageTag.ENGLISH;
			
			redFontFormat.id = "red";
			
			var smallFontFormat:HardwareTextFormat= new HardwareTextFormat();
			smallFontFormat.font = baseFont;
			smallFontFormat.subdivisions = 2;
			smallFontFormat.scale = 0.75;
			smallFontFormat.color = 0xFF333333;
			
			smallFontFormat.script = ScriptTag.LATIN;
			smallFontFormat.language = LanguageTag.ENGLISH;
			
			smallFontFormat.id = "small";
			
			cache = new HardwareCharacterCache(new BatchedGlyphRendererFactory(context3d, new EarClippingTriangulator()));
			cache.textFormatMap.addTextFormat(hardwareFontFormat);
			cache.textFormatMap.addTextFormat(redFontFormat);
			cache.textFormatMap.addTextFormat(smallFontFormat);
			cache.textFormatMap.addTextFormat(fractionFontFormat);
			
			hardwareText = new HardwareText(context3d, cache);
			hardwareText.scaleX = hardwareText.scaleY = 0.15;
			hardwareText.width = 40000;
			
			hardwareText.standardFormat = hardwareFontFormat;
			
			hardwareText.text = "Hold the <format id=\"red\">left mouse button</format> and <format id=\"red\">drag</format> the text up and down.\n\n" 
			hardwareText.text += "Each character in this text has been decoded from an OpenType font file containing TrueType outlines, converted into polygon geometry and is rendered via the 3D graphics card.\n\n" 
			
			if (e.font.fontFamily == "News Cycle")
			{
				hardwareText.text += "This text uses the font <format id=\"red\">\"News Cycle\"</format>,\nCopyright ©2010-2011, Nathan Willis (nwillis@glyphography.com),\n\n" +
									"This Font Software is licensed under the SIL Open Font License, Version 1.1.\n" +
									"This license is available with a FAQ at:\n" +
									"http://scripts.sil.org/OFL\n\n";
			}
			else
			{
				hardwareText.text += "This text is (mostly) displayed using the font <format id=\"red\">" + baseFont.fontFamily + " " + baseFont.fontSubFamily + "</format>.\n\n";
			}
			
			hardwareText.text += "The font implements the following features for the script '" + hardwareFontFormat.script + "' and the language '" + hardwareFontFormat.language + "':\n\n";
			var features:Vector.<FeatureRecord> = baseFont.getAdvancedFeatures(hardwareFontFormat.script, hardwareFontFormat.language);
			const l:uint = features.length;
			for (var i:uint = 0; i < l; i++)
			{
				hardwareText.text += features[i].featureTag.description + "\n";
			}
			hardwareText.text += "\n";
			
			hardwareText.text += "<format id=\"fractions\">12/8</format> <format id=\"fractions\">1/3</format> á â à Â f fi ffi\n\n<format id=\"small\">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ipsum mi, commodo eget lacinia eget, condimentum porta nisi. Praesent tincidunt euismod pulvinar. Nam aliquam odio nec justo laoreet <format id=\"red\">sed commodo arcu</format> viverra. Vestibulum sodales ultricies sollicitudin. Aenean felis urna, auctor et elementum interdum, hendrerit eget orci. Morbi aliquet, nunc vitae vehicula tempor, massa nulla imperdiet lectus, eu vehicula dolor massa non nisl. Duis cursus lobortis facilisis. Sed in tortor lacus, vel rutrum elit. Morbi vulputate mi vel elit pellentesque gravida. Quisque gravida neque nec nunc malesuada pharetra. Aliquam enim massa, vulputate ut faucibus vel, adipiscing vel tortor. Pellentesque malesuada ipsum eu diam fringilla molestie.\n\nAenean hendrerit velit a massa scelerisque pulvinar bibendum velit iaculis. Sed id enim eget augue hendrerit laoreet et quis est. Donec placerat dignissim leo dignissim imperdiet. Integer pharetra enim non risus porttitor dignissim et vel libero. Aenean blandit feugiat leo interdum tincidunt. Ut in diam non purus venenatis scelerisque. Integer eleifend varius porta. Morbi sollicitudin convallis tortor, non egestas mi imperdiet at. Maecenas eget felis a eros hendrerit luctus. Vestibulum accumsan viverra lorem id vestibulum. Quisque suscipit pulvinar arcu, ut faucibus ligula aliquam nec. Sed commodo tempus velit, varius laoreet diam consequat eu. Sed molestie dignissim metus ac tempor. Maecenas non neque vitae odio laoreet vulputate ultricies et elit. Nulla nunc nulla, bibendum eu volutpat in, luctus at augue.\n\nNunc aliquet nunc non mauris pretium at hendrerit dui volutpat. Sed vitae condimentum nunc. Nam eget est non augue egestas tincidunt vel consectetur felis. Nulla facilisi. Praesent quis purus sed odio tincidunt iaculis. Nullam vulputate nisi vitae augue congue gravida. Phasellus magna metus, elementum nec adipiscing eget, interdum eu lorem. Nulla ornare lacinia ante at rhoncus.</format>";
			//hardwareText.text = "b";
			
			hardwareText.calculateTransformations(viewProjectionMtx, true);
			
			var font:HardwareFont = e.font;
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		private function handleEnterFrame(e:Event):void 
		{
			//cache.clearHardwareGlyphCache();
			//hardwareText.text = "<format id=\"fractions\">12/8</format> Lorem ipsum dolor sit amet, consectetur adipiscing elit. <format id=\"red\">Donec ipsum mi</format>, commodo eget lacinia eget, condimentum porta nisi. Praesent tincidunt euismod pulvinar. Nam aliquam odio nec justo laoreet sed commodo arcu viverra. Vestibulum sodales ultricies sollicitudin. Aenean felis urna, auctor et elementum interdum, hendrerit eget orci. Morbi aliquet, nunc vitae vehicula tempor, massa nulla imperdiet lectus, eu vehicula dolor massa non nisl. Duis cursus lobortis facilisis. Sed in tortor lacus, vel rutrum elit. Morbi vulputate mi vel elit pellentesque gravida. Quisque gravida neque nec nunc malesuada pharetra. Aliquam enim massa, vulputate ut faucibus vel, adipiscing vel tortor. Pellentesque malesuada ipsum eu diam fringilla molestie.\n\n<format id=\"small\">Aenean hendrerit velit a massa scelerisque pulvinar bibendum velit iaculis. Sed id enim eget augue hendrerit laoreet et quis est. Donec placerat dignissim leo dignissim imperdiet. Integer pharetra enim non risus porttitor dignissim et vel libero. Aenean blandit feugiat leo interdum tincidunt. Ut in diam non purus venenatis scelerisque. Integer eleifend varius porta. Morbi sollicitudin convallis tortor, non egestas mi imperdiet at. Maecenas eget felis a eros hendrerit luctus. Vestibulum accumsan viverra lorem id vestibulum. <format id=\"red\">Quisque suscipit pulvinar arcu</format>, ut faucibus ligula aliquam nec. Sed commodo tempus velit, varius laoreet diam consequat eu. Sed molestie dignissim metus ac tempor. Maecenas non neque vitae odio laoreet vulputate ultricies et elit. Nulla nunc nulla, bibendum eu volutpat in, luctus at augue.\n\nNunc aliquet nunc non mauris pretium at hendrerit dui volutpat. Sed vitae condimentum nunc. Nam eget est non augue egestas tincidunt vel consectetur felis. Nulla facilisi. Praesent quis purus sed odio tincidunt iaculis. Nullam vulputate nisi vitae augue congue gravida. Phasellus magna metus, elementum nec adipiscing eget, interdum eu lorem. Nulla ornare lacinia ante at rhoncus." + int(Math.random() * 100) + "</format>";
			
			if (mouseDown)
			{
				hardwareText.y = textClickY - (stage.mouseY - mouseClickY) * 10;
				hardwareText.calculateTransformations(viewProjectionMtx);
			}
			
			//hardwareText.standardFormat.colorVector[2] = Math.cos(getTimer() * 0.01) * 0.5 + 0.5;
			//hardwareText.standardFormat.colorVector[1] = Math.cos(getTimer() * 0.003) * 0.5 + 0.5;
			//hardwareText.standardFormat.colorVector[0] = Math.cos(getTimer() * 0.001) * 0.5 + 0.5;
			
			context3d.clear(1, 1, 1);
			cache.render();
			context3d.present();
		}
	
	}

}