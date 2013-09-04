package net.an86.utils
{
	import flash.display.Sprite;
	
	public class ImportClass extends Sprite
	{
		//[Embed(source="/locked.png")]
		//public static const LockedClass:Class;
		
		public function ImportClass()
		{
			var _temp:Class = Sprite;
			var _sp:Sprite = new _temp();
			_sp.name = "Anlei";
			addChild(_sp);
			
		}
	}
}