package net.an86.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class MyBitmap extends Bitmap
	{
		protected var sp:Sprite;
		
		public function MyBitmap()
		{
			sp = new Sprite();
		}
		
		public function draw():void{
			if(sp.width <= 0 || sp.height <= 0) return;
			var bd:BitmapData = new BitmapData(sp.width, sp.height, true, 0x0);
			bd.draw(sp);
			this.bitmapData = bd;
		}
		
		
		public function dispose():void{
			sp = null;
			this.bitmapData.dispose();
		}
	}
}