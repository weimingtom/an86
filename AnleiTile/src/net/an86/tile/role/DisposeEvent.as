package net.an86.tile.role
{
	import net.an86.tile.ATGame;

	public class DisposeEvent
	{
		/**
		 * 处发事件
		 * @param away	0=下,1=左,2=右,3=上
		 * @param xtile	主角所在行第几个格子
		 * @param ytile	主角所在列第几个格子
		 */
		public static function invate(away:int, xtile:int, ytile:int):void
		{
			//以方向判断前方的格子
			switch(away){
				case 0:
					ytile++;
					break;
				case 1:
					xtile--;
					break;
				case 2:
					xtile++;
					break;
				case 3:
					ytile--;
					break;
			}
			///前向是否是NPC
			for (var i:int = 0; i < ATGame.npcList.length; i++) 
			{
				if(xtile == ATGame.npcList[i].xtile && ytile == ATGame.npcList[i].ytile){
					trace("是什么事?");
					break;
				}
			}
			
		}
	}
}