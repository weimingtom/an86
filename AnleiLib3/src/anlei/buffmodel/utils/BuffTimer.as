///////////////////////////////////////////////////////////
//  BuffTimer.as
//  Macromedia ActionScript Implementation of the Class BuffTimer
//  Generated by Enterprise Architect
//  Created on:      06-五月-2011 16:35:57
//  Original author: Anlei
///////////////////////////////////////////////////////////

package anlei.buffmodel.utils
{
	import flash.display.Sprite;
	
	import anlei.buffmodel.iface.IMedical;
	import anlei.buffmodel.utils.RoleProperty;
	
	import ui.component.MyTimer;

	/**
	 * Buff系统的计时组件
	 * @author Anlei
	 * @version 1.0
	 * @created 06-五月-2011 16:35:57
	 */
	public class BuffTimer
	{
		private static const LOOP_STATE_TIME:Number = 200;
		
	    private var role: RoleProperty;
		
	    /**
	     * 防具池
	     */
		public var equipment_arr: Vector.<IMedical>;
	    /**
	     * 临时状态池
	     */
		public var tempState_arr: Vector.<IMedical>;

		private var time:MyTimer;
		
	    public function BuffTimer(role:RoleProperty)
	    {
			this.role = role;
			inits();
	    }
		public function setRole($role:RoleProperty):void{
			role = $role;
		}
		public function dispose():void{
			for(var i:int = 0 ; i < equipment_arr.length; i++){
				equipment_arr[i] = null;
			}
			equipment_arr = null;
			
			for(i = 0 ; i < tempState_arr.length; i++){
				tempState_arr[i] = null;
			}
			tempState_arr = null;
			
			time.stop();
			time.removeEventListener(MyTimer.TIMER, onTimer);
			time = null;
		}
		private function inits():void
		{
			time = new MyTimer(LOOP_STATE_TIME);
			time.addEventListener(MyTimer.TIMER, onTimer);
		}
		
		private function onTimer(event:*):void
		{
			loopTempState();
		}
		private function loopTempState():void{
			var _len:int = tempState_arr.length;
			//if(_len <= 0) time.stop();
			for(var i:int = 0 ; i < _len; i++){
				var _medical:IMedical = tempState_arr[i];
				
				_medical.currTime += 200;
				_medical.addTime += 200;
				if(_medical.addTime >= _medical.gapTime){
//					if(_medical.id == 'BWUDI') trace("A:", _medical.currTime, tempState_arr.length);
					_medical.installProperty(role);
					_medical.addTime = 0;
				}
				
				//当前时间
				if(_medical.currTime >= _medical.totalTime){
//					trace(_medical, time.repeatCount);
//					if(_medical.id == 'BWUDI') trace("B:", _medical.currTime, tempState_arr.length);
					_medical.unInstallProperty(role);
					_medical.dispose();
					tempState_arr.splice(i, 1);
					loopTempState();
					
					return;
				}
			}
		}
		/**
		 * 是否有只能存在一种魔法（如中毒后再中毒，则把中毒的时间重头开始算）
		 */
		private function setIsResetMacage($state:IMedical):Boolean{
			var _onf:Boolean = false;
			//查看表，看看这个魔是否为单一性
			var _tm:int = MedicalID.isresetMac.indexOf($state.id);
			//如果存在，则去临时表里找同一ID的魔
			if(_tm!=-1){
				var _len:int = tempState_arr.length;
				for(var i:int = 0 ; i < _len; i++){
					//如果找到了
					if(tempState_arr[i].id == $state.id){
						tempState_arr[i].dispose();
						tempState_arr[i] = $state;
						_onf = true;
						break;
					}
				}
			}
			return _onf;
		}
		/**
		 * 清除单个ID相同的负面影响的魔法
		 */
		private function removeSignleMacage($state:IMedical):Boolean{
			var _onf:Boolean = false;
			if(!$state.negative){
				var _len:int = tempState_arr.length;
				for(var i:int = 0 ; i < _len; i++){
					//如果找到了
					if(tempState_arr[i].id == $state.id){
						removeTempState(tempState_arr[i]);
						_onf = true;
						break;
					}
				}
			}
			return _onf;
		}
		/**
		 * 清除所有负面影响的魔法
		 */
		public function removeAllNegative():void{
			var _len:int = tempState_arr.length;
			for(var i:int = 0 ; i < _len; i++){
				var _medical:IMedical = tempState_arr[i];
				if(_medical.negative){
					tempState_arr.splice(i, 1);
					_medical.dispose();
				}
			}
		}
		
		/**
		 * 清除所有正面影响的魔法
		 */
		public function removeAllNotNegative():void{
			var _len:int = tempState_arr.length;
			for(var i:int = 0 ; i < _len; i++){
				var _medical:IMedical = tempState_arr[i];
				if(!_medical.negative){
					tempState_arr.splice(i, 1);
					_medical.dispose();
				}
			}
		}

	    /**
	     * 增加装备(IDefend,IArms)。
	     */
	    public function addEquipment($object:IMedical): void
	    {
			//不允许同一个实例同时添加一次以上到池中， 但可以new个相同类的实例来添加，须看可否重叠
			if(equipment_arr.indexOf($object) != -1) return;
			$object.installProperty(role);
			equipment_arr.push($object);
			trace("增加装备:", $object.id);
	    }

	    /**
	     * 卸载装备(IDefend,IArms)。
	     */
	    public function removeEquipment($object:IMedical): void
	    {
			var _id:int = equipment_arr.indexOf($object);
			if(_id != -1){
				$object.unInstallProperty(role);
				$object.dispose();
				equipment_arr.splice(_id, 1);
				trace("卸载装备:", $object.id);
			}
	    }

	    /**增加临时状态。魔法效果*/
	    public function addTempState($state:IMedical): void
	    {
			//不允许同一个实例同时添加一次以上到池中， 但可以new个相同类的实例来添加，须看可否重叠
			if(tempState_arr.indexOf($state) != -1) return;
			
			if(removeSignleMacage($state)){
				trace("解除魔法,ID=",$state.id);
				return;
			}
			if(setIsResetMacage($state)){
				trace("已有相同的魔法,ID=",$state.id);
				return;
			}
			
			if($state.totalTime != -1){
				tempState_arr.push($state);
				if(!time.running) time.start();
			}else{
				$state.installProperty(role);
			}
			trace("增加临时状态:", $state.id);
	    }

	    /**去除临时状态。*/
	    public function removeTempState($state:IMedical): void
	    {
			var _id:int = tempState_arr.indexOf($state);
			if(_id != -1){
				$state.unInstallProperty(role);
				$state.dispose();
				tempState_arr.splice(_id, 1);
				trace("去除临时状态:", $state.id);
			}
	    }

	}//end BuffTimer

}