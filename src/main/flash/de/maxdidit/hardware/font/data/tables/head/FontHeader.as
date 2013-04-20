package de.maxdidit.hardware.font.data.tables.head 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class FontHeader 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _tableVersion:Number; // 0x00010000 for version 1.0.
		private var _fontRevision:Number; // Set by font manufacturer.
		
		private var _checkSumAdjustment:uint; // To compute: set it to 0, sum the entire font as ULONG, then store 0xB1B0AFBA - sum.
		private var _magicNumber:uint; // Set to 0x5F0F3CF5.
		
		private var _flags:uint;
		
		private var _baselineAtZero:Boolean; // is baseline for font at y = 0
		private var _sidebearingPointAtZero:Boolean; // is left sidebearing point at x = 0
		private var _dependsOnPointSize:Boolean; // instructions may depend on point size
		private var _forcePPEMIntegerValues:Boolean; // Force ppem to integer values for all internal scaler math; may use fractional ppem sizes if this bit is clear; 
		private var _advanceWidthAlterable:Boolean; // Instructions may alter advance width (the advance widths might not scale linearly); 
		private var _losslessCompression:Boolean; // Font data is 'lossless,' as a result of having been compressed and decompressed with the Agfa MicroType Express engine.
		private var _fontConverted:Boolean; // Font converted (produce compatible metrics)
		private var _clearTypeOptimized:Boolean; // Font optimized for ClearType™. Note, fonts that rely on embedded bitmaps (EBDT) for rendering should not be considered optimized for ClearType, and therefore should keep this bit cleared.
		private var _lastResort:Boolean; // Last Resort font. If set, indicates that the glyphs encoded in the cmap subtables are simply generic symbolic representations of code point ranges and don’t truly represent support for those code points. If unset, indicates that the glyphs encoded in the cmap subtables represent proper support for those code points.
		
		private var _unitsPerEm:uint; // Valid range is from 16 to 16384. This value should be a power of 2 for fonts that have TrueType outlines.
		
		private var _created:Number; // Number of seconds since 12:00 midnight, January 1, 1904. 64-bit integer
		private var _modified:Number; // Number of seconds since 12:00 midnight, January 1, 1904. 64-bit integer
		
		private var _xMin:int; // For all glyph bounding boxes.
		private var _yMin:int; // For all glyph bounding boxes.
		private var _xMax:int; // For all glyph bounding boxes.
		private var _yMax:int; // For all glyph bounding boxes.
		
		private var _macStyle:uint;
		
		private var _bold:Boolean;
		private var _italic:Boolean;
		private var _underline:Boolean;
		private var _outline:Boolean;
		private var _shadow:Boolean;
		private var _condensed:Boolean;
		private var _extended:Boolean;
		
		private var _lowestRecPPEM:uint; // Smallest readable size in pixels.
		private var _fontDirectionHint:int; // Deprecated (Set to 2).
		
		private var _indexToLocFormat:int; // 0 for short offsets, 1 for long.
		private var _glyphDataFormat:int; // 0 for current format.
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function FontHeader() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		public function get tableVersion():Number 
		{
			return _tableVersion;
		}
		
		public function set tableVersion(value:Number):void 
		{
			_tableVersion = value;
		}
		
		public function get fontRevision():Number 
		{
			return _fontRevision;
		}
		
		public function set fontRevision(value:Number):void 
		{
			_fontRevision = value;
		}
		
		public function get checkSumAdjustment():uint 
		{
			return _checkSumAdjustment;
		}
		
		public function set checkSumAdjustment(value:uint):void 
		{
			_checkSumAdjustment = value;
		}
		
		public function get magicNumber():uint 
		{
			return _magicNumber;
		}
		
		public function set magicNumber(value:uint):void 
		{
			_magicNumber = value;
		}
		
		public function get flags():uint 
		{
			return _flags;
		}
		
		public function set flags(value:uint):void 
		{
			_flags = value;
		}
		
		public function get baselineAtZero():Boolean 
		{
			return _baselineAtZero;
		}
		
		public function set baselineAtZero(value:Boolean):void 
		{
			_baselineAtZero = value;
		}
		
		public function get sidebearingPointAtZero():Boolean 
		{
			return _sidebearingPointAtZero;
		}
		
		public function set sidebearingPointAtZero(value:Boolean):void 
		{
			_sidebearingPointAtZero = value;
		}
		
		public function get dependsOnPointSize():Boolean 
		{
			return _dependsOnPointSize;
		}
		
		public function set dependsOnPointSize(value:Boolean):void 
		{
			_dependsOnPointSize = value;
		}
		
		public function get forcePPEMIntegerValues():Boolean 
		{
			return _forcePPEMIntegerValues;
		}
		
		public function set forcePPEMIntegerValues(value:Boolean):void 
		{
			_forcePPEMIntegerValues = value;
		}
		
		public function get advanceWidthAlterable():Boolean 
		{
			return _advanceWidthAlterable;
		}
		
		public function set advanceWidthAlterable(value:Boolean):void 
		{
			_advanceWidthAlterable = value;
		}
		
		public function get losslessCompression():Boolean 
		{
			return _losslessCompression;
		}
		
		public function set losslessCompression(value:Boolean):void 
		{
			_losslessCompression = value;
		}
		
		public function get fontConverted():Boolean 
		{
			return _fontConverted;
		}
		
		public function set fontConverted(value:Boolean):void 
		{
			_fontConverted = value;
		}
		
		public function get clearTypeOptimized():Boolean 
		{
			return _clearTypeOptimized;
		}
		
		public function set clearTypeOptimized(value:Boolean):void 
		{
			_clearTypeOptimized = value;
		}
		
		public function get lastResort():Boolean 
		{
			return _lastResort;
		}
		
		public function set lastResort(value:Boolean):void 
		{
			_lastResort = value;
		}
		
		public function get unitsPerEm():uint 
		{
			return _unitsPerEm;
		}
		
		public function set unitsPerEm(value:uint):void 
		{
			_unitsPerEm = value;
		}
		
		public function get created():Number 
		{
			return _created;
		}
		
		public function set created(value:Number):void 
		{
			_created = value;
		}
		
		public function get modified():Number 
		{
			return _modified;
		}
		
		public function set modified(value:Number):void 
		{
			_modified = value;
		}
		
		public function get xMin():int 
		{
			return _xMin;
		}
		
		public function set xMin(value:int):void 
		{
			_xMin = value;
		}
		
		public function get yMin():int 
		{
			return _yMin;
		}
		
		public function set yMin(value:int):void 
		{
			_yMin = value;
		}
		
		public function get xMax():int 
		{
			return _xMax;
		}
		
		public function set xMax(value:int):void 
		{
			_xMax = value;
		}
		
		public function get yMax():int 
		{
			return _yMax;
		}
		
		public function set yMax(value:int):void 
		{
			_yMax = value;
		}
		
		public function get macStyle():uint 
		{
			return _macStyle;
		}
		
		public function set macStyle(value:uint):void 
		{
			_macStyle = value;
		}
		
		public function get bold():Boolean 
		{
			return _bold;
		}
		
		public function set bold(value:Boolean):void 
		{
			_bold = value;
		}
		
		public function get italic():Boolean 
		{
			return _italic;
		}
		
		public function set italic(value:Boolean):void 
		{
			_italic = value;
		}
		
		public function get underline():Boolean 
		{
			return _underline;
		}
		
		public function set underline(value:Boolean):void 
		{
			_underline = value;
		}
		
		public function get outline():Boolean 
		{
			return _outline;
		}
		
		public function set outline(value:Boolean):void 
		{
			_outline = value;
		}
		
		public function get shadow():Boolean 
		{
			return _shadow;
		}
		
		public function set shadow(value:Boolean):void 
		{
			_shadow = value;
		}
		
		public function get condensed():Boolean 
		{
			return _condensed;
		}
		
		public function set condensed(value:Boolean):void 
		{
			_condensed = value;
		}
		
		public function get extended():Boolean 
		{
			return _extended;
		}
		
		public function set extended(value:Boolean):void 
		{
			_extended = value;
		}
		
		public function get lowestRecPPEM():uint 
		{
			return _lowestRecPPEM;
		}
		
		public function set lowestRecPPEM(value:uint):void 
		{
			_lowestRecPPEM = value;
		}
		
		public function get fontDirectionHint():int 
		{
			return _fontDirectionHint;
		}
		
		public function set fontDirectionHint(value:int):void 
		{
			_fontDirectionHint = value;
		}
		
		public function get indexToLocFormat():int 
		{
			return _indexToLocFormat;
		}
		
		public function set indexToLocFormat(value:int):void 
		{
			_indexToLocFormat = value;
		}
		
		public function get glyphDataFormat():int 
		{
			return _glyphDataFormat;
		}
		
		public function set glyphDataFormat(value:int):void 
		{
			_glyphDataFormat = value;
		}
		
	}

}