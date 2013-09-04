package ui.component
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ui.UIConfig;
	
	/**位图平铺*/
	public class MyBitmapTile extends Sprite
	{
		public var bitData:BitmapData;
		private var bitmap:Bitmap = new Bitmap();
		
		private var w:Number;
		private var h:Number;
		private var _style:int;
		
		public function MyBitmapTile($w:Number = 100, $h:Number = 100)
		{
			w = $w;
			h = $h;
			super();
			addChild(bitmap);
			this.mouseChildren = false;
		}
		
		public function getStyle():int{ return  _style; }
		public function setStyle(n:int):void{
			_style = n;
			var _obj:Object = UIConfig.mcContent;
			bitData = BitmapData(_obj.bitTileStyleCount[n]);
			flush();
		}
		
		private function flush():void {
			if(bitData == null) return;
			if(bitmap.bitmapData) bitmap.bitmapData.dispose();
			bitmap.bitmapData = new BitmapData(w, h, true, 0x0);

			var x_max:uint = Math.ceil(w/bitData.width);
			var y_max:uint = Math.ceil(h/bitData.height);
			for (var i:uint=0; i<x_max; i++) {
				for (var j:uint=0; j<y_max; j++) {
					bitmap.bitmapData.copyPixels(bitData, new Rectangle(0, 0, bitData.width, bitData.height), new Point(bitData.width*i, bitData.height*j));
				}
			}
		}
		
		override public function set width(value:Number):void{
			if(w == value) return;
			w = value;
			flush();
		}
		
		override public function set height(value:Number):void{
			if(h == value) return;
			h = value;
			flush();
		}
		
	}
}