package ui.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import ui.abs.AbstractComponent;
	
	/**
	 * 将系统的TextField包装过
	 * @author Anlei
	 */
	public class MyTextField extends TextField implements AbstractComponent
	{
		/*public static const FONT:String = '宋体';
		private static const TextSize:int = 12;*/
		public var textformat:MyTextFormat;
		
		private var _isStroke:Boolean = false;
		public var storeFilter:GlowFilter = new GlowFilter(0x0,1,2,2,10,1);
		private var _filter:Array;
		
		private var _isInput:Boolean = false;
		//public var _textBitmap:Bitmap;

		private var _textBitmap:Bitmap;
		
		public function MyTextField()
		{
			super();
			reset();
			_filter = filters;
			isStroke = true;
			this.selectable = false;
		}
		
		public function dispose():void{
			storeFilter = null;
			_filter = null;
			textformat = null;
			/*if(_textBitmap){
				if(_textBitmap.bitmapData){
					_textBitmap.bitmapData.dispose();
					_textBitmap.bitmapData = null;
				}
				_textBitmap = null;
			}*/
		}
		
		private function reCreateTF():void{
			textformat = new MyTextFormat();
			textformat.color = 0xFFFFFF;
			textformat.size = MyTextFormat.TextSize;
			textformat.leading = 1;
			textformat.letterSpacing = 1;
			textformat.font = MyTextFormat.FONT;
			textColor = uint(textformat.color);
		}
		
		/**创建位图式的文本显示*/
		public function get bitmap():Bitmap{
			if(_textBitmap && _textBitmap.bitmapData) _textBitmap.bitmapData.dispose();
			if(!_textBitmap) _textBitmap = new Bitmap();
			var bd:BitmapData = new BitmapData(width, height, true, 0x0);
			bd.draw(this);
			_textBitmap.bitmapData = bd;
			//_textBitmap.x = -_textBitmap.width/2;
			return _textBitmap;
		}
		
		
		public function reset():void{
			this.wordWrap = true;
			this.multiline = true;
			this.antiAliasType = AntiAliasType.ADVANCED;
			this.height = MyTextFormat.TextSize + 7;
			reCreateTF();
			this.setTextFormat(textformat);
			this.defaultTextFormat = textformat;
		}
		
		public function flushFormat():void{
			if(textformat){
				this.setTextFormat(textformat);
				this.defaultTextFormat = textformat;
			}
		}
		
		override public function set text(value:String):void{
			super.text = value;
			flushFormat();
		}
		override public function set htmlText(value:String):void{
			super.htmlText = value;
			//flushFormat();
		}
		public function get strokeColor():uint{ return storeFilter.color; }
		public function set strokeColor(value:uint):void{ storeFilter.color = value; isStroke = true; }
		
		public function get strokeAlpha():Number{ return storeFilter.alpha; }
		public function set strokeAlpha(value:Number):void{ storeFilter.alpha = value; isStroke = true; }
		
		/**是否要描边文本*/
		public function get isStroke():Boolean{ return _isStroke; }
		public function set isStroke(b:Boolean):void{
			_isStroke = b;
			var _index:int;
			if(b){
				_index = _filter.indexOf(storeFilter);
				if(_index == -1){
					_filter.push(storeFilter);
				}
			}else{
				_index = _filter.indexOf(storeFilter);
				if(_index != -1){
					_filter.splice(_index, 1);
				}
			}
			filters = _filter;
		}
		
		public function set align(value:String):void{
			format.align = value;
			flushFormat();
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
			flushFormat();
		}
		
		public function get format():MyTextFormat{return textformat; }
		public function set format($format:MyTextFormat):void{
			textformat = $format;
			flushFormat();
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