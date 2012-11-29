package net.an86.tile.menu
{
	import net.an86.ui.menu.ATMenuItemData;
	
	public class ShopMenuItemData extends ATMenuItemData
	{
		/**装备类*/
		public static const TYPE_TYPE_ZB:String = 'zb';
		/**道具类*/
		public static const TYPE_TYPE_DJ:String = 'dj';
		/////物品类型描述
		public static const TYPE_DESC_AT:String = 'at';
		public static const TYPE_DESC_DP:String = 'dp';
		public static const TYPE_DESC_AHP:String = 'ahp';
		
		public static const DESC_AT:String = '攻击';
		public static const DESC_DP:String = '防御';
		public static const DESC_AHP:String = '生命';
		
		public function ShopMenuItemData() { super(); }
		
		override public function exec():void {
			var _t:String = '';
			switch(type_desc){
				case TYPE_DESC_AT:
					_t = DESC_AT;
					break;
				case TYPE_DESC_DP:
					_t = DESC_DP;
					break;
				case TYPE_DESC_AHP:
					_t = DESC_AHP;
					break;
			}
			var _typeStr:String = '';
			switch(type_type){
				case TYPE_TYPE_ZB:
					_typeStr = '装备';
					break;
				case TYPE_TYPE_DJ:
					_typeStr = '道具';
					break;
			}
			desc = _typeStr + ':' + name + '\n价格:' + price + '\n' + _t + '+' + data;
		}
		
	}
}