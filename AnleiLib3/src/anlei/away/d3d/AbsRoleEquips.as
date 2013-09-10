package anlei.away.d3d
{
	import flash.geom.Vector3D;
	
	import away3d.animators.data.JointPose;

	public class AbsRoleEquips
	{
		private var _role:AbsRole;

		private var _lHandIndex:int = -1;
		private var _rHandIndex:int = -1;

		private var _lJointPose:JointPose;
		private var _rJointPose:JointPose;
		private var _rHandItem:AbsMesh ;
		private var _lHandItem:AbsMesh ;
		
		public function AbsRoleEquips($role:AbsRole)
		{
			_role = $role;
		}
		
		private function getLHandIndex():int{
			if(_lHandIndex == -1){
				_lHandIndex = _role.skeleton.jointIndexFromName("Bip001 L Hand");
			}
			return _lHandIndex;
		}
		
		private function getRHandIndex():int{
			if(_rHandIndex == -1){
				_rHandIndex = _role.skeleton.jointIndexFromName("Bip001 R Hand");
			}
			return _rHandIndex;
		}
		
		private function getLHandJointPose():JointPose{
			_lJointPose ||= _role.animator.globalPose.jointPoses[getLHandIndex()];
			return _lJointPose;
		}
		
		private function getRHandJointPose():JointPose{
			_rJointPose ||= _role.animator.globalPose.jointPoses[getRHandIndex()];
			return _rJointPose;
		}
		
		private function getLHandPosition():Vector3D {
			return getLHandJointPose().toMatrix3D().position;
		}
		
		private function getRHandPosition():Vector3D {
			return getRHandJointPose().toMatrix3D().position;
		}
		
		public function addLHandItem(value:String):void{
			if(!_lHandItem){
				_lHandItem = new AbsMesh(value, "assets/equip/");
				_lHandItem.load(_role.mesh, [["dun1.jpg"], [], ["dun1.AWD"]], null);
			}
		}
		
		public function addRHandItem(value:String):void{
			if(!_rHandItem){
				_rHandItem = new AbsMesh("jian1", "assets/equip/");
				_rHandItem.load(_role.mesh, [["jian1.jpg"], [], ["jian1.AWD"]], null);
			}
		}
		
		public function update():void{
			if(_lHandItem && _lHandItem.mesh){
				_lHandItem.mesh.position = getLHandPosition();
			}
			if(_rHandItem && _rHandItem.mesh){
				_rHandItem.mesh.position = getRHandPosition();
			}
		}
		
	}
}