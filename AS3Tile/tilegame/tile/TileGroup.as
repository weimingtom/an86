package tilegame.tile 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Anlei
	 */
	public class TileGroup 
	{
		public var DOOR:Boolean = false;
		public var WALKABLE:Boolean;
		public var CLIP:Sprite;
		
		public function TileGroup($walk:Boolean, $clip:Sprite, $door:Boolean = false) {
			WALKABLE = $walk;
			CLIP = $clip;
			DOOR = $door;
		}
		
	}

}