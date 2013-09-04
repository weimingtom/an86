package anlei.buffmodel.abs
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import anlei.buffmodel.iface.IMedical;
	import anlei.buffmodel.utils.RoleProperty;
	
	public class AbstractMedical implements IMedical
	{
		/**Buff状态*/
		public var BuffState_mc:DisplayObject;
		/**弹道剪辑*/
		public var Trajectory_mc:MovieClip;
		/**单体剪辑*/
		public var SkillsSignle_mc:MovieClip;
		/**群体剪辑*/
		public var SkillsGroup_mc:MovieClip;
		
		private var _totalScend:Number = 1000;
		private var _harFirst:Number = 0;
		private var _harLast:Number = 0;
		
		private var _professionID:String;
		private var _installer:RoleProperty;
		private var _isActive:Boolean = true;
		private var _momentTrigger:Boolean = false;
		private var _trigger:int = 0;
		private var _isattackthis:Boolean = false;
		private var _imedical:Vector.<IMedical>;
		private var _ises:Boolean = true;
		private var _id:String = '';
		protected var _level:int = 0;
		private var _name:String;
		private var _rebound:Boolean = false;
		private var _absorption:int = 0;
		private var _mrebound:Boolean = false;
		private var _currTime:int = 0;
		private var _addTime:int = 0;
		private var _totalTime:int = -1;
		private var _gapTime:int = 0;
		private var _negative:Boolean = true;
		
		
		public function AbstractMedical()
		{
			reset();
		}
		public function reset():void{
			currTime = 0;
			addTime = 0;
			totalTime = -1;
			gapTime = 0;
		}
		
		public function set totalScend(value:Number):void{
			_totalScend = value;
		}
		public function get totalScend():Number{
			return _totalScend;
		}
		
		public function set harFirst(value:Number):void{
			_harFirst = value;
		}
		public function get harFirst():Number{
			return _harFirst;
		}
		
		public function set harLast(value:Number):void{
			_harLast = value;
		}
		public function get harLast():Number{
			return _harLast;
		}
		
		
		public function set professionID(value:String):void{
			_professionID = value;
		}
		public function get professionID():String{
			return _professionID;
		}
		
		public function set installer(value:RoleProperty):void{
			_installer = value;
		}
		public function get installer():RoleProperty{
			return _installer;
		}
		
		public function set isActive(value:Boolean):void{
			_isActive = value;
		}
		public function get isActive():Boolean{
			return _isActive;
		}
		
		public function set momentTrigger(value:Boolean):void{
			_momentTrigger = value;
		}
		public function get momentTrigger():Boolean{
			return _momentTrigger;
		}
		
		public function set trigger(value:int):void{
			_trigger = value;
		}
		public function get trigger():int{
			return _trigger;
		}
		public function set isAttackThis(value:Boolean):void{
			_isattackthis = value;
		}
		public function get isAttackThis():Boolean{
			return _isattackthis;
		}
		public function set iMedical(value:Vector.<IMedical>):void{
			_imedical = value;
		}
		public function get iMedical():Vector.<IMedical>{
			if(_imedical == null) _imedical = new Vector.<IMedical>();
			return _imedical;
		}
		public function set isES(value:Boolean):void{
			_ises = value;
		}
		public function get isES():Boolean{
			return _ises;
		}
		public function set absorption(value:int):void{
			_absorption = value;
		}
		public function get absorption():int{
			return _absorption;
		}
		
		public function set name(value:String):void{
			_name = value;
		}
		public function get name():String{
			return _name;
		}
		
		public function set id(value:String):void{
			_id = value;
		}
		public function get id():String
		{
			return _id;
		}
		
		public function set level(value:int):void{
			_level = value;
		}
		public function get level():int
		{
			return _level;
		}
		
		public function set rebound(value:Boolean):void{
			_rebound = value;
		}
		public function get rebound():Boolean{
			return _rebound;
		}
		
		public function set mRebound(value:Boolean):void{
			_mrebound = value;
		}
		public function get mRebound():Boolean{
			return _mrebound;
		}
		
		public function set negative(value:Boolean):void{
			_negative = value;
		}
		
		public function get negative():Boolean
		{
			return _negative;
		}
		
		public function set currTime(value:int):void
		{
			_currTime = value;
		}
		
		public function get currTime():int
		{
			return _currTime;
		}
		
		public function set addTime(value:int):void
		{
			_addTime = value;
		}
		
		public function get addTime():int
		{
			return _addTime;
		}
		
		public function set totalTime(value:int):void
		{
			_totalTime = value;
		}
		
		public function get totalTime():int
		{
			return _totalTime;
		}
		
		public function set gapTime(value:int):void
		{
			_gapTime = value;
		}
		
		public function get gapTime():int
		{
			return _gapTime;
		}
		
		public function execAbsorption($IRole:RoleProperty, $H:int = 0):void{
		}
		
		public function execRebound($Attacker:RoleProperty, $H:int = 0):void{
		}
		
		public function installProperty($IRole:RoleProperty):int
		{
			return 0;
		}
		
		public function unInstallProperty($IRole:RoleProperty):void
		{
		}
		
		public function dispose():void
		{
		}
	}
}