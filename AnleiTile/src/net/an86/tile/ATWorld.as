package net.an86.tile
{
	import anlei.db.AccessDB;
	
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	import net.an86.tile.role.ATNpcBasic;

	public class ATWorld
	{
		/**地砖记录器，以[i+'_'+j]方式记录*/
		public var tiles:Dictionary = new Dictionary();
		public var currentMapData:Array;
		
		public function ATWorld()
		{
			
		}
		
		public function clear():void{
			for (var i:int = 0; i < ATGame.npcList.length; i++) 
			{
				if(ATGame.gameContainer.contains(ATGame.npcList[i])){
					ATGame.npcList[i].dispose();
					ATGame.gameContainer.removeChild(ATGame.npcList[i]);
				}
			}
			ATGame.npcList.splice(0, ATGame.npcList.length);
			
			ATGame.gameContainer.graphics.clear();
			ATile.doors = [];
		}
		
		public function createMap($map:Array):void{
			clear();
			currentMapData = $map;
			var mapWidth:int = $map[0].length;
			var mapHeight:int = $map.length;
			for (var i:int = 0; i < mapHeight; ++i) {
				for (var j:int = 0; j < mapWidth; ++j) {
					var _tile:ATile = new ATile();
					
					var _id:String = int($map[i][j]).toString();
					_tile.id = _id;
					ATGame.add(_tile.bitmapData, j*ATile.tileW, i*ATile.tileH);
					tiles[i+'_'+j] = _tile;
				}
			}
		}
		
		public function createDoor($door:Array):void{
			/*0,4,3,0,1,1|0,4,3,0,1,1
			门分析:
			$door[0][0]=行(xtile)
			$door[0][1]=列(ytile)
			$door[0][2]=图形样式
			$door[0][3]=人物移到第几行
			$door[0][4]=人物移到第几列
			$door[0][5]=转到那个地图去(地图ID)
			 */ 
			for (var i:int = 0; i < $door.length; i++) 
			{
				var _tile:ATile = new ATile();
				_tile.id = int($door[i][2]).toString();
				ATile.doors.push($door[i]);
				ATGame.add(_tile.bitmapData, $door[i][0]*ATile.tileW, $door[i][1]*ATile.tileH);
			}
		}
		
		public function createNpc($npc:Array):void{
			/*6,6,0|6,7,1|8,8,2|
			$npc[i][0]=行(xtile)
			$npc[i][1]=列(ytile)
			$npc[i][2]=NPCID
			*/
			for (var i:int = 0; i < $npc.length; i++) {
				var _nid:int = int($npc[i][2]);
				var _cls:Class = ApplicationDomain.currentDomain.getDefinition('Role_'+_nid) as Class;
				var npc:ATNpcBasic = new ATNpcBasic($npc[i][2]);
				npc.setBitmapData(new _cls(0, 0));
				var _xml:XML = AccessDB.getInstance().zip.getXML(_nid.toString());
				npc.parseNpcMissionXML(_xml);
				ATGame.addNpc(npc, int($npc[i][1]), int($npc[i][0]));
			}
		}
		
		
		/**
		 * 分解门ID为[1002, 3, 1]
		 * @param $str	1002=3:1
		 */
		public static function splitJump($xtile:int, $ytile:int):Array{
			for (var i:int = 0; i < ATile.doors.length; i++) 
			{
				var doors:Array = ATile.doors;
				if($xtile == int(doors[i][0]) && $ytile == int(doors[i][1])){
					var _arr:Array = [doors[i][5], doors[i][4], doors[i][3]];
					return _arr;
				}
			}
			return null;
		}
		
	}
}