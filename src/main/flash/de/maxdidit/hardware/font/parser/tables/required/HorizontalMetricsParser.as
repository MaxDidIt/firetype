package de.maxdidit.hardware.font.parser.tables.required
{
	import de.maxdidit.hardware.font.data.ITableMap;
	import de.maxdidit.hardware.font.data.tables.required.hhea.HorizontalHeaderData;
	import de.maxdidit.hardware.font.data.tables.required.hmtx.HorizontalMetricsData;
	import de.maxdidit.hardware.font.data.tables.required.hmtx.LongHorizontalMetric;
	import de.maxdidit.hardware.font.data.tables.required.maxp.MaximumProfileTableData;
	import de.maxdidit.hardware.font.data.tables.TableRecord;
	import de.maxdidit.hardware.font.parser.DataTypeParser;
	import de.maxdidit.hardware.font.parser.tables.ITableParser;
	import de.maxdidit.hardware.font.parser.tables.TableNames;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class HorizontalMetricsParser implements ITableParser
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _dataTypeParser:DataTypeParser;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function HorizontalMetricsParser($dataTypeParser:DataTypeParser)
		{
			this._dataTypeParser = $dataTypeParser;
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		/* INTERFACE de.maxdidit.hardware.font.parser.tables.ITableParser */
		
		public function parseTable(data:ByteArray, record:TableRecord, tableMap:ITableMap):*
		{
			data.position = record.offset;
			
			var result:HorizontalMetricsData = new HorizontalMetricsData();
			
			var maximumProfileData:MaximumProfileTableData = tableMap.retrieveTable(TableNames.MAXIMUM_PROFILE).data as MaximumProfileTableData;
			var horizontalHeaderData:HorizontalHeaderData = tableMap.retrieveTable(TableNames.HORIZONTAL_HEADER).data as HorizontalHeaderData;
			
			var longHorizontalMetrics:Vector.<LongHorizontalMetric> = parseLongHorizontalMetrics(data, horizontalHeaderData.numberOfHMetrics);
			result.longHorizontalMetrics = longHorizontalMetrics;
			
			var leftSideBearings:Vector.<int> = parseLeftSideBearings(data, maximumProfileData.numGlyphs - horizontalHeaderData.numberOfHMetrics);
			result.leftSideBearings = leftSideBearings;
			
			return result;
		}
		
		private function parseLongHorizontalMetrics(data:ByteArray, numberOfHMetrics:uint):Vector.<LongHorizontalMetric>
		{
			var result:Vector.<LongHorizontalMetric> = new Vector.<LongHorizontalMetric>(numberOfHMetrics);
			
			for (var i:uint = 0; i < numberOfHMetrics; i++)
			{
				var longHorizontalMetric:LongHorizontalMetric = new LongHorizontalMetric();
				
				longHorizontalMetric.advancedWidth = _dataTypeParser.parseUnsignedShort(data);
				longHorizontalMetric.leftSideBearing = _dataTypeParser.parseShort(data);
				
				result[i] = longHorizontalMetric;
			}
			
			return result;
		}
		
		private function parseLeftSideBearings(data:ByteArray, numberOfBearings:uint):Vector.<int>
		{
			var result:Vector.<int> = new Vector.<int>(numberOfBearings);
			
			for (var i:uint = 0; i < numberOfBearings; i++)
			{
				var bearing:int = _dataTypeParser.parseShort(data);
				result[i] = bearing;
			}
			
			return result;
		}
	}

}