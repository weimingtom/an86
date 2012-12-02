package net.an86.tile.shop
{
	import anlei.db.AccessDB;

	public class ATShopConfig
	{
		public static function get shop1():XML {
			var _xml:XML = AccessDB.getInstance().zip.getList('items',
				ShopMenuItemData.TYPE_TYPE_ZB + ','
				+ ShopMenuItemData.TYPE_DESC_AT,
				'type');
			return _xml;
		}
		
		public static function get shop2():XML {
			var _xml:XML = AccessDB.getInstance().zip.getList('items',
				ShopMenuItemData.TYPE_TYPE_ZB + ','
				+ ShopMenuItemData.TYPE_DESC_DP,
				'type');
			return _xml;
		}
		
		
		
	}
}