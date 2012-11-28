package net.an86.utils.menu
{
	public class ItemData
	{
		public var id:int;
		public var label:String;
		private var _data:Object;
		
		public function ItemData()
		{
		}

		public function get data():Object { return _data; }
		public function set data(value:Object):void {
			_data = value;
			
		}

	}
}