package tilegame
{
	import flash.display.Sprite;
	import tilegame.role.Char;
	import tilegame.tile.Tile;
	import tilegame.role.AbstractRole;
	/**
	 * ...
	 * @author Anlei
	 */
	public class TileWorld extends Sprite
	{
		private static var _instance:TileWorld;
		
		public function TileWorld(signle:Signle) 
		{
			if (signle == null) throw new Error("不能new");
			inits();
		}
		public static function getInstance():TileWorld {
			if (_instance == null) _instance = new TileWorld(new Signle());
			return _instance;
		}
		
		public var mapLayer:Sprite = new Sprite();
		public var mapData:Array = [];
		public static const tileW:Number = 32;
		public static const tileH:Number = 32;
		public static var mapW:int;
		public static var mapH:int;
		
		private function inits():void {
			this.addChild(mapLayer);
		}
		private function clearMap():void {
			for (var i:int = 0 ; i < mapData.length; i++) {
				for (var j:int = 0 ; j < mapData[i].length; j++) {
					var _tile:Tile = new Tile();
					if (mapLayer.contains(mapData[i][j])) mapLayer.removeChild(mapData[i][j]);
					mapData[i][j] = null;
				}
				mapData[i] = null;
			}
			mapData = [];
		}
		private function drawMap($data:Array):void {
			mapW = $data.length;
			mapH = $data[i].length;
			for (var i:int = 0 ; i < mapW; i++) {
				mapData[i] = [];
				for (var j:int = 0 ; j < mapH; j++) {
					var _tile:Tile = new Tile();
					_tile.x = j * tileW;
					_tile.y = i * tileH;
					_tile.value = $data[i][j];
					mapData[i].push(_tile);
					mapLayer.addChild(_tile);
				}
			}
		}
		public function buildMap($data:Array):void {
			clearMap();
			drawMap($data);
		}
		public function createRole($role:AbstractRole):void {
			mapLayer.addChild($role);
			$role.x = $role.xtile * tileW + tileW/2;
			if(!$role.getIsJump()) $role.y = $role.ytile * tileH + tileH/2;
			else $role.y = (($role.ytile + 1) * tileH) - $role.height / 2;
			$role.fall();
		}
		
	}

}
class Signle { }
