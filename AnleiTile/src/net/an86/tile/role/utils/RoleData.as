package net.an86.tile.role.utils
{
	import net.an86.tile.shop.ShopMenuItemData;
	import net.an86.ui.menu.ATMenuItemData;

	public class RoleData
	{
		public var id:int = 0;
		/**攻*/
		public var equip_at:ATMenuItemData = new ShopMenuItemData();
		/**防御*/
		public var equip_dp:ATMenuItemData = new ShopMenuItemData();
		/**饰品*/
		public var equip_ahp:ATMenuItemData = new ShopMenuItemData();
		
		public var name:String = '暗泪';
		/**等级*/
		public var level:int = 1;
		/**生命值*/
		public var hp:int = 10;
		/**最生命值*/
		public var maxHP:int = 10;
		/**经验*/
		public var exp:int = 0;
		/**当前升级所要的经验*/
		public var maxExp:int = 0;
		
		/**攻击*/
		public var at:Number = 0;
		/**防御*/
		public var dp:Number = 0;
		/**附加生命值*/
		public var ahp:Number = 0;
		/**敏捷*/
		public var agile:Number = 10;
		
		public function RoleData()
		{
		}
	}
}