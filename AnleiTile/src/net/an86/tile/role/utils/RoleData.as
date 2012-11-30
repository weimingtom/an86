package net.an86.tile.role.utils
{
	import net.an86.ui.menu.ATMenuItemData;

	public class RoleData
	{
		public var id:int = 1;
		/**攻*/
		public var equip_at:ATMenuItemData = new ATMenuItemData();
		/**防御*/
		public var equip_dp:ATMenuItemData = new ATMenuItemData();
		/**饰品*/
		public var equip_ahp:ATMenuItemData = new ATMenuItemData();
		
		public var name:String = '暗泪';
		/**等级*/
		public var level:int = 1;
		/**血*/
		public var hp:int = 10;
		/**最大血*/
		public var hpMax:int = 10;
		public var exp:int = 0;
		public var expMax:int = 0;
		
		public var at:Number = 0;
		public var dp:Number = 0;
		public var ahp:Number = 0;
		
		
		
		public function RoleData()
		{
		}
	}
}