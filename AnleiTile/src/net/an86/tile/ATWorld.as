package net.an86.tile
{
	import flash.utils.Dictionary;

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
					ATGame.gameContainer.removeChild(ATGame.npcList[i]);
				}
			}
			
			ATGame.gameContainer.graphics.clear();
		}
		
		public function create($map:Array):void{
			currentMapData = $map;
			clear();
			var mapWidth:int = $map[0].length;
			var mapHeight:int = $map.length;
			for (var i:int = 0; i < mapHeight; ++i) {
				for (var j:int = 0; j < mapWidth; ++j) {
					var _tile:ATile = new ATile();
					
					var _id:String = $map[i][j];
					if(_id.indexOf('=')!=-1){
						var _arr:Array = _id.split('=');
						_id = _arr[0];
					}
					_tile.id = _id;
					ATGame.add(_tile.bitmapData, j*ATile.tileW, i*ATile.tileH);
					tiles[i+'_'+j] = _tile;
				}
			}
		}
		
		
		/**
		 * 分解门ID为[1002, 3, 1]
		 * @param $str	1002=3:1
		 */
		public static function splitJump($str:String):Array{
			if($str.indexOf('=')!=-1){
				var _arr:Array = $str.split('=');
				$str = _arr[0];
				_arr = _arr[1].split(':');
				var _i:int = _arr[0];
				var _j:int = _arr[1];
				return [int($str), _i, _j];
			}
			return [int($str)];
		}
		
	}
}