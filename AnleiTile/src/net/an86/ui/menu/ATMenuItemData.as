package net.an86.ui.menu
{
	public class ATMenuItemData
	{
		private var _type:String;
		//zb,at表现为装备类型，加攻
		/**物品类型:如:zb,at则为zb*/
		public var type_type:String;
		/**物品类型描述:如:zb,at则为at*/
		public var type_desc:String;
		
		public var id:int;
		public var price:int;
		public var name:String;
		public var data:Object;
		
		public var desc:String;
		
		public function ATMenuItemData()
		{
			
		}

		public function exec():void {
			
		}

		public function get type():String { return _type; }
		public function set type(value:String):void {
			_type = value;
			var _arr:Array = type.split(',');
			type_type = _arr[0];
			type_desc = _arr[1];
		}

		
	}
}