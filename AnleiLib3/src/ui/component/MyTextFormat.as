package ui.component
{
	import flash.text.TextFormat;
	
	public class MyTextFormat extends TextFormat
	{
		public static var FONT:String = '宋体';
		public static var TextSize:int = 12;
		
		public function MyTextFormat(font:String='宋体', size:Object=12, color:Object=null, bold:Object=null, italic:Object=null, underline:Object=null, url:String=null, target:String=null, align:String=null, leftMargin:Object=null, rightMargin:Object=null, indent:Object=null, leading:Object=null)
		{
			super(font, size, color, bold, italic, underline, url, target, align, leftMargin, rightMargin, indent, leading);
		}
	}
}