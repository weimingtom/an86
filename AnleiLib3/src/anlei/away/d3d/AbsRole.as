package anlei.away.d3d
{
	public class AbsRole extends AbsMesh
	{
		private var onComplete:Function;
		public var ctrl:AbsRoleCtrl;
		
		public function AbsRole($path:String="assets/role/")
		{
			super('', $path);
		}
		
		public function add($skinId:String, $onComplete:Function):void{
			skinId = $skinId;
			fileName = $skinId;
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
			if(onComplete) onComplete();
			if(isPlayer){
				ctrl = new AbsRoleCtrl(this);
			}
		}
		
		private function update():void{
			if(ctrl.cameraController) ctrl.cameraController.update();
			
		}
		
	}
}