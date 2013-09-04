package anlei.erpg.role
{
	import com.D5Power.mission.MissionData;
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import anlei.debug.ApplicationStats;
	import anlei.erpg.EGame;
	import anlei.erpg.EScene;
	import anlei.erpg.utils.Actions;
	import anlei.util.CoorAway;
	import anlei.util.EnterFrame;
	
	public class ERoleCtrl
	{
		/**左方向*/
		public static const LEFT:int  = -1;
		/**右方向*/
		public static const RIGHT:int = 1;
		
		/**走到一个NPC或路点时的偏移X*/
		private static const OFFX:Number = 20;
		/**走到一个NPC或路点时的偏移Y*/
		private static const OFFY:Number = 30;
		
		/**普通行走速度*/
		public var PT_Speed:Number = 10;
		/**有坐骑速度*/
		public var MO_Speed:Number = 12;
		
		/**目标点*/
//		public var point:Point;
		private var pointArr:Array = [];
		private var role:ERole;
		/**场景*/
		private var scene:EScene;
		private var delayTween:TweenLite;
		/**当前所指引的角色(如:要跑到角色或路点的跟前)*/
		private var selectedRole:ERole;
		
		//public var speed:Number = 12;
		
		/**可点击地板显示的路标方法*/
		public var onClickedFunction:Function;
		/**不可点击地板显示的路标方法*/
		public var onClickErrorFunction:Function;
		/**跑到终点时*/
		public var onEndPointFunction:Function;
		/**点击时所执行的方法*/
		public var onClicker:Function;
		/**每走一步都会实时调用的方法*/
		public var onRoleStepExec:Function;
		/**开始自动寻路*/
		public var onAutoRunFunction:Function;
		/**停止自动寻路*/
		public var onStopAutoRunFunction:Function;
		private var _speed:Number;
		
		public var oldDirection:int = -1;
		
		/**是否旋转角度*/
		public var isRotation:Boolean = false;
		/**非均速行走*/
//		public var isTweenLite:Boolean = false;
//		private var runTween:TweenLite;
		/**通常点击其他玩家，则不跑到其他玩家身边*/
		public var isWalk:Boolean = false;
		public var curePt:Point = new Point();
		
		public function ERoleCtrl($role:ERole) {
			role = $role;
		}
		
		/**添加鼠标侦听*/
		public function addListener($scene:EScene):void{
			unLinstener();
			scene = $scene;
			role.mouseChildren = role.mouseEnabled = false;
			scene.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			scene.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			scene.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		/**移除鼠标侦听*/
		public function unLinstener():void{
			if(scene){
				scene.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				if(scene.stage) scene.stage.removeEventListener(MouseEvent.MOUSE_UP, onMousUp);
				scene.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				scene.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			}
		}
		
		/**要跑到角色或路点的跟前
		 * @param nid	角色或路点的ID
		 */
		public function setTarget(nid:int):ERole{
			if(!scene) return null;
			//查找成员
			for (var i:int = 0; i < scene.member_arr.length; i++) {
				var _sr:ERole = scene.member_arr[i] as ERole;
				if(_sr.uid == nid){
					selectedRole = _sr;
					break;
				}
			}
			//有该成员则执行跑动
			if(selectedRole){
				var _mx:Number = selectedRole.x + OFFX;
				var _my:Number = selectedRole.y + OFFY;
				if(onAutoRunFunction!=null) onAutoRunFunction();
				setPath(_mx, _my);
				if(onClickedFunction!=null) onClickedFunction(_mx, _my);
			}
			
			return selectedRole;
		}
		
		public function clearPath(noaction:Boolean = true):void{
//			if(delayTween) delayTween.kill();
//			if(point == null) point = new Point();
//			point.x = role.x;
//			point.y = role.y;
			EnterFrame.removeEnterFrame = onEnter;
			if(noaction) role.action = Actions.Stop;
			if(onEndPointFunction) onEndPointFunction();
			if(onStopAutoRunFunction!=null) onStopAutoRunFunction();
			onMousUp(null);
			selectedRole = null;
		}
		
		private function autoSetDirection():void{
			if(curePt.x > role.x){
				direction = RIGHT;
			}else{
				direction = LEFT;
			}
		}
		
		/**执行跑动到目标
		 * @param $x	目标X坐标
		 * @param $y	目标Y坐标
		 */
		public function setPath($x:Number, $y:Number):void{
//			if(point == null) point = new Point();
//			if(point.x == $x && point.y == $y) return;
//			point.x = $x;
//			point.y = $y;
			
			curePt.x = $x;
			curePt.y = $y;
			
			autoSetDirection();
			
//			if(isTweenLite){
//				setRunTweenNull();
//				runTween = TweenLite.to(role, 1, {x:$x, y:$y, onUpdate:onEnter, ease:Cubic.easeOut});
//			}else{
				if(EnterFrame.hasFunction(onEnter))
					EnterFrame.removeEnterFrame = onEnter;
				
				if(direction != oldDirection){
					role._action = 0;
				}
				
				if(role.mounts > 0){
					if(role.action != Actions.ZJ_Run){
						role.action = Actions.ZJ_Run;
					}
				}else{
					if(role.action != Actions.Run){
						role.action = Actions.Run;
					}
				}
				
				EnterFrame.enterFrame = onEnter;
//			}
		}
		
		/**设置方向(ERoleCtrl.LEFT)*/
		public function get direction():int{ return role.render.scaleX; }
		/**设置方向(ERoleCtrl.LEFT)*/
		public function set direction(value:int):void{
			//if(role.render.scaleX == value){
			oldDirection = role.render.scaleX;
			role.render.scaleX = value;
			//}
		}
		
		public function get speed():Number {
			//_speed = role.mounts > 0 ? MO_Speed : PT_Speed;
			if(role.isBattleRole)
				return _speed;
			else 
				return role.mounts > 0 ? MO_Speed : PT_Speed;
			return _speed;
		}
		public function set speed(value:Number):void{
			_speed = value;
		}
		
		
		/*private function setRunTweenNull():void{
			if(runTween){
				runTween.kill();
				runTween = null;
			}
		}*/
		/////////////////////////
		/////////////////////////
		/////////////////////////
		private function onEnter():void {
			if(pointArr.length > 0){
				curePt.x = pointArr[0].x;
				curePt.y = pointArr[0].y;
				autoSetDirection();
			}
			var onf:Boolean = CoorAway.moveCoor(speed, curePt, role);
			/*if(point.x > role.x){
				direction = RIGHT;
			}else{
				direction = LEFT;
			}*/
			
			if(isRotation) role.rotation = CoorAway.getRotation(curePt, role.getPos());
			
			if(role.action == Actions.Stop){
				role.action = Actions.Run;
			}
			
			if(!role.isNPC) EGame.camera.move(role);
			if(onRoleStepExec != null) onRoleStepExec();
			if(!onf){
				if(pointArr.length > 0){
					pointArr.shift();
					autoSetDirection();
					return;
				}
				EnterFrame.removeEnterFrame = onEnter;
//				if(!isTweenLite){
//					role.x = point.x;
//					role.y = point.y;
//				}else{
//					setRunTweenNull();
//				}
				if(isRotation) role.rotation = 0;
				
				if(role.isBattleRole)
					role.action=Actions.BattleStop;
				else
					role.action = Actions.Stop;
				
				setRemote();
				if(onEndPointFunction) onEndPointFunction();
				if(onStopAutoRunFunction!=null) onStopAutoRunFunction();
				selectedRole = null;
			}
			//scene.stage.invalidate();
		}
		
		private function setRemote():void{
			if(selectedRole){
				if(selectedRole.missionConfig){
					var list:Vector.<MissionData> = selectedRole.missionConfig.getList(EGame.userdata);
					EGame.camera.game.scene.missionCallBack(selectedRole.getNameText().text, selectedRole.missionConfig.say, selectedRole.missionConfig.event, list, selectedRole);
				}else{
					EGame.camera.game.scene.notMissionCallBack(selectedRole);
				}
			}
		}
		
		private function onMouseOver(event:MouseEvent):void {
			var tar:ERole = event.target as ERole;
			//if(tar) PublicProperty.mouseEffect(tar, null, 0xFFCC00);
			if(tar) tar.transform.colorTransform = new ColorTransform(1,1,1,1,40,40,40,0);
		}
		
		private function onMouseOut(event:MouseEvent):void {
			var tar:ERole = event.target as ERole;
			//if(tar) PublicProperty.removeMouseEffect(tar);
			if(tar) tar.transform.colorTransform = new ColorTransform();
		}
		///鼠标按下时
		private function onMouseDown(event:MouseEvent = null):void {
			scene.stage.addEventListener(MouseEvent.MOUSE_UP, onMousUp);
			selectedRole = null;
			var _mx:Number = EGame.camera.game.scene.tiles_layer.mouseX;
			var _my:Number = EGame.camera.game.scene.tiles_layer.mouseY;
			
			if(event){//如果点到NPC或路点
				selectedRole = event.target as ERole;
				if(selectedRole){
					if(selectedRole.remote){
						setRemote();
						return;
					}
					_mx = selectedRole.x + OFFX;
					_my = selectedRole.y + OFFY;
					//////////////////////////////
					//////////////////////////////
					var _dict:Dictionary = selectedRole.action_dict;
					var _str:String = '';
					var _isStage:Boolean = false;
					for(var _mc:Object in _dict){
						if(_dict[_mc] && _dict[_mc].stage) _isStage = true;
						_str += "\nmc:" + _mc + ",stage:"+_isStage;
					}
					_str = "TRole Action: action:" + selectedRole.action + _str;
					trace(_str);
					ApplicationStats.getInstance().push(_str);
					//////////////////////////////
					//////////////////////////////
					
				}
			}
			
			var _isWalk:Boolean = false;
			var _bd:BitmapData = Bitmap(scene.aroad.content).bitmapData;
			var _wb:Number = scene.W/_bd.width;
			var _hb:Number = scene.H/_bd.height;
			var _col:uint =_bd.getPixel(_mx/_wb, _my/_hb);
			
			if(scene.nav && _col > 0){
				_isWalk = true;
				var _mhb:Number = 1;
				pointArr = scene.nav.findPath(role.x/_mhb, role.y/_mhb, _mx/_mhb, _my/_mhb);
				if(pointArr == null) pointArr = [];
				if(pointArr.length > 0){
					_mx = pointArr[0].x;
					_my = pointArr[0].y;
					setPath(_mx, _my);
				}
			}
			
			
			if(_col <= 0){
				_isWalk = true;
				if(selectedRole){
					setPath(_mx, _my);
					if(onClickedFunction!=null) onClickedFunction(_mx, _my);
				}else{
					if(onClickErrorFunction!=null) onClickErrorFunction(_mx, _my);
				}
			}
			if(!_isWalk){
				if(onClicker != null) onClicker(selectedRole);
				///有数据则表示是其他玩家，则不跑过去
				if(!isWalk && selectedRole && selectedRole.info) return;
				if(onClickedFunction!=null) onClickedFunction(_mx, _my);
				setPath(_mx, _my);
				if(!selectedRole || (selectedRole && selectedRole.x != _mx - OFFX && selectedRole.y != _my - OFFY))
					delayExec();
			}
		}
		///松开鼠标释放延时
		private function onMousUp(e:MouseEvent):void{
			if(delayTween) delayTween.kill();
			if(scene && scene.stage) scene.stage.removeEventListener(MouseEvent.MOUSE_UP, onMousUp);
		}
		///开始延时
		private function delayExec():void{
			if(delayTween) delayTween.kill();
			delayTween = TweenLite.delayedCall(0.5, onDelayMouseDown);
		}
		///延时结束
		private function onDelayMouseDown():void{
			///重新获得当前鼠标的点
			onMouseDown();
			delayTween.kill();
			delayExec();
		}
		
		public function dispose():void{
			if(delayTween) delayTween.kill();
			unLinstener();
//			point = null;
			role = null;
			scene = null;
			delayTween = null;
			selectedRole = null;
			onClicker = null;
			onEndPointFunction = null;
			onClickedFunction = null;
			onClickErrorFunction = null;
			onRoleStepExec = null;
			onAutoRunFunction=null;
			onStopAutoRunFunction=null;
			EnterFrame.removeEnterFrame = onEnter;
		}
		
	}
}