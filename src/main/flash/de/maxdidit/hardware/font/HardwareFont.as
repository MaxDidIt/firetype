package de.maxdidit.hardware.font 
{
	import de.maxdidit.hardware.font.data.HardwareFontData;
	import de.maxdidit.hardware.font.parser.IFontParser;
	import flash.events.Event;
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
	public class HardwareFont 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _data:HardwareFontData;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HardwareFont() 
		{
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		// data
		
		public function get data():HardwareFontData 
		{
			return _data;
		}
		
		public function set data(value:HardwareFontData):void 
		{
			_data = value;
		}
	}

}