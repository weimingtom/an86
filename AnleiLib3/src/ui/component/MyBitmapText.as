package ui.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ui.UIConfig;

	/**位图字体*/
	public class MyBitmapText extends Sprite
	{
		public var configXML:XML;
		public var bitData:BitmapData;
		public var _style:int;
		/////////////////////////
		
		public var bitmap:Bitmap = new Bitmap();
		
		private var _text:String;
		
		private var _gap:Number = 4;
		
		public var SPACE_CHAR:int = 10;
		
		public function MyBitmapText()
		{
			super();
			addChild(bitmap);
			this.mouseChildren = false;
		}
		
		public function getStyle():int{ return  _style; }
		public function setStyle(n:int):void{
			_style = n;
			var _obj:Object = UIConfig.mcContent;
			configXML = XML(_obj.fontFntStyleCount[n]);
			bitData = BitmapData(_obj.fontPngStyleCount[n]);
			flush();
		}
		
		public function setStyleRes($xml:XML, $bitData:BitmapData):void{
			configXML = $xml;
			bitData = $bitData;
			flush();
		}
		
		public function get text():String{ return _text; }
		public function set text(value:String):void{
			if(_text == value) return;
			_text = value;
			if(!configXML) setStyle(0);
			flush();
		}
		
		public function flush():void {
			if(!text){
				if(bitmap.bitmapData)
					bitmap.bitmapData.dispose();
				return;
			}
			
			var _len:int = text.length;
			var _maxW:Number = 0;
			var _maxH:Number = 0;
			var _bdList:Vector.<BTItem> = new Vector.<BTItem>();
			for (var i:int = 0; i < _len; i++) 
			{
				var num:Number = text.charCodeAt(i);
				var _xml:XMLList = configXML.chars.char.(@id == String(num));
				var w:Number = Number(_xml.@width);
				var h:Number = Number(_xml.@height);
				var _x:Number = Number(_xml.@x);
				var _y:Number = Number(_xml.@y);
				//若没有该字符存在，则设成10x10;
				if(w <= 0) w = SPACE_CHAR;
				if(h <= 0) h = SPACE_CHAR;
				_maxW += w;
				_maxH = Math.max(_maxH, h);//取最大高度
				
				var _bd:BitmapData = new BitmapData(w, h, true, 0x0);
				_bd.copyPixels(bitData, new Rectangle(_x, _y, w, h), new Point(0, 0));
				if(_x <= 0) _x = _maxW;
				if(_y <= 0) _y = _maxH;
				/*
				if(_x == 0 && _y == 0 && w == SPACE_CHAR && h == SPACE_CHAR){
					trace("SP");
				}
				*/
				var _item:BTItem = new BTItem();
				_item.w = w;
				_item.h = h;
				_item.x = _x;
				_item.y = _y;
				_item.bit = _bd;
				_bdList.push(_item);
				
			}
			
			if(_maxW > 0 && _maxH > 0){
				bitmap.bitmapData = new BitmapData(_maxW + gap * (_len-1), _maxH, true, 0x0);
				_maxW = 0;
				//_maxH = 0;
				for (i = 0; i < _len; i++) {
					var _H:Number = (_maxH - _bdList[i].h)/2;
					bitmap.bitmapData.copyPixels(_bdList[i].bit, new Rectangle(0, 0, _bdList[i].w, _bdList[i].h), new Point(_maxW, _H));
					_maxW += _bdList[i].w + gap;
					//_maxH += _bdList[i].h;
				}
			}
			
			bitmap.smoothing = true;
		}

		public function get gap():Number { return _gap; }
		public function set gap(value:Number):void {
			if(gap != value){
				_gap = value;	
				flush();
			}
		}
		
		override public function set width(value:Number):void{}
		override public function set height(value:Number):void{}

		
		/**设置位置*/
		public function move(_x:Number, _y:Number):void{
			this.x = _x;
			this.y = _y;
		}
	}
}

import flash.display.BitmapData;

class BTItem {
	public var bit:BitmapData;
	public var w:Number;
	public var h:Number;
	public var x:Number;
	public var y:Number;
}
