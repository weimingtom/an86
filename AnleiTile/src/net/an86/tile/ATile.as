package net.an86.tile
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ATile
	{
		//[Embed(source="assets/tiles/TileA5.png")]
		//private static const TileA5:Class;
		public static const tileSource:BitmapData = new Tile_0(0, 0);
		
		public static var tileW:Number = 32;
		public static var tileH:Number = 32;
		public static var WH:Number = 32;
		
		/**大于1000说明是门ID，则跳转地图*/
		public static const MAP_SP:int = 1000;
		/**可行通过走的地砖ID*/
		public static var walks:Array = [1];
		/**可行通过走的门ID*/		
		public static var doors:Array = [1001, 1002, 1003];
		/**可否行走*/
		public var walkable:Boolean = true;
		
		public var bitmapData:BitmapData;
		
		private var _id:String='';

		private var _rect:Rectangle;
		private var _dest:Point;
		
		public function ATile()
		{
			
		}
		
		public static function getWalk($id:int):Boolean{
			var _walkable:Boolean = false;
			for (var i:int = 0; i < walks.length; i++) 
			{
				if($id == walks[i]){
					_walkable = true;
					break;
				}
			}
			
			for (i = 0; i < doors.length; i++) 
			{
				if($id == doors[i]){
					_walkable = true;
					break;
				}
			}
			return _walkable;
		}
		
		/**二维数组中的[i][j]数值*/
		public function get id():String { return _id; }
		public function set id(value:String):void {
			_id = value;
			walkable = getWalk(int(id));
			var _doorId:int = int(id) > MAP_SP ? 3 : int(id);
			
			if(_rect == null){	
				_rect = new Rectangle(tileW*_doorId, 0, tileW, tileH);
			}
			if(_dest == null){
				_dest = new Point();
			}
			
			bitmapData = new BitmapData(tileW, tileH, true, 0x0);
			bitmapData.copyPixels(tileSource, _rect, _dest);
		}
		
	}
}