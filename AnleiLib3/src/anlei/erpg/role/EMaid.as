package anlei.erpg.role
{
	import anlei.erpg.EGame;
	import anlei.erpg.utils.Actions;
	import anlei.util.CoorAway;
	import anlei.util.EnterFrame;

	public class EMaid extends ERole
	{
		public static const FOLLOW_RANGE:int = 200;
		public static const KEEP_DISTANCE_RANGE:int = 200;
		private var _lord:ERole;
		
		public function EMaid($skinId:Number, $resourceURL:String="asset/role/")
		{
			super(true, $skinId, 0, $resourceURL);
			this.mouseChildren = this.mouseEnabled = false;
			resetParentLayer();
		}
		
		public function resetParentLayer():void{
			parentLayer = EGame.camera.game.scene.member_layer;
		}
		
		public function get lord():ERole
		{
			return _lord;
		}

		public function set lord(value:ERole):void
		{
			if(!value){
				if(	EnterFrame.hasFunction(aiLoop))
					EnterFrame.removeEnterFrame = aiLoop;
				this.roleCtrl.clearPath();
				parentLayer.addChild(this);
			}
			if(!_lord && value && value.mounts > 0 && value.mountRes.isMaidZJ()){
				return;
			}
			_lord = value;
			if(lord){
				init();
				if(!EnterFrame.hasFunction(aiLoop))
					EnterFrame.enterFrame = aiLoop;
				this.roleCtrl.clearPath();
			}
		}
		
		private function aiLoop():void {
			
			if(!_lord || !roleCtrl)
				return;
			
			var distance:Number = CoorAway.getToTargetDistance(_lord.getPos(),this.getPos());
			if(distance>FOLLOW_RANGE)
			{
				this.roleCtrl.speed=_lord.roleCtrl.speed;
				this.roleCtrl.setPath(_lord.x,_lord.y);
			}
			else if(distance<KEEP_DISTANCE_RANGE)
			{
				this.roleCtrl.clearPath();
			}
		}
		
		public function init():void
		{
			if(_lord)
			{
				this.x = _lord.x-Math.random()*50-80;
				this.y = _lord.y-Math.random()*100+50;
			}
		}
		
		public override function dispose():void
		{
			super.dispose();
			parentLayer = null;
			_lord = null;
		}
	}
}