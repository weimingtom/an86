package tilegame.tile
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Anlei
	 */
	public class TileFactory 
	{
		private static var _instance:TileFactory;
		
		public function TileFactory(signle:Signle) 
		{
			if (signle == null) throw new Error("不能new");
		}
		public static function getInstance():TileFactory {
			if (_instance == null) _instance = new TileFactory(new Signle());
			return _instance;
		}
		
		public function getClipSource($id:int):TileGroup {
			var _spt:TileGroup;
			switch($id) {
				case 0:
					_spt = new TileGroup(true, new tile_0());
					break;
				case 1:
					_spt = new TileGroup(false, new tile_1());
					break;
				case 2:
					_spt = new TileGroup(true, new tile_2(), true);
					break;
			}
			return _spt;
		}
	}

}
class Signle { }