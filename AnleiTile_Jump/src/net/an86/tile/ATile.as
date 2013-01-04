package net.an86.tile
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class ATile extends Bitmap
	{
		public static const tileSource:BitmapData = new TileA(0, 0);
		
		public static var tileW:Number = 32;
		public static var tileH:Number = 32;
		
		/**可行通过走的地砖ID*/
		public static var walks:Array = [1, 3, 4, 2, 5, 6];
		/**可行通过走的门ID*/		
		public static var doors:Array = [[0,4,3,0,1,1], [0,4,3,0,1,1], [0,4,3,0,1,1]];
		/**可否行走*/
		public var walkable:Boolean = true;
		/**是否是云层*/
		public var cloud:Boolean = false;
		public var ladder:Boolean = false;
		public var pole:Boolean = false;
		
		private var _id:String='';

		private var _rect:Rectangle;
		private var _dest:Point;
		
		public function ATile()
		{
			//alpha = 0.3;
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
			var tid:int = int(id);
			walkable = getWalk(tid);
			
			cloud = false;
			if(tid == 3 || tid == 4){
				cloud = true;
			}
			
			ladder = false;
			if(tid == 2 || tid == 5){
				ladder = true;
			}
			
			pole = false;
			if(tid == 6){
				pole = true;
			}
			
			if(_rect == null){
				_rect = new Rectangle(tileW*int(id), 0, tileW, tileH);
			}
			_rect.x = tileW*int(id);
			
			if(_dest == null){
				_dest = new Point();
			}
			if(bitmapData){
				bitmapData.dispose();
			}
			bitmapData = new BitmapData(tileW, tileH, true, 0x0);
			if(cloud || ladder || pole){
				bitmapData.copyPixels(tileSource, new Rectangle(tileW, 0, tileW, tileH), _dest);
			}
			bitmapData.copyPixels(tileSource, _rect, _dest, null, null, true);
			//if(id == '1'){
				//_rect = new Rectangle(tileW*5, 0, tileW, tileH);
				//bitmapData.copyPixels(tileSource, _rect, _dest);
			//}
		}
		
	}
}