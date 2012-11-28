package net.an86.utils.menu
{
	import ui.abs.MenuItem;

	public class ATMenu
	{
		private static const LEN:int = 6;
		private var _data:XML;
		
		public function ATMenu($data:XML)
		{
			data = $data;
		}

		public function get data():XML { return _data; }
		public function set data(value:XML):void {
			_data = value;
			var _len:int = data.children().length();
			for (var i:int = 0; i < _len; i++) 
			{
				var _tile:ATMenuItem = new ATMenuItem();
				var _vo:ItemData = new ItemData();
				_vo.id = 
				_tile.data = _vo;
			}
			
		}

	}
}