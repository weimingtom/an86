package net.an86.utils.menu
{
	import flash.display.BitmapData;
	
	import net.an86.ui.MyBitmap;
	
	import ui.component.MyTextField;
	
	public class ATMenuItem extends MyBitmap
	{
		private var _data:ItemData;
		
		private var _icon:MyBitmap = new MyBitmap();
		
		private var _txt:MyTextField = new MyTextField();
		
		public function ATMenuItem()
		{
			super();
			_icon.x = 10;
			_icon.y = 10;
			
			_txt.width = 50;
			_txt.height= 20;
			_txt.x = 20 + 10;
			_txt.y = 10;
			
			this.sp.graphics.clear();
			this.sp.graphics.beginFill(0x0, 0.5);
			this.sp.graphics.drawRect(0, 0, 90 + 20);
			this.sp.graphics.endFill();
			
		}

		public function get data():ItemData { return _data; }
		public function set data(value:ItemData):void {
			_data = value;
			_txt.text = value.name;
			_icon.bitmapData = new icon(0, 0);
			
			this.sp.addChild(_icon);
			this.sp.addChild(_txt);
			this.fill();
		}

	}
}