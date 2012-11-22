package net.an86.tile
{
	import net.an86.tile.configs.ATConfigVO;

	/**地图配置表*/
	public class ATConfig
	{
		/**获取地图，门，NPC配置数组*/
		public static function getConfig(mid:int):ATConfigVO{
			var _vo:ATConfigVO = new ATConfigVO();
			var _xml:XMLList = MAP.item.(int(@id) == mid);
			_vo.map = createArr(_xml.map);
			_vo.door = createArr(_xml.door);
			_vo.npc = createArr(_xml.npc);
			return _vo;
		}
		/**将XML中的数据分析成数据*/
		private static function createArr(_xml:String):Array{
			var _arr:Array = [];
			var _iArr:Array = _xml.split('|');
			var _jArr:Array;
			if(_iArr.length > 1){
				for (var i:int = 0; i < _iArr.length; i++) 
				{
					_jArr = _iArr[i].split(',');
					_arr.push(_jArr);
				}
			}else{
				_arr[0] = _iArr[0].split(',');
			}
			return _arr;
		}
		
		public static var MAP:XML = 
		<config>
			<item id="1001">
				<map>
0,0,0,0,0,0,0,0,0,0,0,0,0,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,1|
0,1,0,1,1,1,1,1,1,1,1,0,1,1|
1,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,0,0,0,0,0,0,0,0,0,0,0,0,0
				</map>
				<door>
0,4,3,6,3,1002|
13,2,3,1,3,1003|
13,3,3,1,3,1003
				</door>
				<npc>
6,9,0|
6,7,1|
8,8,2
				</npc>
			</item>
			<item id="1002">
				<map>
0,0,0,0,0,0,0,0|
0,1,1,1,1,1,1,0|
0,1,0,1,1,1,1,0|
0,1,1,1,1,0,1,1|
0,1,1,1,1,1,1,0|
0,0,0,0,0,0,0,0
				</map>
				<door>
7,3,3,1,4,1001
				</door>
				<npc>
1,1,0
				</npc>
			</item>
			<item id="1003">
				<map>
0,0,0,0,0,0,0,0|
0,1,1,1,1,1,1,0|
0,1,0,1,1,1,1,0|
1,1,1,1,1,0,1,0|
0,1,1,1,1,1,1,0|
0,0,0,0,0,0,0,0
				</map>
				<door>
0,3,3,12,2,1001
				</door>
				<npc>
1,1,0
				</npc>
			</item>
		</config>;
		
	}
}