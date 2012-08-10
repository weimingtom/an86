package
{
	import alternativa.engine3d.controllers.SimpleObjectController;
	import alternativa.engine3d.core.Camera3D;
	import alternativa.engine3d.core.Object3D;
	import alternativa.engine3d.core.View;
	
	import flash.display.Stage;
	import flash.display.Stage3D;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	
	public class A3DLib
	{
		/**---------------------------------- Start 单例 -------------------------------------------*/
		private static var _instance:A3DLib;
		public function A3DLib(signle:Signle)
		{
			if(signle == null) throw new Error("A3DLib类为单例，不能用new");
		}
		public static function getInstance():A3DLib{
			if(_instance == null) _instance = new A3DLib(new Signle());
			return _instance;
		}
		/**----------------------------------  End 单例  -------------------------------------------*/
		
		public var stage3D:Stage3D;
		
		public var scene:Object3D = new Object3D();
		public var camera:Camera3D;
		public var controller:SimpleObjectController;
		
		private var stage:Stage;
		private var onComplete:Function;
		private var onUpdate:Function;
		
		public function inits($stage:Stage, $onComplete:Function, $onUpdate:Function):void{
			stage = $stage;
			onComplete = $onComplete;
			onUpdate = $onUpdate;
			
			stage3D = stage.stage3Ds[0];
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, onInit);
			stage3D.requestContext3D(Context3DRenderMode.SOFTWARE);
		}
		
		private function onInit(e:Event):void {
			camera = new Camera3D(10, 10000);
			camera.view = new View(stage.stageWidth, stage.stageHeight);
			camera.view.antiAlias = 4;
			stage.addChild(camera.view);
			stage.addChild(camera.diagram);
			
			camera.rotationX = -120*Math.PI/180;
			camera.y = -500;
			camera.z = 250;
			controller = new SimpleObjectController(stage, camera, 500, 2);
			scene.addChild(camera);
			onComplete();
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(e:Event):void {
			onUpdate();
			controller.update();
			camera.render(stage3D);
		}
	}
}
class Signle{}