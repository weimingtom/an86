package net.an86.tile.role
{
	import com.D5Power.mission.NPCMissionConfig;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.ATile;

	public class ATNpcBasic extends ATRoleBasic
	{
		public var id:int;
		protected var _misConf:NPCMissionConfig;
		
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
		
		
		public function get missionConfig():NPCMissionConfig
		{
			return _misConf;
		}
		
		/**处理NPC的任务XML数据*/
		public function parseNpcMissionXML(xml:XML):void{
			
			_misConf = new NPCMissionConfig();
			_misConf._say = xml.nomission.info;
			_misConf._npcname = xml.npcname;
			if(xml.nomission.event)
			{
				_misConf._setEvent(xml.nomission.event.attribute('type'),xml.nomission.event.attribute('value'));
			}
			
			for each(var data:* in xml.mission)
			{
				_misConf.addMission(data.id,data);
			}
		}
		
	}
}