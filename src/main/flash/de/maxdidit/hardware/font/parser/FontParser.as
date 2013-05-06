package de.maxdidit.hardware.font.parser 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.events.FontEvent;
	import de.maxdidit.hardware.font.HardwareFont;
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
		
		protected var _context3D:Context3D;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FontParser(context3D:Context3D) 
		{
			this._context3D = context3D;
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get context3D():Context3D 
		{
			return _context3D;
		}
		
		public function set context3D(value:Context3D):void 
		{
			_context3D = value;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function loadFont(url:String):void
		{
			var urlRequest:URLRequest = new URLRequest(url);
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			
			urlLoader.addEventListener(Event.COMPLETE, handleFontLoaded);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleFontLoadingFailed);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, handleFontLoadingFailed);
			
			urlLoader.load(urlRequest);
		}
		
		public function parseFont(data:ByteArray):HardwareFont
		{
			var hardwareFont:HardwareFont = new HardwareFont(_context3D);
			
			hardwareFont.data = parseFontData(data);
			
			return hardwareFont;
		}
		
		protected function parseFontData(data:ByteArray):HardwareFontData
		{
			throw new Error("Function not implemented. Extend FontParser and implement function.");
			return null;
		}
		
		private function removeEventHandlerFromLoader(urlLoader:URLLoader):void
		{
			urlLoader.removeEventListener(Event.COMPLETE, handleFontLoaded);
			urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleFontLoadingFailed);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, handleFontLoadingFailed);
		}
		
		///////////////////////
		// Event Handler
		///////////////////////
		
		private function handleFontLoaded(e:Event):void 
		{
			// TODO: provide feedback that font has been loaded.
			
			var urlLoader:URLLoader = e.target as URLLoader;
			removeEventHandlerFromLoader(urlLoader);
			
			var data:ByteArray = urlLoader.data as ByteArray;
			var font:HardwareFont = parseFont(data);
			
			dispatchEvent(new FontEvent(FontEvent.FONT_PARSED, font));
		}
		
		private function handleFontLoadingFailed(e:Event):void 
		{
			// TODO: provide feedback that the font could not be loaded and why.
			
			var urlLoader:URLLoader = e.target as URLLoader;
			removeEventHandlerFromLoader(urlLoader);
		}
	}

}