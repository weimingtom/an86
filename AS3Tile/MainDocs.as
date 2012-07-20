package 
{
	import flash.display.Sprite;
	import tilegame.role.Char;
	import tilegame.TileWorld;
	import tilegame.utils.MapData;
	
	/**
	 * ...
	 * @author Anlei
	 */
	public class MainDocs extends Sprite 
	{
		
		public function MainDocs() 
		{
			EnterFrame.StartEnterFrame(stage);
			
			addChild(TileWorld.getInstance());
			
			TileWorld.getInstance().buildMap(MapData.map1);
			
			
			
			var char:Char = new Char();
			char.xtile = 1;
			char.ytile = 2;
			
			TileWorld.getInstance().createRole(char);
		}
		
	}

}