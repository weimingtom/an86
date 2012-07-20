package 
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author Anlei (http://www.an86.net)
	 */
	public class Main extends Sprite 
	{
		private var _loader:Loader;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			_loader = new Loader();
			_loader.load(new URLRequest('assets/man.swf'));
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCom);
			
		}
		
		private function onCom(e:Event):void 
		{
			var ClassReference:Class = _loader.contentLoaderInfo.applicationDomain.getDefinition('man') as Class;
			var mc:MovieClip = new ClassReference as MovieClip;
			astartest.rote_mc = mc;
			addChild(new astartest());
		}
		
	}
	
}