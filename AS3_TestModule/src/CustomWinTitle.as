package
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import ui.component.MyBorderText;
	
	public class CustomWinTitle extends MyBorderText
	{
		/**[可变]窗体的图片[1]默认*/
		public var DATA:BitmapData;
		
		public function CustomWinTitle($text:String)
		{
			super($text, DATA, new Rectangle(60, 0, 6, 29));
		}
	}
}