package anlei.erpg.role
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import anlei.debug.ApplicationStats;
	import anlei.erpg.EGame;
	import anlei.erpg.utils.Actions;
	import anlei.erpg.utils.AssetsPool;
	import anlei.erpg.utils.ColorTransformUtils;
	import anlei.util.AnleiFilter;
	
	import br.com.stimuli.loading.loadingtypes.LoadingItem;

	/**坐骑*/
	public class EMount
	{
		/**动作资源路径*/
		private var resourceURL:String = EGame.HTTP + "asset/role/zj/";
		/**容器*/
		private var containe:Sprite;
		/**坐骑ID*/
		private var mountId:int=0;
		private var action:int;
		
		/**坐骑跑MC*/
		public var mounts_run_mc:MovieClip;
		/**坐骑跑时翅膀MC*/
		private var run_wing_mc:MovieClip;
		/**坐骑待机MC*/
		public var mounts_stand_mc:MovieClip;
		/**坐骑待机时翅膀MC*/
		private var stand_wing_mc:MovieClip;
		
		/**坐骑配置文档(在坐骑动作SWF文件里)-跑*/
		private var monster_run_xml:XML;
		/**坐骑配置文档(在坐骑动作SWF文件里)-待机*/
		private var monster_stand_xml:XML;
		private var onComplete:Function;
		private var _ctu:int;
		private var _isColor:int;
		
		private var tween:TweenLite;
		
		public function EMount($containe:Sprite) {
			containe = $containe;
		}
		/*
		public function get action():int { return _action; }
		public function set action(value:int):void{
			_action = value;
		}
		*/
		
		public function remove():void{
			_trace("移除Mount:" + mountId.toString(), null);
			if(mounts_run_mc && mounts_run_mc.parent) mounts_run_mc.parent.removeChild(mounts_run_mc);
			if(mounts_stand_mc && mounts_stand_mc.parent) mounts_stand_mc.parent.removeChild(mounts_stand_mc);
			if(run_wing_mc && run_wing_mc.parent)
				run_wing_mc.parent.removeChild(run_wing_mc);
			if(stand_wing_mc && stand_wing_mc.parent)
				stand_wing_mc.parent.removeChild(stand_wing_mc);
			//移除坐骑，顺便把女仆添加到场景
			if(isMaidZJ() && role && ERole(role).maid){
				EGame.camera.game.scene.member_layer.addChild(ERole(role).maid);
				ERole(role).maid.lord = ERole(role);
			}
		}
		
		public function addRunX():void{
			if(mounts_run_mc && !containe.contains(mounts_run_mc)){
				containe.addChildAt(mounts_run_mc, 0);
				if(run_wing_mc)
					containe.addChild(run_wing_mc);
			}
			if(mounts_stand_mc && containe.contains(mounts_stand_mc)){
				containe.removeChild(mounts_stand_mc);
				if(stand_wing_mc)
					containe.removeChild(stand_wing_mc);
			}
			setRunCoor();
		}
		private function setRunCoor():void{
			if(monster_run_xml)
				if(role){
					role.render.y = -(Number(monster_run_xml.@offy)/*+render.height/2*/);
				}
			if(mounts_run_mc){
				if(role) mounts_run_mc.scaleX = role.render.scaleX;
				var _s_w:Number = monster_run_xml.@width;
				var _s_x:Number = monster_run_xml.@offx;
				mounts_run_mc.x = -mounts_run_mc.scaleX*(_s_w/2 + _s_x);
			}
			if(run_wing_mc){
				run_wing_mc.scaleX = mounts_run_mc.scaleX;
				run_wing_mc.x = mounts_run_mc.x;
			}
		}
		
		public function get offsetY():Number
		{
			if(!monster_run_xml)
				return 0;
			return action==Actions.ZJ_Run ? Number(monster_run_xml.@offy) : Number(monster_stand_xml.@offy);
		}
		
		public function get offsetX():Number
		{
			if(!monster_run_xml)
				return 0;
			return action==Actions.ZJ_Run ? Number(monster_run_xml.@offx) : Number(monster_stand_xml.@offx);
		}
		
		public function get width():Number
		{
			if(!monster_run_xml)
				return 0;
			return action==Actions.ZJ_Run ? Number(monster_run_xml.@width) : Number(monster_stand_xml.@width);
		}
		
		public function get height():Number
		{
			if(!monster_run_xml)
				return 0;
			return action==Actions.ZJ_Run ? Number(monster_run_xml.@height) : Number(monster_stand_xml.@height);
		}
		
		public function addStandX():void{
			if(mounts_stand_mc && !containe.contains(mounts_stand_mc)){
				containe.addChildAt(mounts_stand_mc, 0);
				if(stand_wing_mc)
					containe.addChild(stand_wing_mc);
			}
			if(mounts_run_mc && containe.contains(mounts_run_mc)){
				containe.removeChild(mounts_run_mc);
				if(run_wing_mc)
					containe.removeChild(run_wing_mc);
			}
			setStandCoor();
		}
		
		/**女仆可否坐骑*/
		public function isMaidZJ():Boolean{
			if(monster_stand_xml && int(monster_stand_xml.@zj)==1) return true;
			return false;
		}
		
		private function setMaidCoor():void{
			if(role && ERole(role).maid && ERole(role).maid.skinId > 0 && isMaidZJ()){//女仆坐上去
				if(role.mounts > 0){
					ERole(role).maid.lord = null;
					ERole(role).maid.x = -20;
					ERole(role).maid.y = 0;
					role.render.addChild(ERole(role).maid);
					ERole(role).maid.action = role.action;
				}
			}
		}
		private function setStandCoor():void{
			if(monster_stand_xml)
				if(role){
					role.render.y = -(Number(monster_stand_xml.@offy)/*+render.height/2*/);
				}
			if(mounts_stand_mc){
				if(role) mounts_stand_mc.scaleX = role.render.scaleX;
				var _s_w:Number = monster_stand_xml.@width;
				var _s_x:Number = monster_stand_xml.@offx;
				mounts_stand_mc.x = -mounts_stand_mc.scaleX*(_s_w/2 + _s_x);
			}
			if(stand_wing_mc){
				stand_wing_mc.scaleX = mounts_stand_mc.scaleX;
				stand_wing_mc.x = mounts_stand_mc.x;
			}
		}
		
		public function readd():void{
			add(role.action, mountId, onComplete);
		}
		
		public function add($action:int, $mountId:int, $onComplete:Function = null):void{
			//disposeA();
			mountId = $mountId;
			action = $action;
			onComplete = $onComplete;
			var onf:Boolean = AssetsPool.getInstance().hasSource(getZJKEY());
			
			if(!onf){
				AssetsPool.getInstance().loadSource(getZJKEY(), getZJURL(), action+"_Quote", onLoaded);
				delay_hitest();
			}else{
				onLoaded();
			}
		}
		/**有色彩还是只有灰色*/
		public function get isColor():int{ return _isColor; }
		public function set isColor(value:int):void{
			_isColor = value;
			if(value){
				if(mounts_run_mc) AnleiFilter.setNotColor(mounts_run_mc);
				if(mounts_stand_mc) AnleiFilter.setNotColor(mounts_stand_mc);
				if(run_wing_mc) AnleiFilter.setNotColor(run_wing_mc);
				if(stand_wing_mc) AnleiFilter.setNotColor(stand_wing_mc);
			}else{
				if(mounts_run_mc) AnleiFilter.setRgbColor(mounts_run_mc);
				if(mounts_stand_mc) AnleiFilter.setRgbColor(mounts_stand_mc);
				if(run_wing_mc) AnleiFilter.setRgbColor(run_wing_mc);
				if(stand_wing_mc) AnleiFilter.setRgbColor(stand_wing_mc);
			}
		}
		
		/**坐骑色彩*/
		public function get ZJColor():int{ return _ctu; }
		public function set ZJColor($ctu:int):void{
			_ctu = $ctu;
			switch(_ctu){
				case ColorTransformUtils.Reply:
					if(mounts_stand_mc)
						ColorTransformUtils.setReply(mounts_stand_mc);
					if(mounts_run_mc)
						ColorTransformUtils.setReply(mounts_run_mc);
					
					if(stand_wing_mc)
						ColorTransformUtils.setReply(stand_wing_mc);
					if(run_wing_mc)
						ColorTransformUtils.setReply(run_wing_mc);
					break;
				case ColorTransformUtils.Red:
					if(mounts_stand_mc)
						ColorTransformUtils.setRed(mounts_stand_mc);
					if(mounts_run_mc)
						ColorTransformUtils.setRed(mounts_run_mc);
					
					if(stand_wing_mc)
						ColorTransformUtils.setRed(stand_wing_mc);
					if(run_wing_mc)
						ColorTransformUtils.setRed(run_wing_mc);
					break;
				case ColorTransformUtils.Purple:
					if(mounts_stand_mc)
						ColorTransformUtils.setPurple(mounts_stand_mc);
					if(mounts_run_mc)
						ColorTransformUtils.setPurple(mounts_run_mc);
					
					if(stand_wing_mc)
						ColorTransformUtils.setPurple(stand_wing_mc);
					if(run_wing_mc)
						ColorTransformUtils.setPurple(run_wing_mc);
					break;
				case ColorTransformUtils.Yellow:
					if(mounts_stand_mc)
						ColorTransformUtils.setYellow(mounts_stand_mc);
					if(mounts_run_mc)
						ColorTransformUtils.setYellow(mounts_run_mc);
					
					if(stand_wing_mc)
						ColorTransformUtils.setYellow(stand_wing_mc);
					if(run_wing_mc)
						ColorTransformUtils.setYellow(run_wing_mc);
					break;
				case ColorTransformUtils.Green:
					if(mounts_stand_mc)
						ColorTransformUtils.setGreen(mounts_stand_mc);
					if(mounts_run_mc)
						ColorTransformUtils.setGreen(mounts_run_mc);
					
					if(stand_wing_mc)
						ColorTransformUtils.setGreen(stand_wing_mc);
					if(run_wing_mc)
						ColorTransformUtils.setGreen(run_wing_mc);
					break;
				case ColorTransformUtils.ZBlue:
					if(mounts_stand_mc)
						ColorTransformUtils.setZBlue(mounts_stand_mc);
					if(mounts_run_mc)
						ColorTransformUtils.setZBlue(mounts_run_mc);
					
					if(stand_wing_mc)
						ColorTransformUtils.setZBlue(stand_wing_mc);
					if(run_wing_mc)
						ColorTransformUtils.setZBlue(run_wing_mc);
					break;
				case ColorTransformUtils.Blue:
					if(mounts_stand_mc)
						ColorTransformUtils.setBlue(mounts_stand_mc);
					if(mounts_run_mc)
						ColorTransformUtils.setBlue(mounts_run_mc);
					
					if(stand_wing_mc)
						ColorTransformUtils.setBlue(stand_wing_mc);
					if(run_wing_mc)
						ColorTransformUtils.setBlue(run_wing_mc);
					break;
			}
		}
		
		private function _trace(value:String, mc:Sprite):void{
			if(role.isNPC) return;
			var _str:String = "MID:" + mountId + ", action:" + value + ", mc:" + mc;
			trace(_str);
			ApplicationStats.getInstance().push(_str);
		}
		
		private function delay_hitest():void {
			if(mounts_run_mc && mounts_stand_mc){
				if(mounts_run_mc.stage && !mounts_stand_mc.stage || !mounts_run_mc.stage && mounts_stand_mc.stage){
					if(tween) tween.kill();
					tween = TweenLite.delayedCall(2, onDelay_hitest);
				}else{
					if(tween) tween.kill();
					tween = null;
				}
			}else{
				if(tween) tween.kill();
				tween = TweenLite.delayedCall(2, onDelay_hitest);
			}
			/*if(role && !role.isNPC) ERole(role).roleCtrl.setPath(role.x+50, role.y);*/
		}
		
		private function onDelay_hitest():void {
			if(tween) tween.kill();
			tween = null;
			/*if(role && !role.isNPC && role.action != Actions.Run) {
				ERole(role).roleCtrl.setPath(role.x+20, role.y+20);
			}*/
			onLoaded();
		}
		
		private function setReplayAction(_str:String):void{
			if(role.action_dict.hasOwnProperty(_str) && role.action_dict[_str])
				role.action_dict[_str].gotoAndPlay(1);
			if(ERole(role).maid && ERole(role).maid.action_dict.hasOwnProperty(_str) && ERole(role).maid.action_dict[_str])
				ERole(role).maid.action_dict[_str].gotoAndPlay(1);
		}

		private function onLoaded():void{
			if(!containe) return;
			
			if(mounts_run_mc == null){
				var _loadItem:LoadingItem = AssetsPool.getInstance().getSource("run", getZJKEY(), true) as LoadingItem;
				mounts_run_mc = _loadItem.getDefinition("run") as MovieClip;
				run_wing_mc = _loadItem.getDefinition("run1") as MovieClip;
				mounts_stand_mc = _loadItem.getDefinition("stand") as MovieClip;
				stand_wing_mc = _loadItem.getDefinition("stand1") as MovieClip;
			}
			
			if(role) role.ZJColor = role.ZJColor;
			
			if(mounts_run_mc){
				if(action == Actions.ZJ_Run && !containe.contains(mounts_run_mc)){
					containe.addChildAt(mounts_run_mc, 0);
					if(run_wing_mc){
						containe.addChild(run_wing_mc);
						run_wing_mc.gotoAndPlay(1);
						if(role){
							var _str:String = Actions.cove(role.action);
							setReplayAction(_str);
						}
					}
				}
				if(mounts_run_mc.contains(mounts_run_mc['_txt'])){
					monster_run_xml = XML(mounts_run_mc['_txt'].text);
					mounts_run_mc.removeChild(mounts_run_mc['_txt'])
				}
				mounts_run_mc.gotoAndPlay(2);
				///mounts_run_mc.y = -monster_run_xml.@height;
				setRunCoor();
			}
			
			if(mounts_stand_mc){
				if(action == Actions.ZJ_Stop && !containe.contains(mounts_stand_mc)){
					containe.addChildAt(mounts_stand_mc, 0);
					if(stand_wing_mc){
						containe.addChild(stand_wing_mc);
						stand_wing_mc.gotoAndPlay(1);
						if(role){
							var _str1:String = Actions.cove(role.action);
							setReplayAction(_str);
						}
					}
				}
				if(mounts_stand_mc.contains(mounts_stand_mc['_txt'])){
					monster_stand_xml = XML(mounts_stand_mc['_txt'].text);
					mounts_stand_mc.removeChild(mounts_stand_mc['_txt'])
				}
				mounts_stand_mc.gotoAndPlay(2);
				///mounts_stand_mc.y = -monster_stand_xml.@height;
				setStandCoor();
			}
			
			setMaidCoor();
//			_W = width;
//			_H = height;
			if(onComplete != null) onComplete();
		}
		
		/**暂停*/
		public function pause():void{
			if(mounts_run_mc) mounts_run_mc.stop();
			if(mounts_stand_mc) mounts_stand_mc.stop();
			if(run_wing_mc) run_wing_mc.stop();
			if(stand_wing_mc) stand_wing_mc.stop();
		}
		
		/**恢复*/
		public function reply():void{
			if(mounts_run_mc) mounts_run_mc.play();
			if(mounts_stand_mc) mounts_stand_mc.play();
			if(run_wing_mc) run_wing_mc.play();
			if(stand_wing_mc) stand_wing_mc.play();
		}
		
		public function get role():AbsERole{ return containe as AbsERole; }
		
		/**坐骑的加载KEY*/
		private function getZJKEY():String { return 'zj_key_' + mountId; }
		/**坐骑的加载URL*/
		private function getZJURL():String{ return resourceURL + mountId + '.swf'; }
		
		/**释放资源池*/
		public function disposeRes():void{
			AssetsPool.getInstance().dispose(getZJURL(), getZJKEY());
		}
		
		public function disposeA():void{
			monster_run_xml = null;
			monster_stand_xml = null;
			
			if(mounts_run_mc){
				mounts_run_mc.stop();
				if(mounts_run_mc.parent)
					mounts_run_mc.parent.removeChild(mounts_run_mc);
				if(run_wing_mc && run_wing_mc.parent)
					run_wing_mc.parent.removeChild(run_wing_mc);
				
				run_wing_mc = null;
				mounts_run_mc = null;
			}
			
			if(mounts_stand_mc){
				mounts_stand_mc.stop();
				if(mounts_stand_mc.parent)
					mounts_stand_mc.parent.removeChild(mounts_stand_mc);
				if(stand_wing_mc && stand_wing_mc.parent)
					stand_wing_mc.parent.removeChild(stand_wing_mc);
				
				stand_wing_mc = null;
				mounts_stand_mc = null;
			}
			
		}
		
		/**释放内存*/
		public function dispose():void{
			disposeRes();
			disposeA();
			containe = null;
			mounts_run_mc = null;
			run_wing_mc = null;
			mounts_stand_mc = null;
			stand_wing_mc = null;
			monster_run_xml = null;
			monster_stand_xml = null;
			monster_stand_xml = null;
			onComplete = null;
			if(tween) tween.kill();
			tween = null;
		}
		
	}
}