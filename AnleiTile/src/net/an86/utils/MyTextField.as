package net.an86.utils
{
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * 将系统的TextField包装过
	 * @author Anlei
	 */
	public class MyTextField extends TextField
	{
		public static const FONT:String = '宋体';
		private static const TextSize:int = 12;
		private var textformat:TextFormat;
		
		private var _isStroke:Boolean = false;
		private var _gf:GlowFilter = new GlowFilter(0x0,1,2,2,10,1);
		private var _filter:Array;
		
		private var _isInput:Boolean = true;
		
		public function MyTextField()
		{
			super();
			reset();
			_filter = filters;
		}
		public function dispose():void{
			_gf = null;
			_filter = null;
			format = null;
		}
		private function reCreateTF():void{
			textformat = new TextFormat();
			textformat.color = 0xFFFFFF;
			textformat.size = TextSize;
			textformat.leading = 1;
			textformat.font = FONT;
		}
		public function reset():void{
			this.wordWrap = true;
			this.multiline = true;
			this.antiAliasType = AntiAliasType.ADVANCED;
			this.height = TextSize + 7;
			reCreateTF();
			this.setTextFormat(textformat);
			this.defaultTextFormat = textformat;
		}
		
		public function get strokeColor():uint{ return _gf.color; }
		public function set strokeColor(value:uint):void{ _gf.color = value; isStroke = true; }
		
		/**是否要描边文本*/
		public function get isStroke():Boolean{ return _isStroke; }
		public function set isStroke(b:Boolean):void{
			_isStroke = b;
			var _index:int;
			if(b){
				_index = _filter.indexOf(_gf);
				if(_index == -1){
					_filter.push(_gf);
				}
			}else{
				_index = _filter.indexOf(_gf);
				if(_index != -1){
					_filter.splice(_index, 1);
				}
			}
			filters = _filter;
		}
		
		public function set align(value:String):void{
			format.align = value;
			format = format;
		}
		
		public function get isBackground():Boolean{ return this.background; }
		public function set isBackground(_onf:Boolean):void{
			this.background = _onf;
		}
		
		public function get isInput():Boolean{ return _isInput; }
		public function set isInput(_onf:Boolean):void{
			_isInput = _onf;
			if(_onf){
				this.type = TextFieldType.INPUT;
			}else{
				this.type = TextFieldType.DYNAMIC;
			}
		}
		
		public function get size():int{ return int(format.size); }
		public function set size(value:int):void{
			format.size = value;
			format = format;
		}
		
		public function get format():TextFormat{ return textformat; }
		public function set format($format:TextFormat):void{
			textformat = $format;
			this.setTextFormat(textformat);
			this.defaultTextFormat = textformat;
		}
		
		/**设置位置*/
		public function move(_x:Number, _y:Number):void{
			this.x = _x;
			this.y = _y;
		}
		/**设置大小*/
		public function setSize(_width:Number, _height:Number):void{
			width = _width;
			height= _height;
		}
		
	}
}