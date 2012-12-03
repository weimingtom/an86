package net.an86.tile.shop
{
	import anlei.db.AccessDB;

	public class ATShopConfig
	{
		private static function getShopXML(DESC:String):XML{
			var _xml:XML = AccessDB.getInstance().zip.getList('items',
				ShopMenuItemData.TYPE_TYPE_ZB + ','
				+ DESC,
				'type');
			return _xml;
		}
		
		public static function get shop1():XML {
			var _xml:XML = getShopXML(ShopMenuItemData.TYPE_DESC_AT);
			return _xml;
		}
		
		public static function get shop2():XML {
			var _xml:XML = getShopXML(ShopMenuItemData.TYPE_DESC_DP);
			return _xml;
		}
		
		public static function get shop3():XML {
			var _xml:XML = getShopXML(ShopMenuItemData.TYPE_DESC_AHP);
			return _xml;
		}
		
		
		
	}
}