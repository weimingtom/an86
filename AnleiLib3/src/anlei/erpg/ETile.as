package anlei.erpg
{
	import com.greensock.TweenLite;
	
	import flash.display.Sprite;
	
	import anlei.erpg.iface.IDOD;
	
	import ui.component.MyLoader;

	public class ETile extends MyLoader implements IDOD
	{
		/**缓冲加载累计*/
		public static var tween_i:int = 0;
		/**是否加载完成的总数*/
		public static var TOTAL_NUM:int = 0;
		private static var _CURR_NUM:int = 0;
		////////////////////////////////
		private var tween:TweenLite;
		private var _W:Number;
		private var _H:Number;
		private var _parentLayer:Sprite;
		
		private var mapid:int;
		private var tileId:String;
		private var type:String;
		public var isLoad:Boolean = false;
		
		public function ETile($mapid:int, $tileId:String, $type:String = 'jpg') {
			mapid	= $mapid;
			tileId	= $tileId;
			type	= $type;
			super(null, onComplete);
		}
		
		public function setName(value:String, $color:Number = 0x00FF00):void{}
		
		public function get H():Number { return _H; }
		public function set H(value:Number):void { _H = value; }

		public function get W():Number { return _W; }
		public function set W(value:Number):void { _W = value; }
		
		public function get parentLayer():Sprite { return _parentLayer; }
		public function set parentLayer(value:Sprite):void { _parentLayer = value; }
		
		private function onComplete():void{
			//trace("load ETile complete!");
			CURR_NUM++;
		}
		
		public function reload():void{
			if(!tween && !isLoad)
				tween = TweenLite.delayedCall((++tween_i)/10, tween_reload);
		}
		
		private function tween_reload():void{
			if(!isLoad){
				isLoad = true;
				tween_i--;
				var _url:String = getURL(mapid, tileId, type);
				setQuestUrl(_url);
			}
			if(tween){
				tween.kill();
				tween = null;
			}
		}
		
		override public function dispose():void{
			if(tween) tween.kill();
			tween = null;
			
			if(parent) parent.removeChild(this);
			parentLayer = null;
			
			super.dispose();
		}
		
		public static function getURL(mapid:int, tileId:String, type:String = 'jpg'):String{
			return EGame.HTTP + "asset/tiles/"+mapid+"/"+tileId+"."+type
		}

		/**当前加载完成的总数*/
		public static function get CURR_NUM():int { return _CURR_NUM; }
		public static function set CURR_NUM(value:int):void {
			_CURR_NUM = value;
			if(CURR_NUM > TOTAL_NUM){
				if(!EGame.camera.game.scene.bg1.isLoaded)
					EGame.camera.game.scene.bg1.startLoad();
				if(!EGame.camera.game.scene.bg2.isLoaded)
					EGame.camera.game.scene.bg2.startLoad();
			}
		}

	}
}