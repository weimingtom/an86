package tilegame.role
{
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author Anlei
	 */
	public class Char extends AbstractRole 
	{
		public function Char() 
		{
			if (stage) inits();
			else addEventListener(Event.ADDED_TO_STAGE, inits);
		}
		
		private function inits(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, inits);
			
			//addChild(new roleSkin_mc());
			
			setKeyCtrl(true);
			setIsJump(true);
		}
		
	}

}