package anlei.erpg
{
	import com.D5Power.mission.EventData;
	import com.D5Power.mission.MissionData;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import anlei.erpg.role.AbsERole;
	import anlei.erpg.role.EMonsterRole;
	import anlei.erpg.role.ERole;
	import anlei.erpg.utils.Actions;
	import anlei.util.NavMeshMer;
	import anlei.util.PublicProperty;
	
	import apps.rpgsystem.actors.map.view.EliteDupView;
	
	import ui.component.MyLoader;
	import ui.component.MySprite;

	/**场景*/
	public class EScene extends MySprite
	{
		/**排序ID*/
		public static var SORT_ID:Number = 1;
		
		private var small_load:MyLoader;
		private var quest:URLRequest;
		private var config_load:URLLoader;
		private var config_xml:XML;
		public var aroad:MyLoader;
		
		/**寻路网络*/		
		public var nav:NavMeshMer;
		
		private var bg_layer:MySprite = new MySprite();
		public var bg1:MyLoader;
		public var bg2:MyLoader;
		
		public var mapid:int;
		/**主角*/
		public var playRole:ERole;
		/**地表格子loader(ETile)*/
		public var tiles_arr:Array = [];
		/**地表格子层*/
		public var tiles_layer:MySprite = new MySprite();
		
		/**NPC*/
		public var npc_arr:Array = [];
		/**成员(角色，传送点)*/
		public var member_arr:Array = [];
		/**成员(角色，传送点)层*/
		public var member_layer:MySprite = new MySprite();
		
		/**摄像机*/
		public var camera:ECamera;
		/**配置文档定义的宽*/
		public var W:Number;
		/**配置文档定义的高*/
		public var H:Number;
		
		/**缩略图加载完成*/
		public var smallMapCallback:Function;
		/**完成场景的创建*/
		public var initSceneCallBack:Function;
		/**到达最右边所执行*/
		public var toWidthCallBack:Function;
		/**不在最右边所执行*/
		public var noToWidthCallBack:Function;
		
		public function EScene($mapid:int) {
			mapid = $mapid;
			inits();
			//this.member_layer.mouseChildren = this.member_layer.mouseEnabled = false;
		}
		
		private function inits():void {
			arrangLayer();
			
			//加载配置文档
			if(quest == null) quest = new URLRequest();
			quest.url = EGame.HTTP + "asset/config/map"+mapid+".xml?"+PublicProperty.BUILDER_VERSION;
			config_load = new URLLoader(quest);
			config_load.addEventListener(Event.COMPLETE, onConfig_complete);
		}
		
		/**排好地图内部图层*/
		public function arrangLayer():void{
			this.addChild(bg_layer);
			this.addChild(tiles_layer);
			this.addChild(member_layer);
		}
		
		private function onConfig_complete(e:Event):void {
			config_load.removeEventListener(Event.COMPLETE, onConfig_complete);
			config_xml = XML(config_load.data);
			config_load.data = null;
			config_load = null;
			
			W = config_xml.width;
			H = config_xml.height;
			
			//加载可点击的图片层
			if(getXMLNavRoad().length() > 0){
				var _url:String = String(getXMLNavRoad().url);
				quest.url = EGame.HTTP + "asset/config/"+_url+"?"+PublicProperty.BUILDER_VERSION;
				var nav_load:URLLoader = new URLLoader(quest);
				nav_load.dataFormat = URLLoaderDataFormat.BINARY;
				nav_load.addEventListener(Event.COMPLETE, onNav_Complete);
			}else{
				loadAroad();
			}
		}
		
		private function loadAroad():void{
			var _url:String = ETile.getURL(int(config_xml.tilefile),'a','png');
			aroad = new MyLoader(_url, onARoad_Complete);
		}
		
		private function onNav_Complete(evt:Event):void {
			if(!nav) nav = new NavMeshMer(0, 0, W, H);
			nav.a2p(evt.currentTarget.data);
			loadAroad();
		}
		
		private function onARoad_Complete():void {
			
			aroad.width = W;
			aroad.height= H;
			
			createTiles();
			createMember();
			createRoad();
			
			loadBG();
			
			camera.target = playRole;
			if(playRole) playRole.roleCtrl.addListener(this);
			
			trace("剧情隐藏场景人物2:", member_arr.length);
			if(initSceneCallBack != null){
				initSceneCallBack();
				//TweenLite.delayedCall(1, initSceneCallBack);
			}
			trace("剧情隐藏场景人物3:", member_arr.length);
			
		}
		
		private function addBG():void{
			bg_layer.addChild(bg1);
			bg_layer.addChild(bg2);
		}
		
		private function loadBG():void{
			var _url:String;
			if(!bg1){
				_url = ETile.getURL(int(config_xml.tilefile),'bg1','jpg');
				bg1 = new MyLoader(_url, onBG1_onComplete, false, false);
				bg1.y = 0;
//			}else{
//				bg1.setQuestUrl(_url);
			}
			
			if(!bg2){
				_url = ETile.getURL(int(config_xml.tilefile),'bg2','png');
				bg2 = new MyLoader(_url, onBG2_onComplete, false, false);
				bg2.y = 0;//100;
//			}else{
//				bg2.setQuestUrl(_url);
			}
			addBG();
		}
		
		private function onBG1_onComplete():void {
//			bg1.x = (W - bg1.width)*.5;
		}
		
		private function onBG2_onComplete():void {
//			bg2.x = (W - bg2.width)*.5;
		}
		
		private function onSmall_complete():void{
			loadBG();
			small_load.width = config_xml.width;
			small_load.height= config_xml.height;
			if(smallMapCallback!=null) smallMapCallback();
		}
		
		/**创建地表格子*/
		private function createTiles():void{
			small_load = new MyLoader(ETile.getURL(int(config_xml.tilefile), 's', 'jpg'), onSmall_complete);
			bg_layer.addChildAt(small_load, 0);
			
			ETile.tween_i = 0;
			var i_len:int = W/config_xml.tilew;
			var j_len:int = H/config_xml.tileh;
			for (var i:int = 0; i < i_len; i++) {
				for (var j:int = 0; j < j_len; j++) {
					var tile:ETile = new ETile(config_xml.tilefile, j+"_"+i, config_xml.type);
					tile.W = config_xml.tilew;
					tile.H = config_xml.tileh;
					tile.x = i * tile.W;
					tile.y = j * tile.H;
					tile.parentLayer = tiles_layer;
					tiles_arr.push(tile);
					/*if(!tiles_layer.contains(tile)) */tiles_layer.addChild(tile);
				}
			}
		}
		
		/**创建成员(NPC，或建筑物)*/
		private function createMember():void{
			var _xml:XMLList = config_xml.member.npc;
			var len:int = _xml.length();
			for (var i:int = 0; i < len; i++) {
				var _id:int = _xml[i].id;
				if(int(_xml[i].skinId) > 0){
					_id = _xml[i].skinId;
				}
				
				var monsterID:uint = _xml[i].id;
				var _npc:ERole;
				if(ERole.isMonster(monsterID)){
					_npc = new EMonsterRole(true, 0, monsterID, 'asset/role/');
				}else{
					_npc= new ERole(true, _id, monsterID, 'asset/role/');
					_npc.skinId = _id;
				}
				_npc.getNameText().format.color = 0xFFFFFF;
				//_npc.uid = monsterID;
				_npc.x = _xml[i].x;
				_npc.y = _xml[i].y;
				_npc.remote = setRemote(_xml[i].remote);
				_npc.monster_init_x = _npc.x;
				_npc.monster_init_y = _npc.y;
				_npc.action = Actions.Stop;
				///_npc.setName("NPC"+_npc.uid);
//				_npc.x = Math.random()*W;
//				_npc.y = Math.random()*H;
//				if(ERole.isMonster(_npc.uid)){
//					_npc.isRndRun();
//				}
				if(_npc is EMonsterRole)
				{
					(_npc as EMonsterRole).aiStart();
					//////////////////////////
					(_npc as EMonsterRole).onTouchedPlayer = EliteDupView.onMonsterTouchedPlayer;
				}
				_npc.parentLayer = member_layer;
				member_arr.push(_npc);
				npc_arr.push(_npc);
				addObject(_npc);//member_layer.addChild(_npc);
			}
			
		}
		
		/**创建成员(传送点)*/
		private function createRoad():void{
			var _xml:XMLList = config_xml.member.road;
			var len:int = _xml.length();
			for (var i:int = 0; i < len; i++) {
				var _road:ERole = new ERole(true, AbsERole.ROAD_ID, _xml[i].id,  'asset/role/');
				//_road.loadSource(EGameInit.HTTP + 'asset/road.swf');
				_road.x = _xml[i].x;
				_road.y = _xml[i].y;
				//_road.uid = _xml[i].id;
				_road.remote = setRemote(_xml[i].remote);
				_road.action = Actions.Stop;
				_road.parentLayer = member_layer;
				member_arr.push(_road);
				member_layer.addChild(_road);
			}
		}
		
		public function getMember($uid:int):ERole{
			for (var i:int = 0; i < member_arr.length; i++) {
				var _sr:ERole = member_arr[i] as ERole;
				if(_sr.uid == $uid){
					return _sr;
					break;
				}
			}
			return null;
		}
		
		/**添加玩家*/
		public function addPlayer($role:ERole):void {
			playRole = $role;
			playRole.parentLayer = member_layer;
			addObject(playRole);
			
			if(!camera.target){
				camera.target = playRole;
				if(playRole) playRole.roleCtrl.addListener(this);
			}
//			camera.target = playRole;
//			playRole.roleCtrl.addListener(this);
		}
		
		private function setRemote($r:String):Boolean{
			if($r == "true") return true;
			return false;
		}
		
		public function removeObject($dod:DisplayObject):void{
			if(member_layer.contains($dod))
				member_layer.removeChild($dod);
		}
		
		public function addObject($dod:DisplayObject):void{
			var _role:ERole = ERole($dod);
			if(_role && !_role.isRender){
				_role.isRender = false;
				return;
			}
			_role.SORT_ID = SORT_ID += 0.0001;
			if(SORT_ID >= 3000) SORT_ID = 0;
			member_layer.addChild($dod);
		}
		
		/**有任务的NPC所发出的事件*/
		public function missionCallBack(name:String, say:String, event:EventData, miss:Vector.<MissionData>, obj:ERole):void{ }
		/**没有任务的NPC所发出的事件，如：门，怪*/
		public function notMissionCallBack($uid:AbsERole):void{}
		
		override public function dispose():void{
			if(small_load){
				if(small_load.parent) small_load.parent.removeChild(small_load);
				small_load.dispose();
				small_load = null;
			}
			
			quest = null;
			
			if(config_load){
				config_load.removeEventListener(Event.COMPLETE, onConfig_complete);
				try{
					config_load.close();
				}catch(e:*){
					trace("config_load.close();");
				}
			}
			config_load = null;
			config_xml = null;
			
			if(playRole){
				playRole.roleCtrl.unLinstener();
				playRole = null;
			}
			
			if(aroad){
				if(aroad.parent) aroad.parent.removeChild(aroad);
				aroad.dispose();
				aroad = null;
			}
			
			if(bg_layer){
				if(bg_layer.parent) bg_layer.parent.removeChild(bg_layer);
				bg_layer.dispose();
			}
			
			if(tiles_arr){
				for each(var tile:ETile in tiles_arr) {
					tile.dispose();
				}
			}
			tiles_arr = null;
			
			if(tiles_layer){
				if(tiles_layer.parent) tiles_layer.parent.removeChild(tiles_layer);
				tiles_layer.dispose();
				tiles_layer = null;
			}
			
			if(member_arr){
				for each(var _road:ERole in member_arr) {
					_road.dispose();
				}
			}
			member_arr = null;
			npc_arr = null;
			
			if(member_layer){
				if(member_layer.parent) member_layer.parent.removeChild(member_layer);
				member_layer.dispose();
				member_layer = null;
			}
			
			camera = null;
			
			smallMapCallback = null;
			initSceneCallBack = null;
			toWidthCallBack = null;
			noToWidthCallBack = null;
			
			if(bg1) bg1.dispose();
			bg1 = null;
			
			if(bg2) bg2.dispose();
			bg2 = null;
			
			nav = null;
			
			super.dispose();
		}
		
		public function getXMLCustom():XML
		{
			return config_xml.custom;
		}
		
		public function getXMLNavRoad():XMLList{
			return config_xml.navroad;
		}
	}
}