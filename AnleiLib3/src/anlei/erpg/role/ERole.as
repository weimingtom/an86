package anlei.erpg.role
{
	import com.D5Power.mission.NPCMissionConfig;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import anlei.erpg.EGame;
	import anlei.erpg.iface.IDOD;
	import anlei.erpg.utils.Actions;
	import anlei.util.AnleiFilter;
	import anlei.util.PublicProperty;
	
	import apps.uisystem.view.amount.SwordStarBase;
	import apps.uisystem.view.amount.SwordStarUtile;
	
	import utils.BLKey;
	
	/**具有高级设定的角色类*/
	public class ERole extends AbsERole implements IDOD
	{
		/**是否坐骑，参数坐骑ID*/
		public static const IS_FLY:String = 'is_fly';
		/**怪的ID从500*/
		public static var MONST_S:int = 500;
		/**怪的ID到600*/
		public static var MONST_E:int = 600;
		
		/**怪的初始位置*/
		public var monster_init_x:int;
		public var monster_init_y:int;
		
		public var info:Object;
		protected var _misConf:NPCMissionConfig;
		
		//所在渲染的层
		private var _parentLayer:Sprite;
		//有色彩还是只有灰色
		private var _isColor:int;
		//左右跑动的范围
		private var rang:int;
		//左右跑动到目标的执行时间(3秒)
		private var scend:int;
		private var _isRender:Boolean = true;
//		private var tween:TweenLite;
		private var _point:Point;
		/** 称号编号列表 */
		private var _featIds:Vector.<uint>;
		/** 称号显示对象列表 */
		private var featId_dict:Dictionary = new Dictionary();
		
		private var _battle:Number;
		/**战斗力星星*/
		private var battle_tip:SwordStarBase = new SwordStarBase();
		private var _maid:int;
		public var maidRole:EMaid;
		private var _ZJColor:int;
		
		
		public function ERole($isNPC:Boolean, $skinId:Number, $uid:Number, $resourceURL:String = "asset/role/") {
			super($isNPC, $skinId, $uid, $resourceURL);
			roleCtrl = new ERoleCtrl(this);
		}
		
		/**这个UI是否是怪,uid=500至600*/
		public static function isMonster(uid:int):Boolean{
			if(uid < MONST_E && uid > MONST_S){//怪
				return true;
			}
			return false;
		}
		
		public function get missionConfig():NPCMissionConfig { return _misConf; }
		/**处理NPC的任务XML数据*/
		public function parseNpcMissionXML(xml:XML):void{
			_misConf = new NPCMissionConfig();
			_misConf._say = xml.nomission.info;
			_misConf._npcname = xml.npcname;
			if(xml.nomission.event)
			{
				_misConf._setEvent(xml.nomission.event.attribute('type'), xml.nomission.event.attribute('value'), xml.nomission.event.attribute('level'));
			}
			
			for each(var data:* in xml.mission)
			{
				_misConf.addMission(data.id,data);
			}
		}
		
		public function getPos():Point{
			if(_point == null) _point = new Point();
			_point.x = this.x;
			_point.y = this.y;
			return _point;
		}
		/**设定坐标*/
		public function move($x:Number, $y:Number, $isTarget:Boolean = false):void{
			if(!isNPC){
				trace("进入地图设定主角坐标:", $x, $y);
			}
			x = $x;
			y = $y;
			if(_point){
				_point.x = x;
				_point.y = y;
			}
			if($isTarget && !isNPC){
				EGame.camera.target = EGame.camera.target;
			}
			if(maidRole || (maidRole && !mountRes) || (maidRole && mountRes && !mountRes.isMaidZJ())) maidRole.init();
		}
		
		public function get H():Number { 
			if(_H.toString() == 'NaN') _H = this.offShadow.height;
			return _H;
		}
		public function set H(value:Number):void { _H = value; }
		
		public function get W():Number {
			if(_W.toString() == 'NaN') _W = this.offShadow.width;
			return _W; 
		}
		public function set W(value:Number):void { _W = value; }
		
		/**所在渲染的层*/
		public function get parentLayer():Sprite { return _parentLayer; }
		public function set parentLayer(value:Sprite):void { _parentLayer = value; }
		
		/**有色彩还是只有灰色*/
		public function get isColor():int{ return _isColor; }
		public function set isColor(value:int):void{
			_isColor = value;
			if(value){
				AnleiFilter.setNotColor(render);
			}else{
				AnleiFilter.setRgbColor(render);
			}
			if(mountRes) mountRes.isColor = isColor;
		}
		
		/**坐骑色彩*/
		override public function get ZJColor():int{ return _ZJColor; }
		override public function set ZJColor(value:int):void{
			_ZJColor = value;
			if(mountRes) mountRes.ZJColor = value;
		}
		
		/**是否被玩家屏蔽*/
		public function get isRender():Boolean{ return _isRender; }
		public function set isRender(value:Boolean):void{
			_isRender = value;
			if(isRender){
				if(parentLayer && !parentLayer['contains'](this)){
					parentLayer.addChild(this);
				}
				
				if(maidRole && maidRole.parentLayer && !maidRole.parentLayer['contains'](maidRole)){
					maidRole.parentLayer.addChild(maidRole);
				}
				
			}else{
				if(parentLayer && parentLayer['contains'](this)){
					parentLayer.removeChild(this);
				}
				
				if(maidRole && maidRole.parentLayer && maidRole.parentLayer['contains'](maidRole)){
					maidRole.parentLayer.removeChild(maidRole);
				}
				
			}
		}
		
		public function set isMouse(value:Boolean):void{
			mouseEnabled = value;
		}
		
//		/**向左或右跑动
//		 * @param $rang		范围
//		 * @param $scend	时间(秒)
//		 */
//		public function isRndRun($rang:int = 100, $scend:int = 3):void{
//			rang = $rang;
//			scend = $scend;
//			this.action = Actions.Run;
//			this.roleCtrl.direction = ERoleCtrl.LEFT;
//			
//			monster_init_x = x;
//			monster_init_y = y;
//			
//			tween = TweenLite.to(this, $scend, {x:this.x - rang, onComplete:onRndRunComp });
//		}
//		
//		/**停止向左或右跑动*/
//		public function isRndStop():void{
//			if(tween){
//				tween.kill();
//				tween = null;
//			}
//			this.action = Actions.Stop;
//		}
//		
//		/**向左或右跑动完后再跑回去*/
//		private function onRndRunComp():void{
//			///this.action = Actions.Run;
//			this.roleCtrl.direction = ERoleCtrl.RIGHT;
//			tween = TweenLite.to(this, 3, {x:this.x + rang, onComplete:isRndRun,onCompleteParams:[rang, scend]});
//		}
		
		
		
		/**暂停*/
		public function pause():void{
			if(mountRes) mountRes.pause();
			for(var _item:Object in action_dict){
				if(action_dict[_item]) action_dict[_item].stop();
			}
//			if(tween) tween.kill();
		}
		
		/**恢复*/
		public function reply():void{
			if(mountRes) mountRes.reply();
			for(var _item:Object in action_dict){
				if(action_dict[_item]) action_dict[_item].play();
			}
//			if(tween) onRndRunComp();
		}
		
		
		/**更换场景时要调用该方法来创建自己角色内的东西*/
		public function changeMap():void{
			EGame.camera.game.scene.addObject(this);
			if(maidRole) EGame.camera.game.scene.addObject(maidRole);
		}
		
		public function remove():void{
			EGame.camera.game.scene.removeObject(this);
			if(maidRole) EGame.camera.game.scene.removeObject(maidRole);
		}
		
		/**加载皮肤*/
		public function createMeRole():void{
			//this.action = Actions.Stop;
		}
		
		/**在战场快速加载皮肤*/
		public function battleResetAction():void{
			this.action = Actions.BattleStop;
			EGame.camera.game.scene.addObject(this);
		}
		
		/**女仆跟随ID*/
		public function getMaid():int{ return _maid; }
		public function get maid():EMaid {return maidRole;}
		public function setMaid($skinId:int, $name:String):void{
			/*if(maid == $skinId)
				return;*/
			if(_maid != $skinId && maidRole && maidRole.parent){
				maidRole.parent.removeChild(maidRole);
			}
			_maid = $skinId;
			if(_maid == 0){
				if(maidRole){
					maidRole.skinId = 0;
					//maidRole.action = Actions.Stop;
					maidRole.lord = null;
					EGame.camera.game.scene.removeObject(maidRole);
				}
			}else{
				if(maidRole == null){
					maidRole = new EMaid(0);
				}
				if(maidRole.lord != this){
					maidRole.lord = this;
				}
				if(!maidRole.parent){
					EGame.camera.game.scene.addObject(maidRole);
					maidRole.skinId = _maid;
					maidRole.setName($name);
					maidRole.action = Actions.Stop;
				}
			}
			if(maidRole && maidRole.skinId != 0) maidRole.resetParentLayer();
		}
		
		public function get featIds():Vector.<uint>{ return _featIds; }
		public function set featIds(value:Vector.<uint>):void{
			_featIds = value;
			
			for (var i:int = 0; i < value.length; i++) {
				var _mc:Sprite = featId_dict[value[i]];
				if(_mc != null && title.contains(_mc)){
					title.removeChild(_mc);
				}
			}
			
			for (i = 0; i < value.length; i++) {
				if(featId_dict[value[i]] == null){
					//////////////////////////
					featId_dict[value[i]] = PublicProperty.GetSourceMC("title_" + value[i], BLKey.ICON_TXT);
				}
				title.addChild(featId_dict[value[i]]);
			}
		}
		
		/**战斗力(星星)*/
		public function get battle():Number{ return _battle; }
		public function set battle(value:Number):void {
			_battle = value;
			/*var _lv:int = SwordStarUtile.getInstance().BattleToStar(value);
			if(_lv != battle_tip.getLv()) battle_tip.setLv(_lv);
			if(battle_tip) title.addChild(battle_tip);*/
			if(_textBitmap) title.addChild(_textBitmap);
		}
		
		override public function dispose():void{
			_parentLayer = null;
//			if(tween) tween.kill();
//			tween = null;
			info = null;
			
			if(roleCtrl){
				roleCtrl.dispose();
			}
			roleCtrl = null;
			
			if(_misConf){
				_misConf.dispose();
				_misConf = null;
			}
			_point = null;
			
			_featIds = null;
			featId_dict = null;
			
			if(maidRole){
				maidRole.dispose();
				maidRole = null;
			}
			
			if(battle_tip){
				battle_tip.dispose();
				battle_tip = null;
			}
			
			super.dispose();
		}
		
	}
}