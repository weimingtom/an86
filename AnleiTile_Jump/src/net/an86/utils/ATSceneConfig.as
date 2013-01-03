package net.an86.utils
{
	import net.an86.tile.configs.ATConfigVO;

	/**地图配置表*/
	public class ATSceneConfig
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
			if(!Boolean(_xml)) return null;
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
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,0,1,1,1,1,0|
0,1,0,1,1,1,1,0,1,1,1,0,1,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,0,1,1,1,1,1,0|
0,1,1,1,1,1,1,1,1,1,0,1,1,1,0|
0,1,1,1,6,6,6,1,1,1,1,1,1,1,0|
0,1,1,0,1,1,1,0,0,0,0,5,5,5,0|
0,1,1,1,1,1,1,1,1,1,1,1,2,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,2,1,0|
0,1,1,1,1,1,1,1,1,1,1,1,2,1,0|
0,1,5,4,1,3,3,3,1,1,3,1,2,1,0|
0,1,2,1,1,1,1,1,1,1,3,4,2,1,0|
0,1,2,1,1,1,1,1,1,4,4,4,2,1,0|
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
				</map>
				<door>

				</door>
				<npc>
1,2,1|
6,7,2|
2,11,3
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
1,1,4
				</npc>
			</item>
			<item id="1003">
				<map>
0,0,0,0,0,0,0,0|
0,1,1,1,1,1,1,0|
0,1,0,1,1,1,1,0|
0,1,1,1,1,0,1,0|
0,1,1,1,1,1,1,0|
0,0,0,0,0,0,0,0
				</map>
				<door>
0,3,3,12,2,1001
				</door>
				<npc>
1,1,5
				</npc>
			</item>
		</config>;
		
	}
}