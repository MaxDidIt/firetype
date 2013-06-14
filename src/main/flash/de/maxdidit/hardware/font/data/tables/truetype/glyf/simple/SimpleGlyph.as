package de.maxdidit.hardware.font.data.tables.truetype.glyf.simple 
{
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.GlyphTableData;
	import de.maxdidit.hardware.text.cache.HardwareCharacterCache;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Contour;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.contours.Vertex;
	import de.maxdidit.hardware.font.data.tables.truetype.glyf.Glyph;
	import de.maxdidit.hardware.font.HardwareFont;
	import de.maxdidit.hardware.font.HardwareGlyph;
	import de.maxdidit.hardware.text.components.HardwareGlyphInstance;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class SimpleGlyph extends Glyph
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _endPointsOfContours:Vector.<uint>;
		
		private var _instructionLength:uint;
		private var _instructions:ByteArray;
		
		private var _flagData:Vector.<uint>;
		private var _flags:Vector.<SimpleGlyphFlags>;
		
		private var _xCoordinates:Vector.<int>;
		private var _yCoordinates:Vector.<int>;
		
		private var _contours:Vector.<Contour>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function SimpleGlyph() 
		{
			super();
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// endPointsOfContours
		
		public function get endPointsOfContours():Vector.<uint> 
		{
			return _endPointsOfContours;
		}
		
		public function set endPointsOfContours(value:Vector.<uint>):void 
		{
			_endPointsOfContours = value;
		}
		
		// instructionLength
		
		public function get instructionLength():uint 
		{
			return _instructionLength;
		}
		
		public function set instructionLength(value:uint):void 
		{
			_instructionLength = value;
		}
		
		// instructions
		
		public function get instructions():ByteArray 
		{
			return _instructions;
		}
		
		public function set instructions(value:ByteArray):void 
		{
			_instructions = value;
		}
		
		// flagData
		
		public function get flagData():Vector.<uint> 
		{
			return _flagData;
		}
		
		public function set flagData(value:Vector.<uint>):void 
		{
			_flagData = value;
		}
		
		// flags
		
		public function get flags():Vector.<SimpleGlyphFlags> 
		{
			return _flags;
		}
		
		public function set flags(value:Vector.<SimpleGlyphFlags>):void 
		{
			_flags = value;
		}
		
		// xCoordinates
		
		public function get xCoordinates():Vector.<int> 
		{
			return _xCoordinates;
		}
		
		public function set xCoordinates(value:Vector.<int>):void 
		{
			_xCoordinates = value;
		}
		
		// yCoordinates
		
		public function get yCoordinates():Vector.<int> 
		{
			return _yCoordinates;
		}
		
		public function set yCoordinates(value:Vector.<int>):void 
		{
			_yCoordinates = value;
		}
		
		// contours
		
		public function get contours():Vector.<Contour> 
		{
			return _contours;
		}
		
		public function set contours(value:Vector.<Contour>):void 
		{
			_contours = value;
			distributeHoles();
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		override public function retrieveGlyphInstances(instances:Vector.<HardwareGlyphInstance>):void
		{
			var glyphInstance:HardwareGlyphInstance = HardwareGlyphInstance.getHardwareGlyphInstance(null);
			glyphInstance.glyph = this;
			instances.push(glyphInstance);
		}
		
		override public function retrievePaths(vertexDistance:Number):Vector.<Vector.<Vertex>>
		{
			const l:uint = _contours.length;
			var shapes:Vector.<Vector.<Vertex>> = new Vector.<Vector.<Vertex>>(l);
			
			for (var i:uint = 0; i < l; i++)
			{
				shapes[i] = _contours[i].retrievePath(vertexDistance);
			}
			
			return shapes;
		}
		
		private function distributeHoles():void 
		{
			var potentialHole:Contour;
			var potentialContainer:Contour;
			
			var container:Contour;
			
			if (_contours.length == 1)
			{
				return;
			}
			
			_contours.sort(sortByBoundingBox);
			var holeDirection:Boolean = !_contours[0].clockWise; // assume that the biggest contour is not a hole.
			
			for (var i:int = _contours.length - 1; i >= 0; i--)
			{
				potentialHole = _contours[i];
				
				if (potentialHole.clockWise != holeDirection)
				{
					// this is not a hole
					continue;
				}
				
				container = null;
				
				for (var j:int = _contours.length - 1; j >= 0; j--)
				{
					potentialContainer = _contours[j];
					
					if (potentialContainer == potentialHole)
					{
						continue;
					}
					
					if (potentialContainer.clockWise == potentialHole.clockWise)
					{
						continue;
					}
					
					if (!potentialContainer.contains(potentialHole))
					{
						continue;
					}
					
					if (!container)
					{
						container = potentialContainer;
					}
					else if(container.boundingBox.width > potentialContainer.boundingBox.width || container.boundingBox.height > potentialContainer.boundingBox.height)
					{
						container = potentialContainer;
					}
				}
				
				if (container)
				{
					_contours.splice(i, 1);
					container.addHole(potentialHole);
				}
			}
			
			for (i = 0; i < _contours.length; i++)
			{
				_contours[i].sortHoles();
			}
		}
		
		private function sortByBoundingBox(contourA:Contour, contourB:Contour):Number 
		{
			return (contourB.boundingBox.width * contourB.boundingBox.height) - (contourA.boundingBox.width * contourA.boundingBox.height);
		}
	}

}