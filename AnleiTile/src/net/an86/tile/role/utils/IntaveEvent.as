package net.an86.tile.role.utils
{
	import com.D5Power.mission.MissionData;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.role.ATNpcBasic;
	import net.an86.ui.alert.Alert;
	import net.an86.ui.menu.ATMenu;
	import net.an86.tile.menu.ATMenuConfig;

	public class IntaveEvent
	{
		/**
		 * 处发事件，如：对话
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
				var _npc:ATNpcBasic = ATGame.npcList[i];
				if(xtile == _npc.xtile && ytile == _npc.ytile){
					
					var list:Vector.<MissionData> = _npc.missionConfig.getList(ATGame.userdata);
					//(_perception.Scene as D5Scene).missionCallBack(to.missionConfig.npcname,to.missionConfig.say,to.missionConfig.event,list,to);
					Alert.show('<font color="#00FF00">'+_npc.missionConfig.npcname + ":</font>\n    " + _npc.missionConfig.say);
					//
					//
					//
					if(_npc.missionConfig.event.type){
						DisposeMEvent.dispose(_npc.missionConfig.event);
					}
					ATGame.roleList[0].isCtrl = false;
					
					//NPC面向主角
					var _away:int;
					switch(away){
						case 0:
							_away = 3;
							break;
						case 1:
							_away = 2;
							break;
						case 2:
							_away = 1;
							break;
						case 3:
							_away = 0;
							break;
					}
					_npc.cartoon.playRow(_away);
					break;
				}
			}
			
		}
		
	}
}