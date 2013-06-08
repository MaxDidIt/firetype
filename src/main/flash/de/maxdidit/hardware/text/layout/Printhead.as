package de.maxdidit.hardware.text.layout 
{
	import de.maxdidit.hardware.font.data.tables.advanced.gpos.GlyphPositioningTableData;
	import de.maxdidit.hardware.font.data.tables.advanced.ScriptFeatureLookupTable;
	import de.maxdidit.hardware.font.data.tables.common.language.LanguageSystemTable;
	import de.maxdidit.hardware.font.data.tables.common.script.ScriptTable;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import de.maxdidit.hardware.text.components.HardwareLine;
	import de.maxdidit.hardware.text.components.HardwareWord;
	import de.maxdidit.hardware.text.components.TextSpan;
	import de.maxdidit.hardware.text.format.HardwareTextFormat;
	import de.maxdidit.list.LinkedList;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class Printhead 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		public var lineX:Number = 0;
		public var wordX:Number = 0;
		public var y:Number = 0;
		
		public var currentLine:HardwareLine;
		public var currentWord:HardwareWord;
		
		private var _textSpan:TextSpan;
		public var textFormat:HardwareTextFormat;
		public var font:HardwareFont;
		
		public var lookupIndices:Vector.<int>;
		public var characterInstances:LinkedList;
		public var glyphInstances:Vector.<HardwareGlyphInstance>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function Printhead() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get textSpan():TextSpan 
		{
			return _textSpan;
		}
		
		public function set textSpan(value:TextSpan):void 
		{
			_textSpan = value;
			
			textFormat = _textSpan.textFormat;
			font = textFormat.font;
			
			characterInstances = _textSpan.characterInstances;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
	}

}