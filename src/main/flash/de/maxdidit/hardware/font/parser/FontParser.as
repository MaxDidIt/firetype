package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.events.FontEvent;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.triangulation.ITriangulator;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FontParser extends EventDispatcher implements IFontParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _eventDispatcherMap:Object;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FontParser() 
		{
			_eventDispatcherMap = new Object();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function loadFont(url:String):EventDispatcher
		{
			var fontLoaderJob:FontLoaderJob = new FontLoaderJob();
			fontLoaderJob.addEventListener(Event.COMPLETE, handleFontLoaded);
			
			var eventDispatcher:EventDispatcher = new EventDispatcher();
			_eventDispatcherMap[url] = eventDispatcher;
			
			fontLoaderJob.loadFont(url);
			
			return eventDispatcher;
		}
		
		public function parseFont(data:ByteArray):HardwareFont
		{
			var hardwareFont:HardwareFont = new HardwareFont();
			
			hardwareFont.data = parseFontData(data);
			hardwareFont.finalize();
			
			return hardwareFont;
		}
		
		protected function parseFontData(data:ByteArray):HardwareFontData
		{
			throw new Error("Function not implemented. Extend FontParser and implement function.");
			return null;
		}
		
		///////////////////////
		// Event Handler
		///////////////////////
		
		private function handleFontLoaded(e:Event):void 
		{
			// TODO: provide feedback that font has been loaded.
			var fontLoaderJob:FontLoaderJob = e.target as FontLoaderJob;
			
			var urlLoader:URLLoader = fontLoaderJob.urlLoader;
			
			var data:ByteArray = urlLoader.data as ByteArray;
			var font:HardwareFont = parseFont(data);
			
			var eventDispatcher:EventDispatcher = _eventDispatcherMap[fontLoaderJob.url];
			eventDispatcher.dispatchEvent(new FontEvent(FontEvent.FONT_PARSED, font));
			delete _eventDispatcherMap[fontLoaderJob.url];
			
			dispatchEvent(new FontEvent(FontEvent.FONT_PARSED, font));
		}
		
		private function handleFontLoadingFailed(e:Event):void 
		{
			var fontLoaderJob:FontLoaderJob = e.target as FontLoaderJob;
			var urlLoader:URLLoader = fontLoaderJob.urlLoader;
			delete _eventDispatcherMap[fontLoaderJob.url];
		}
	}

}