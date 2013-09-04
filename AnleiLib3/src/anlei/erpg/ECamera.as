package anlei.erpg
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import anlei.erpg.iface.IDOD;
	import anlei.erpg.utils.SceneLayerEnter;
	import anlei.util.EnterFrame;
	import anlei.util.ResizeManager;
	
	import ui.component.MyTimer;

	/**摄像机*/
	public class ECamera
	{
		private var _game:EGame;
		private var _target:Sprite;
		/**每秒执行一次渲染，为其他玩家跑进自己的摄像机里所显示*/
		private var time:MyTimer;
		
		/**摄像机范围*/
		public var scrollRect:Rectangle;
		public var isLock:Boolean = false;
		
		public function ECamera()
		{
		}
		
		private function get stage():Stage{
			var _stage:Stage = Entrance.getInstance().Root.stage;
			return _stage;
		}
		
		/**引擎引用*/
		public function get game():EGame { return _game; }
		public function set game(value:EGame):void {
			_game = value;
			game.scene.camera = this;
			if(!stage) game.scene.addEventListener(Event.ADDED_TO_STAGE, onStage);
			else onStage();
		}
		
		/**当场景在舞台上时*/		
		private function onStage(event:Event = null):void {
			game.scene.removeEventListener(Event.ADDED_TO_STAGE, onStage);
			
			createScrollRect();
			ResizeManager.getInstance().delResize(onResize);
			ResizeManager.getInstance().addResize(onResize);
			SceneLayerEnter.actionLayer = game.scene.member_layer;
			if(EnterFrame.hasFunction(SceneLayerEnter.onEnter) == null)
				EnterFrame.enterFrame = SceneLayerEnter.onEnter;
			
			time = new MyTimer(1000);
			time.addEventListener(MyTimer.TIMER, onTimer);
			time.start();
		}
		
		private function onTimer(event:Event):void { display(); }
		
		/**摄像机的跟踪对象*/
		public function get target():Sprite{ return _target; }
		public function set target($target:Sprite):void{
			_target = $target;
			if(target) move(target);
		}
		
		/**移动摄像机*/
		public function move($target:Sprite):void{
			if($target != null){
				var _x:Number = -($target.x-scrollRect.width /2)+scrollRect.x;
				var _y:Number = -($target.y-scrollRect.height/2)+scrollRect.y;
				var _w:Number = -(game.scene.W-stage.stageWidth);
				var _h:Number = -(game.scene.H-stage.stageHeight);
				if(_x < _w) _x = _w;
				if(_y < _h) _y = _h;
				if(_x > 0) _x = 0;
				if(_y > 0) _y = 0;
				if(//当场景坐标为负,并且在
						_x <= 0
					&&	_x >= _w
				){
					var _off:Number = game.scene.x - _x;
					game.scene.x = _x;
					if(game.scene.bg1)
						game.scene.bg1.x += _off/4;// ERole($target).roleCtrl.direction * 1;
					if(game.scene.bg2)
						game.scene.bg2.x += _off/6;//ERole($target).roleCtrl.direction * 2;
				}
				if(		_y <= 0
					&& 	_y >= _h
				){
					game.scene.y = _y;
				}
				
				if(_x == _w){
					if(game.scene.toWidthCallBack) game.scene.toWidthCallBack();
				}else{
					if(game.scene.toWidthCallBack) game.scene.noToWidthCallBack();
				}
				
				//trace(target.x, target.y);
				
				if(!isLock) display();
			}
		}
		
		/**在摄像机内的对像全部显示，在外部则全部移除*/
		private function display():void{
			var add_arr:Array = [];
			var remove_arr:Array = [];
			var _nmc:IDOD;
			var nx:Number;
			var ny:Number;
			
			var ement_arr:Array = game.scene.tiles_arr.concat(game.scene.member_arr);
			
			var len:int = ement_arr.length;
			for(var i:int = 0 ; i < len; i++){
				_nmc = ement_arr[i] as IDOD;
				nx = _nmc.x + game.scene.x;
				ny = _nmc.y + game.scene.y;
				if(		nx > scrollRect.x + scrollRect.width
					||	ny > scrollRect.y + scrollRect.height
					||	nx < scrollRect.x - _nmc.W
					||	ny < scrollRect.y - _nmc.H
				){
					remove_arr.push(_nmc);
				}else{
					add_arr.push(_nmc);
				}
			}
			
			len = add_arr.length;
			ETile.TOTAL_NUM = len;
			for (var j:int = 0; j < len; j++) {
				if(!add_arr[j].parentLayer.contains(add_arr[j])){
					add_arr[j].parentLayer.addChild(add_arr[j]);
				}
				var _tile:ETile = add_arr[j] as ETile;
				if(_tile){
					if(!_tile.isLoad) ETile.CURR_NUM++;
					_tile.reload();
				}
			}
			
			len = remove_arr.length;
			for (var k:int = 0; k < len; k++) {
				if(remove_arr[k].parentLayer.contains(remove_arr[k]))
					remove_arr[k].parentLayer.removeChild(remove_arr[k]);
			}
			
		}
		
		//////////////////
		private function setSceneLayerCoor(isY:Boolean):void {
			//var _p:Rectangle = game.layer.parent.getBounds(game.layer);
			var _p:Rectangle = Entrance.getInstance().Root.getBounds(game.layer);
			var _pw:Number = game.scene.tiles_layer.width;//_p.width;
			var _ph:Number = game.scene.tiles_layer.height;//_p.height;
			//if(_pw > stage.stageWidth){
				var _wx:int = _p.width + Math.abs(_p.x);
				game.layer.x = (stage.stageWidth + _pw) /2 - (_pw -Math.abs(_p.x));
			//}else{
				//game.layer.x = 0;
			//}
			//if(_ph > stage.stageHeight){
				//if(isY){
				var _wy:int = _p.height+ Math.abs(_p.y);
				game.layer.y = (stage.stageHeight+ _ph)/2 - (_ph-Math.abs(_p.y));
				//}
			//}else{
				//game.layer.y = 0;
			//}
		}
		private function createScrollRect():void{
			var _x:Number = 0;//200;
			var _y:Number = 0;//200;
			if(!scrollRect) scrollRect = new Rectangle();
			scrollRect.x = _x;
			scrollRect.y = _y;
			scrollRect.width = stage.stageWidth -_x*2;
			scrollRect.height= stage.stageHeight-_y*2;
		}
		
		private function onResize(event:Event = null):void {
			createScrollRect();
			display();
			if(stage.stageWidth > game.scene.W){
				setSceneLayerCoor(false);
			}else if(stage.stageHeight> game.scene.H ){
				setSceneLayerCoor(true);
			}else{
				if(stage.stageWidth <= game.scene.W){
					game.layer.x = 0;
				}
				if(stage.stageHeight<= game.scene.H){
					game.layer.y = 0;
				}
			}
			target = target;
		}
		/*
		public function dispose():void{
			
		}
		*/
	}
}