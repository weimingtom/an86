package net.an86.tile.role
{
	import net.an86.tile.ATGame;
	import net.an86.tile.ATile;

	public class ATNpcBasic extends ATRoleBasic
	{
		public var id:int;
		
		public function ATNpcBasic(nid:int)
		{
			id = nid;
			super(false, 32, 32);
			this.isNpc = true;
		}
		
		public function dispose():void{
			this.cartoon.dispose();
			this.cartoon = null;
		}
		
		/**把当前NPC所在格子设成不可行走*/
		public function setTileNoWalke($walk:Boolean = false):void{
			ATile(ATGame.world.tiles[ytile+'_'+xtile]).walkable = $walk;
		}
	}
}