package anlei.util.cmouse
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursorData;

	public class CustomMouseIcon
	{
		[Embed(source="Cursor_def.png")]
		private static const DEF_Cls:Class;
		
		[Embed(source="Cursor_busy.png")]
		private static const BUSY_Cls:Class;
		
		private static const DEF:String = 'def';
		private static const BUSY:String = 'busy';
		
		private var def_cursor:MouseCursorData;
		private var busy_cursor:MouseCursorData;
		
		
		public function CustomMouseIcon()
		{
			
		}
		
		private function splitBD(bd:BitmapData, _w:int, _h:int):Vector.<BitmapData>{
			var list:Vector.<BitmapData> = new Vector.<BitmapData>();
			for (var i:int = 0; i < bd.width/_w; i++) 
			{
				var _bd:BitmapData = new BitmapData(_w, _h, true, 0x0);
				_bd.copyPixels(bd, new Rectangle(i * _w, 0, _w, _h), new Point());
				list.push(_bd);
			}
			return list;
		}
		
		private function getBD_def():Vector.<BitmapData>{
			var bd:BitmapData = new DEF_Cls().bitmapData;
			var list:Vector.<BitmapData> = splitBD(bd, 24, 20);
			return list;
		}
		
		private function getBD_busy():Vector.<BitmapData>{
			var bd:BitmapData = new BUSY_Cls().bitmapData;
			var list:Vector.<BitmapData> = splitBD(bd, 23, 18);
			return list;
		}
		
		public function showDef():void{
			if(def_cursor == null){
				def_cursor = new MouseCursorData();
				def_cursor.data = getBD_def();
				def_cursor.frameRate = 12;
				Mouse.registerCursor(DEF, def_cursor);
			}
			Mouse.cursor = DEF;
		}
		
		
		public function showBusy():void{
			if(busy_cursor == null){
				busy_cursor = new MouseCursorData();
				busy_cursor.data = getBD_busy();
				busy_cursor.frameRate = 12;
				Mouse.registerCursor(BUSY, busy_cursor);
			}
			Mouse.cursor = BUSY;
		}
	}
}