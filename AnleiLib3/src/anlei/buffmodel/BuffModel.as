///////////////////////////////////////////////////////////
//  BuffModel.as
//  Macromedia ActionScript Implementation of the Class BuffModel
//  Generated by Enterprise Architect
//  Created on:      06-五月-2011 16:35:57
//  Original author: Anlei
///////////////////////////////////////////////////////////

package anlei.buffmodel
{
	import flash.display.Sprite;
	
	import anlei.buffmodel.iface.IMedical;
	import anlei.buffmodel.utils.BuffTimer;
	import anlei.buffmodel.utils.RoleProperty;

	/**
	 * Buff系统
	 * @author Anlei
	 * @version 1.0
	 * @created 06-五月-2011 16:35:57
	 */
	public class BuffModel
	{
	    private var role: RoleProperty;
		
	    /**防具池*/
	    private var equipment_arr: Vector.<IMedical>;
	    /**临时状态池*/
	    private var tempState_arr: Vector.<IMedical>;
		/**计时组件*/
		private var btimer:BuffTimer;
		
		/**接受别人的普通攻击, attacker是发动攻击者对象,返回伤害*/
		public var acceptAttack:Function;
		
		/**接受别人的魔法攻击，attacker是发动攻击者对象*/
		public var acceptMacageAttack:Function;

	    public function BuffModel($role:RoleProperty)
	    {
			inits();
			role = $role;
			btimer = new BuffTimer(role);
			btimer.equipment_arr = this.equipment_arr;
			btimer.tempState_arr = this.tempState_arr;
			
			acceptAttack = onAcceptAttack;
			acceptMacageAttack = onAcceptMacageAttack;
	    }
		public function setRole($role:RoleProperty):void{
			role = $role;
			btimer.setRole(role);
		}
		public function dispose():void{
			btimer.dispose();
			btimer.equipment_arr = null;
			btimer.tempState_arr = null;
			btimer = null;
			
		}
		private function inits():void
		{
			equipment_arr = new Vector.<IMedical>();
			tempState_arr = new Vector.<IMedical>();
		}
		
		/**按ID找装备*/
		public function findEquip($id:String):IMedical{
			var _len:int = equipment_arr.length;
			for(var i:int = 0 ; i<_len; i++){
				if($id == equipment_arr[i].id) return equipment_arr[i];
			}
			return null;
		}
		/**按ID找临时状态*/
		public function findTemp($id:String):IMedical{
			var _len:int = tempState_arr.length;
			for(var i:int = 0 ; i<_len; i++){
				if($id == tempState_arr[i].id) return tempState_arr[i];
			}
			return null;
		}
		
	    /**增加装备，或临时状态*/
	    public function addES($object:IMedical): void
	    {
			if($object.isES){
				btimer.addEquipment($object);
			}else{
				btimer.addTempState($object);
			}
	    }

	    /** 卸载装备，或临时状态*/
	    public function removeES($object:IMedical): void
	    {
			if($object.isES){
				btimer.removeEquipment($object);
			}else{
				btimer.removeTempState($object);
			}
	    }
		
		/**接受别人的普通攻击, attacker是发动攻击者对象,返回伤害*/
		private function onAcceptAttack(attacker:RoleProperty):int
		{
			if(role.invincible) return -1;
			if(role.comDodgeRate()){
				attacker.byTheDodge();
				return -1;
			}
			
			var q1:Number = RoleProperty.X * role.getTotalDP()/(1+RoleProperty.X *role.getTotalDP());
			var _subhp:int = attacker.getTotalAP() * (1-q1);
			if(attacker.comCritRate()){
				trace("["+role.name+"]被物理["+attacker.name+"]爆菊了");
				_subhp *= 2;
			}
			
			execRebound(attacker, _subhp);
			//攻击者的吸收执行
			attacker.buff.execAbsorption(attacker, _subhp, 1);
			//被击者的伤害吸收
			execAbsorption(role, _subhp, 2);
			
			attacker.buff.execWithMedical(attacker, role);
			
			role.HP -= _subhp;
			return _subhp;
		}
		
		/**接受别人的魔法攻击，attacker是发动攻击者对象*/
		public function onAcceptMacageAttack(medicalHar:Number, attacker:RoleProperty, isGet:Boolean = true): int
		{
			if(role.mInvincible) return -1;
			if(role.comDodgeRate()){
				attacker.byTheDodge();
				return -1;
			}
			
			var _subhp:Number = ((attacker.getTotalAP() + medicalHar)) * (1-0.25) * (1-role.MDP/100);
			if(attacker.comCritRate()){
				trace("["+role.name+"]被魔法["+attacker.name+"]爆菊了");
				_subhp = _subhp*1.5;
			}
			
			if(isGet) role.HP -= _subhp;
			
			return _subhp;
		}
		
		
		/***********-----------<-public----分隔线----private->---------*************************/
		
		
		/**物理装备反弹效果*/		
		public function execRebound($attacker:RoleProperty, $subhp:int):void{
			for(var i:int = 0 ; i < equipment_arr.length; i++){
				if(equipment_arr[i].rebound) equipment_arr[i].execRebound($attacker, $subhp);
			}
		}
		
		/**物理装备吸收效果*/		
		public function execAbsorption($IRole:RoleProperty, $subhp:int, $flag:int):void{
			for(var i:int = 0 ; i < equipment_arr.length; i++){
				if(equipment_arr[i].absorption == $flag) equipment_arr[i].execAbsorption($IRole, $subhp);
			}
		}
		
		/**执行物理装备的带魔法效果*/
		public function execWithMedical($attacker:RoleProperty, $IRole:RoleProperty):void{
			var _len:int = $attacker.buff.equipment_arr.length;
			for(var i:int = 0 ; i < _len; i++){
				var _medical:IMedical = $attacker.buff.equipment_arr[i];
				if(_medical.iMedical != null){
					var im_len:int = _medical.iMedical.length;
					for(var j:int = 0 ; j < im_len; j++){
						var imi:IMedical = _medical.iMedical[i];
						if(comTrigger(imi.trigger)){
							imi.reset();
							$IRole.buff.addES(imi);
						}
					}
				}
			}
		}
		private function comTrigger(rate:int):Boolean{
			if(rate <= 0) return false;
			return int(Math.random() * 100) <= rate ? true : false;
		}
		
	}
}