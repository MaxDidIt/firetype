package de.maxdidit.hardware.font.data.tables.other.dsig 
{
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class DigitalSignatureTableData 
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		// header
		
		private var _version:uint;
		private var _numSignatures:uint;
		private var _flags:uint;
		
		// signatures
		private var _signatures:Vector.<DigitalSignature>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function DigitalSignatureTableData() 
		{
			
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// version
		
		public function get version():uint 
		{
			return _version;
		}
		
		public function set version(value:uint):void 
		{
			_version = value;
		}
		
		// numSignatures
		
		public function get numSignatures():uint 
		{
			return _numSignatures;
		}
		
		public function set numSignatures(value:uint):void 
		{
			_numSignatures = value;
		}
		
		// flags
		
		public function get flags():uint 
		{
			return _flags;
		}
		
		public function set flags(value:uint):void 
		{
			_flags = value;
		}
		
		// signatures
		
		public function get signatures():Vector.<DigitalSignature> 
		{
			return _signatures;
		}
		
		public function set signatures(value:Vector.<DigitalSignature>):void 
		{
			_signatures = value;
		}
		
	}

}