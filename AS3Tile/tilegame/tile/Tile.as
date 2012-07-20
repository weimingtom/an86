package tilegame.tile
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Anlei
	 */
	public class Tile extends Sprite
	{
		private var _walkable:Boolean = true;
		
		private var _value:int;
		
		//private var _id:int;
		
		private var _door:Boolean = false;
		
		public function Tile() 
		{
			inits();
		}
		
		private function inits():void 
		{
			this.mouseChildren = false;
		}
		
		public function get walkable():Boolean 
		{
			return _walkable;
		}
		
		public function get value():int {
			return _value;
		}
		
		public function set value($value:int):void {
			_value = $value;
			var group:TileGroup = TileFactory.getInstance().getClipSource($value);
			if(group != null) addChild(group.CLIP);
			_walkable = group.WALKABLE;
			_door = group.DOOR;
		}
		
		public function get door():Boolean {
			return _door;
		}
		
		/*public function set id($value:int):void {
			_id = $value;
		}
		public function get id():int {
			return _id;
		}*/
	}

}