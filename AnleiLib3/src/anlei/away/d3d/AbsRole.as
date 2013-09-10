package anlei.away.d3d
{
	import anlei.util.EnterFrame;

	public class AbsRole extends AbsMesh
	{
		private var onComplete:Function;
		public var ctrl:AbsRoleCtrl;
		
		private var _equips:AbsRoleEquips;
		
		public function AbsRole($path:String="assets/role/")
		{
			super('', $path);
		}
		
		public function get equips():AbsRoleEquips {
			_equips ||= new AbsRoleEquips(this);
			return _equips;
		}
		
		public function add($skinId:String, $onComplete:Function):void{
			skinId = $skinId;
			fileName = $skinId;
			key = path + fileName;
			onComplete = $onComplete;
			
			load(null, [
				[ "Warrior_3.jpg", "Warrior_4.jpg", "Warrior_2.jpg", "Warrior_1.jpg","Warrior_5.jpg", "Warrior_6.jpg"],
				["attack1.MD5ANIM", "attack2.MD5ANIM",
					"battleStand.MD5ANIM", "block.MD5ANIM", "die.MD5ANIM",
					"hit.MD5ANIM", "run.MD5ANIM", "stand.MD5ANIM",
					"walk.MD5ANIM"], ["role.MD5MESH"]],
				onAmmComp
			);
		}
		
		private function onAmmComp(evt:AbsMesh):void {
			mesh.scale(0.5);
			if(onComplete) onComplete();
			if(isPlayer){
				ctrl = new AbsRoleCtrl(this);
			}
			if(!EnterFrame.hasFunction(update)){
				EnterFrame.enterFrame = update;
			}
		}
		
		private function update():void{
			if(ctrl) ctrl.update();
			if(_equips) _equips.update();
		}

	}
}