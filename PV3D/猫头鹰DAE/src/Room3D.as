package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.utils.Timer;
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.core.geom.Particles;
	import org.papervision3d.core.geom.renderables.Particle;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.events.InteractiveScene3DEvent;
	import org.papervision3d.materials.BitmapFileMaterial;
	import org.papervision3d.materials.special.ParticleMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.objects.primitives.Plane;
	import org.papervision3d.view.BasicView;
	import org.papervision3d.view.layer.util.ViewportLayerSortMode;
	import org.papervision3d.view.layer.ViewportLayer;
	import org.papervision3d.view.stats.StatsView;
	import org.papervision3d.view.Viewport3D;

	import util.MouseCameraControl;

	import util.daeData;

	import util.MouseDisplayObjectControl;
	
	/**
	 * ...
	 * @author Anlei
	 */
	public class Room3D extends BasicView
	{
		//private var Way:Object = {curr:'', front:'FRONT', back:'BACK', left:'LEFT', right:'RIGHT' };
		private var WayNum:int = 0;
		private var _timer:Timer = new Timer(2000, 1);
		private var Speed:Number = 4;
		
		private var TreeMater:MaterialsList;
		private var Root3D:DisplayObject3D;
		private var RootView:Viewport3D;
		private var bot_layer:ViewportLayer;
		private var yz_layer:ViewportLayer;
		private var chat_layer:ViewportLayer;
		private var cube:DAE;
		private var Tree:DAE;
		private var olm_obj3d:DisplayObject3D;
		private var plane:Plane;
		private var yz_plane:Plane;
		
		private var tree_layer:ViewportLayer;
		
		public function Room3D() 
		{
			super(800, 600, true, true);
			if (stage) initSet();
			else addEventListener(Event.ADDED_TO_STAGE, initSet);
		}
		
		private function initSet(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, initSet);
			
			camera.zoom = 1;
			camera.focus = 1000;
			//camera.z = 0;
			//camera.rotationX = 50;
			//stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			//stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			//stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

			
			viewport.containerSprite.sortMode = ViewportLayerSortMode.Z_SORT;
			Root3D = new DisplayObject3D();
			olm_obj3d = new DisplayObject3D();
			plane = new Plane(getBitFile('assets/img/map01.jpg', true), 1000, 1000, 15, 15);
			yz_plane = new Plane(getBitFile('assets/img/yz.png', true), 101, 101, 2, 2);
			cube = new DAE();
			
			TreeMater = new MaterialsList( { skin1:getBitFile('assets/img/MurlocHut1.jpg', true, false), skin2:getBitFile('assets/img/MurlocHut2.jpg', true, false) } );
			
			Tree = new DAE();
			Tree.load(daeData.TaurenTent, TreeMater );
			Tree.rotationZ = -90;
			Tree.rotationX = -90;
			Tree.addEventListener(FileLoadEvent.LOAD_COMPLETE, onTree);
			
			tree_layer = viewport.getChildLayer(Tree);
			
			RootView = new Viewport3D();
			var _mdoc:MouseDisplayObjectControl = new MouseDisplayObjectControl(Root3D, camera, this, false);
			_mdoc.SetX = false;
			_mdoc.SetY = false;
			_mdoc.SetCamera = true;
			//var _mcc:MouseCameraControl = new MouseCameraControl(camera, this);
			
			var _pcls:Particle = new Particle(new ParticleMaterial(0xFF0000, 1));
			var _par:Particles = new Particles();
			_par.x = 500;
			_par.y = 500;
			_par.z = 20;
			_par.addParticle(_pcls);
			Root3D.addChild(_par);
			
			
			cube.addEventListener(FileLoadEvent.LOAD_COMPLETE, myOnLoadCompleteHandler);
			
			olm_obj3d.rotationZ = -90;
			olm_obj3d.rotationX = -90;
			olm_obj3d.z = -12;
			olm_obj3d.addChild(cube);
			//loadOLMDae(daeData.OLM_1);
			
			yz_plane.z = -16;
			
			scene.addChild(Root3D);
			Root3D.addChild(plane);
			//Root3D.addChild(yz_plane);
			//Root3D.addChild(olm_obj3d);
			
			Root3D.createViewportLayer(RootView);
			//chat_layer = RootView.getChildLayer(olm_obj3d);
			//yz_layer = RootView.getChildLayer(yz_plane);
			bot_layer = RootView.getChildLayer(plane);
			
			//resetTimer();
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			
			var stats:StatsView = new StatsView(renderer);
			addChild(stats);

			camera.useCulling = true;

			startRendering();
		}
		
		private function onClick(e:InteractiveScene3DEvent):void 
		{
		}
		
		private function treeclick(e:InteractiveScene3DEvent):void 
		{
			trace(e.target);
		}
		
		private function treeOver(e:InteractiveScene3DEvent):void 
		{
			tree_layer.alpha = .5;
		}
		
		private function treeOut(e:InteractiveScene3DEvent):void 
		{
			tree_layer.alpha = 1;
		}
		
		private function onTree(e:FileLoadEvent):void 
		{
			
			for each(var mychild:* in Tree.getChildByName("COLLADA_Scene").children) {
				mychild.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, treeclick);
				mychild.addEventListener(InteractiveScene3DEvent.OBJECT_OVER, treeOver);
				mychild.addEventListener(InteractiveScene3DEvent.OBJECT_OUT, treeOut);
			}
			
			tree_layer.filters = [new BlurFilter()];
			
			Root3D.addChild(Tree);
		
			return;
			var _dae1:DAE = DAE(Tree.clone());
			var _dae2:DAE = DAE(Tree.clone());
			var _dae3:DAE = DAE(Tree.clone());
			var _dae4:DAE = DAE(Tree.clone());
			var _dae5:DAE = DAE(Tree.clone());
			var _dae6:DAE = DAE(Tree.clone());
			var _dae7:DAE = DAE(Tree.clone());
			_dae1.x = -400;
			_dae2.y = -400;
			_dae3.x = _dae3.y = 400;
			_dae4.x = _dae4.y = -600;
			_dae5.x = 400;
			_dae5.y = -200;
			_dae6.x = 200;
			_dae6.y = 100;
			_dae7.x = 100;
			_dae7.y = 300;
			_dae1.scale = .5;
			_dae2.scale = .4;
			_dae3.scale = .3;
			_dae4.scale = .2;
			_dae5.scale = .3;
			_dae6.scale = .6;
			Root3D.addChild(Tree);
			Root3D.addChild(_dae1);
			Root3D.addChild(_dae2);
			Root3D.addChild(_dae3);
			Root3D.addChild(_dae4);
			Root3D.addChild(_dae5);
			Root3D.addChild(_dae6);
			Root3D.addChild(_dae7);
			//TreeMater.getMaterialByName('skin').interactive = true;
			//var _do3d:DisplayObject3D = Tree.getChildByName('COLLADA_Scene').getChildByName('ElvenVillageBuilding21');
			//var _do3d2:DisplayObject3D = _do3d.getChildByName('8_0');
			//_do3d2.x -= 100;
			//trace('Anlei:', Tree.children);
			//_do3d.addEventListener(InteractiveScene3DEvent.OBJECT_CLICK, onClick);
			Root3D.addChild(Tree);
			
		}
		
		private function loadOLMDae(_xml:XML):void {
			//cube.COLLADA = _xml;
			//cube.load(_xml);// , new MaterialsList( { Skin_01:getBitFile('assets/img/skin.jpg', true) } ) );
		}
		private function getBitFile(_url:String, _onf:Boolean = false, _smooth:Boolean = false):BitmapFileMaterial {
			var _bmp:BitmapFileMaterial = new BitmapFileMaterial(_url);
			_bmp.tiled = true;
			//_bmp.doubleSided = _onf;
			//_bmp.smooth = _smooth;
			//_bmp.fillAlpha = .5;
			_bmp.interactive = true;
			return _bmp;
		}
		
		private function myOnLoadCompleteHandler(e:FileLoadEvent):void 
		{
			if (WayNum == 4) {
				cube.play('Skin_01',false);
			}else if(WayNum == 0 || WayNum == 1 || WayNum == 2 || WayNum == 3) {
				cube.play('Skin_01', true);
			}
		}
		
		private function onTimer(e:TimerEvent):void 
		{
			resetTimer();
		}
		
		private function resetTimer(_ut:int = -1):void
		{
			_timer.stop();
			_timer.reset();
			_timer.start();
			if (_ut != -1) {
				WayNum = _ut;
			}else{
				WayNum = int(Math.random() * 5);
			}
			
			if (WayNum == 4) {
				loadOLMDae(daeData.OLM_1);
			}else if(WayNum == 0 || WayNum == 1 || WayNum == 2 || WayNum == 3) {
				loadOLMDae(daeData.OLM_2);
			}
		}
		override protected function onRenderTick(e:Event = null):void 
		{
			if(WayNum != 4){
				if (WayNum == 0) {
					olm_obj3d.x += Speed;
					olm_obj3d.rotationZ = 0;
				}else 
				if (WayNum == 1) {
					olm_obj3d.x -= Speed;
					olm_obj3d.rotationZ = -180;
				}else 
				if (WayNum == 2) {
					olm_obj3d.y -= Speed;
					olm_obj3d.rotationZ = -90;
				}else 
				if (WayNum == 3) {
					olm_obj3d.y += Speed;
					olm_obj3d.rotationZ = 90;
				}
				yz_plane.x = olm_obj3d.x;
				yz_plane.y = olm_obj3d.y;
				//
				if (olm_obj3d.y < -500) {
					resetTimer(3);
				}
				if (olm_obj3d.y > 500) {
					resetTimer(2);
				}
				if(olm_obj3d.x < -500){
					resetTimer(0);
				}
				if (olm_obj3d.x > 500) {
					resetTimer(1);
				}
			}else {
				
			}
			if(e != null){
				//camera.lookAt(olm_obj3d);
				//yz_plane.rotationZ = camera.extra.goPosition.z;
				super.onRenderTick(e);
			}
		}
		
		//////////////
		private var cameraPitch:Number = 90;
		private var cameraYaw:Number = 270;
		private var isOrbiting:Boolean = false;
		private var previousMouseX:Number;
		private var previousMouseY:Number;

		private function onMouseDown(event:MouseEvent):void
		{
			isOrbiting = true;
			previousMouseX = event.stageX;
			previousMouseY = event.stageY;
		}
 
		private function onMouseUp(event:MouseEvent):void
		{
			isOrbiting = false;
		}
 
		private function onMouseMove(event:MouseEvent):void
		{
			var differenceX:Number = event.stageX - previousMouseX;
			var differenceY:Number = event.stageY - previousMouseY;
 
			if(isOrbiting)
			{
				cameraPitch += differenceY;
				cameraYaw += differenceX;
 
				cameraPitch %= 360;
				cameraYaw %= 360;
 
				cameraPitch = cameraPitch > 0 ? cameraPitch : 0.0001;
				cameraPitch = cameraPitch < 90 ? cameraPitch : 89.9999;
 
				previousMouseX = event.stageX;
				previousMouseY = event.stageY;
 
				camera.orbit(cameraPitch, cameraYaw);
			}
		}

		
	}

}