package de.maxdidit.hardware.text
{
	import flash.geom.Matrix3D;
	
	/**
	 * ...
	 * @author Max Knoblich
	 */
	public class TransformedInstance
	{
		///////////////////////
		// Member Fields
		///////////////////////
		
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		private var _scaleX:Number = 1;
		private var _scaleY:Number = 1;
		
		protected var _children:Vector.<TransformedInstance>;
		
		private var _isDirty:Boolean = true;
		private var _localTransformation:Matrix3D;
		private var _globalTransformation:Matrix3D;
		
		private var _rawLocalData:Vector.<Number>;
		
		///////////////////////
		// Constructor
		///////////////////////
		
		public function TransformedInstance()
		{
			_children = new Vector.<TransformedInstance>();
			_localTransformation = new Matrix3D();
			_globalTransformation = new Matrix3D();
			
			_rawLocalData = new Vector.<Number>();
			_rawLocalData.push(	1, 0, 0, 0, //
								0, 1, 0, 0, //
								0, 0, 1, 0, //
								0, 0, 0, 1);
		}
		
		///////////////////////
		// Member Properties
		///////////////////////
		
		// x
		
		public function get x():Number
		{
			return _x;
		}
		
		public function set x(value:Number):void
		{
			if (_x != value)
			{
				_x = value;
				_isDirty = true;
			}
		}
		
		// y
		
		public function get y():Number
		{
			return _y;
		}
		
		public function set y(value:Number):void
		{
			if (_y != value)
			{
				_y = value;
				_isDirty = true;
			}
		}
		
		// transformation
		
		public function get localTransformation():Matrix3D
		{
			return _localTransformation;
		}
		
		public function get globalTransformation():Matrix3D 
		{
			return _globalTransformation;
		}
		
		// scaleX
		
		public function get scaleX():Number 
		{
			return _scaleX;
		}
		
		public function set scaleX(value:Number):void 
		{
			if (_scaleX != value)
			{
				_scaleX = value;
				_isDirty = true;
			}
		}
		
		// scaleY
		
		public function get scaleY():Number 
		{
			return _scaleY;
		}
		
		public function set scaleY(value:Number):void 
		{
			if (_scaleY != value)
			{
				_scaleY = value;
				_isDirty = true;
			}
		}
		
		///////////////////////
		// Member Functions
		///////////////////////
		
		public function addChild(child:TransformedInstance):void
		{
			_children.push(child);
		}
		
		public function loseAllChildren():void
		{
			_children.length = 0;
		}
		
		public function calculateTransformations(parentGlobalTransformation:Matrix3D = null, parentChanged:Boolean = false):void
		{
			// calculate local transformation
			if (_isDirty)
			{
				_rawLocalData[0] = _scaleX;
				_rawLocalData[5] = _scaleY;
				
				_rawLocalData[12] = _x;
				_rawLocalData[13] = _y;
				
				_localTransformation.rawData = _rawLocalData;
			}
			
			if (_isDirty || parentChanged)
			{
				if (parentGlobalTransformation)
				{
					_globalTransformation.copyFrom(parentGlobalTransformation);
				}
				else
				{
					_globalTransformation.identity();
				}
				
				_globalTransformation.prepend(_localTransformation);
			}
			
			const l:uint = _children.length;
			for (var i:uint = 0; i < l; i++)
			{
				_children[i].calculateTransformations(_globalTransformation, _isDirty || parentChanged);
			}
			
			_isDirty = false;
		}
		
		public function clone():TransformedInstance
		{
			var result:TransformedInstance = new TransformedInstance();
			
			result.x = _x;
			result.y = _y;
			
			return result;
		}
	}

}