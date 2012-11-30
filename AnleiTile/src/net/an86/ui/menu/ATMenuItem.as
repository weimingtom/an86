package net.an86.ui.menu
{
	import flash.display.BitmapData;
	
	import net.an86.ui.MyBitmap;
	
	import ui.component.MyTextField;
	
	public class ATMenuItem extends MyBitmap
	{
		private var _data:ATMenuItemData;
		
		private var _icon:MyBitmap = new MyBitmap();
		
		private var _txt:MyTextField = new MyTextField();
		
		public function ATMenuItem()
		{
			super();
			_icon.x = 5;
			_icon.y = 5;
			_txt.border = true;
			_txt.width = 60;
			_txt.height= 20;
			_txt.x = 30;
			_txt.y = 3;
			
			this.sp.graphics.clear();
			this.sp.graphics.beginFill(0x0, 1);
			this.sp.graphics.drawRect(0, 0, 90, 25);
			this.sp.graphics.endFill();
			
		}
		
		override public function dispose():void{
			super.dispose();
			
			_data = null;
			_icon = null;
			_txt.dispose();
			_txt = null;
		}

		public function get data():ATMenuItemData { return _data; }
		public function set data(value:ATMenuItemData):void {
			_data = value;
			if(value){
				if(value.name){
					_txt.text = value.name;
					_icon.bitmapData = new icon(0, 0);
				}
				this.sp.addChild(_icon);
				this.sp.addChild(_txt);
				this.draw();
			}
		}
		
		public function clear():void{
			if(_txt){
				_txt.text = '';
			}
			this.draw();
		}

	}
}