package anlei.away
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	import away3d.containers.ObjectContainer3D;
	import away3d.containers.View3D;
	import away3d.debug.AwayStats;

	public class Anlei3D
	{
		private static var _instance:Anlei3D;
		public function Anlei3D(signle:Signle) { }
		public static function ins():Anlei3D {
			if (_instance == null) _instance = new Anlei3D(new Signle());
			return _instance;
		}
		///////////////
		
		private var layer:Sprite;
		public var view3d:View3D;
		private var update:Function;
		
		public function inits($layer:Sprite, $update:Function = null, $isStats:Boolean = false):void {
			layer = $layer;
			update = $update;
			
			view3d = new View3D();
			layer.addChild(view3d);
			
			view3d.camera.x = 100;
			view3d.camera.y = 100;
			view3d.camera.z = 100;
			view3d.camera.lookAt(new Vector3D());
			
			if($isStats) layer.addChild(new AwayStats(view3d));
			layer.addEventListener(Event.ENTER_FRAME, _onEnterFrame);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize();
		}
		
		private function _onEnterFrame(e:Event):void {
			if(update) update();
			view3d.render();
		}
		
		private function onResize(event:Event = null):void {
			view3d.width = stage.stageWidth;
			view3d.height = stage.stageHeight;
		}
		
		public function get stage():Stage{
			return layer.stage;
		}
		
		public function add(child:ObjectContainer3D):ObjectContainer3D{
			return view3d.scene.addChild(child);
		}
	}
}
class Signle{}