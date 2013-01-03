package net.an86.tile.role.utils
{

	public class RoleData
	{
		public var id:int = 0;
		
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
		//////////
		/**移动速度*/
		public var speed:int = 4;
		public var jumpstart:int = -18;
		public var gravity:int = 2;
		public var jump:Boolean = false;
		public var jumpspeed:int = 0;
		
		public var xstep:Number = 0;
		public var ystep:Number = 0;
		
		public function RoleData()
		{
		}
	}
}