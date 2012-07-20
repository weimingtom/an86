package 
{
	import com.adobe.serialization.json.JSON;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Anlei
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			//addChild(new FB_documentClass());
			var _str:String = '{"cardid":"-1","content":"Don`t be alarm, its classic /"kissing someone`s a$$/". This is to save his own skin, all the talk about respect and stuff is fake sh!t."}';
			_str = _str.split('/"').join("``");
			trace(_str);
			
		}
		
	}
	
}