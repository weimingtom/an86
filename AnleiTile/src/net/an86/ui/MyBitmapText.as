package net.an86.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import ui.component.MyTextField;
	
	/**位图文本*/
	public class MyBitmapText extends MyTextField
	{
		public var bitmap:Bitmap;
		
		public function MyBitmapText()
		{
			super();
			bitmap = new Bitmap();
		}
		
		public function getBitmapData():BitmapData{
			var bd:BitmapData = new BitmapData(this.width, this.height, true, 0x0);
			bd.draw(this);
			return bd;
		}
		
		public function fillBitmap():Bitmap{
			bitmap.bitmapData = getBitmapData();
			return bitmap;
		}
	}
}