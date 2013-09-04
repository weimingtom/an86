package anlei.buffmodel.utils
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import anlei.buffmodel.BuffModel;
	
	import ui.component.MyTimer;

	/**
	 * 主角、怪、障碍物的数据
	 * @author Anlei
	 * @version 1.0
	 * @created 06-五月-2011 16:35:57
	 */
	public class RoleProperty
	{
		public static const X:Number = 0.06;
		
		public var name:String;
		
		public var buff:BuffModel;
		/**每秒恢复定时器*/
		private var _timer:MyTimer;
		
		/**最大机率（0-100之间）*/
		public var MAX_RATE:int = 100;
		/**加成系数基础值*/
		private static const ABS_COE:Number = 1;
		
		/**主动技能产生的buff状态列表*/
		public var buffList:Dictionary = new Dictionary();
		/**我方还是敌方*/
		public var isME:Boolean = true;
	    /**无敌*/
	    public var invincible: Boolean = false;
		/**魔免*/
		public var mInvincible: Boolean = false;
		
		
	    /**0-100(N)基础爆击率*/
		public var critRate: Number = 1;
		/**爆击率百分比值*/
		public var critRate_R: Number = 1;
		/**爆击率临时值*/
		public var critRate_A: Number = 1;
		/**当前攻击是否有爆击*/
		public var isCritRate:Boolean = false;
		
	    /**0-100(N)基础闪避率*/
		public var dodgeRate: Number = 1;
		/**闪避率百分比值*/
		public var dodgeRate_R: Number = 1;
		/**闪避率临时值*/
		public var dodgeRate_A: Number = 1;
		/**当前被击是否有避率*/
		public var isDodgeRate:Boolean = false;
		
		
		/**吸血百分比*/
		public var vampire:int = 0;
		
		/**是否挂了*/
		public var isDie:Boolean = false;
		
		private var _moveSetp:int = 4;
		/**最大移动格子数*/
		public var MaxMoveSetp:int = 4;
		
		/**攻击格子数*/
		public var attackSetp:int = 3;
		/**最大攻击格子数*/
		public var MaxAttackSetp:int = 3;
		
		/**免伤*/
		public var smh:Number = 0;
		
		/**每秒可回复多少HP*/
		public var replyHp:Number = 1;
		/**每秒可回复多少HP的系数*/
		private var _replyHp_COE:Number = ABS_COE;
		/**附加生命恢复速度*/
		public var replyHp_ADD:Number = 0;
		/**兵的血量扣除系数*/
		public var hpCoe:Number;
		
		/**每秒可回复多少TP*/
		public var replyTp:Number = 1;
		/**每秒可回复多少TP的系数*/
		private var _replyTp_COE:Number = ABS_COE;
		/**附加魔法恢复速度*/
		public var replyTp_ADD:Number = 0;
		
		/**增加n%的带兵上限*/
		public var addSoldierCount:int = 0;
		public var addSoldierCountK:Number = 0;
		/**英雄获得经验增加10%*/
		public var addExpK:Number = 0;
		
		
		public var addhp:Number;
		public var addap:Number;
		public var adddp:Number;
		
		
	    private var _level:int = 1;
		private var _exp:int = 0;
		
		private var _force:Number = 1;
		private var _agile:Number = 1;
		private var _intell:Number= 1;
		
		private var _forceE:Number = 0;
		private var _agileE:Number = 0;
		private var _intellE:Number = 0;
		
		private var _ap:Number = 0;
		private var _ap_coe:Number = ABS_COE;
//		private var _ap_add:Number = 0;
		private var _maxap:Number = 1;
		private var _dp:Number = 1;
		private var _dp_coe:Number = ABS_COE;
		private var _dp_add:Number = 0;
		private var _maxdp:Number = 1;
		
		private var _ap_b:Number = 1;
		private var _ap_n:Number = 0;
		private var _difDP:Number = 2;
		
		private var _map:Number = 1;
		private var _maxmap:Number = 1;
		private var _mdp:Number = 1;
		private var _maxmdp:Number = 1;
		
		private var _movesp:Number = 10;
		private var _maxmovesp:Number = 10;
		
		private var _asp:Number = 10;
		private var _maxasp:Number = 10;
		
		
	    private var _hp:Number = 100;
	    private var _maxhp:Number = 200;
	    private var _tp:Number = 15;
	    private var _maxtp:Number = 100;
		
		
		private var _isMove:Boolean = true;
		private var _isReleaseMac:Boolean = true;
		private var _isAttack:Boolean = true;
		
		
		/**角色皮肤*/
		private var skin:Sprite;
		/**安装特效容器*/		
		public var roleEffect_containe:Sprite;
		
		
		public function RoleProperty($skin:Sprite = null){
			setSkin($skin);
		}
		
		public function setSkin($skin:Sprite):void{
			skin = $skin;
			if(skin){
				roleEffect_containe = skin.getChildByName('effect_mc') as Sprite;
				if(roleEffect_containe == null){
					roleEffect_containe = new Sprite();
					roleEffect_containe.name = 'effect_mc';
					skin.addChildAt(roleEffect_containe, 0);
				}
			}
			_timer = new MyTimer(1000);
			_timer.addEventListener(MyTimer.TIMER, onTimer);
			_timer.start();
		}

		public function dispose():void{
			_timer.removeEventListener(MyTimer.TIMER, onTimer);
			_timer.stop();
			_timer = null;
			
			skin = null;
			roleEffect_containe = null;
			
			
			changeState = null;
			
			byTheDodge = null;
			thisDie = null;
			changeHP = null;
			changeMP = null;
		}
		
		private function onTimer(event:Event):void{
			if(HP < MaxHP) _hp += (replyHp * REPLYHP_COE + replyHp_ADD);
			if(TP < MaxTP) TP += (replyTp * REPLYTP_COE + replyTp_ADD);
			replyTimeHP();
//			if(changeHP!=null)changeHP(HP, MaxHP);
//			if(changeMP!=null)changeMP(TP, MaxTP);
		}
		
		private function recoe(value:Number):Number{
			value < ABS_COE && (value = ABS_COE);
			return value;
		}
		
		/**总物攻值*/
		public function getTotalAP():Number{
			//本身物理攻击+附加物理攻击
			var _subbn:Number = Math.round(AP + (AP_B + Math.random() * AP_N));
			//加成系数
			_subbn *= AP_COE;
			return _subbn;
		}
		
		/**最大物理防御值*/
		public function getTotalDP():Number{
			//本身物理防+附加物理防 * 加成系数
			return  DP * AP_COE;
		}
		
		/**物攻*/
		public function set AP(value:Number): void{ _ap = value; }
		public function get AP(): Number{ return _ap; }
		
		/**物攻普通攻击下限*/
		public function set AP_B(value:Number): void{ _ap_b = value; }
		public function get AP_B():Number { return _ap_b;}
		
		/**物攻普通攻击上限*/
		public function set AP_N(value:Number): void{ _ap_n = value; }
		public function get AP_N():Number { return _ap_n;}
		
		/**最大物攻*/
		public function set MaxAP(value:Number): void{ _maxap = value; }
		public function get MaxAP(): Number{ return _maxap; }
		
		/**附加物理攻击值*/
		public function get AP_ADD():Number{return Math.random() * AP_B + AP_N;}
		//public function set AP_ADD(value:Number):void{_ap_add = value;}
		
		/**物理攻击加成系数*/
		public function get AP_COE():Number{return _ap_coe;}
		public function set AP_COE(value:Number):void{
			_ap_coe = value;
			_ap_coe  = recoe(_ap_coe);
		}
		
		/**原始英雄攻击力数值*/
			private var _skillAddAP:Number = 0;
			/**技能加成的攻击*/
			public function set skillAddAP(value:Number): void{ _skillAddAP = value; }
			public function get skillAddAP():Number{ return _skillAddAP; }
			
			private var _stateAddAP:Number = 0;
			/**状态加成的攻击*/
			public function set stateAddAP(value:Number): void{ _stateAddAP = value; }
			public function get stateAddAP():Number{ return _stateAddAP; }
			
			private var _equipAddAP:Number = 0;
			/**装备攻击力*/
			public function set equipAddAP(value:Number): void{ _equipAddAP = value; }
			public function get equipAddAP():Number{ return _equipAddAP; }
			
			private var _tempdAddAP:Number = 0;
			/**临时攻击力*/
			public function set tempdAddAP(value:Number): void{ _tempdAddAP = value; }
			public function get tempdAddAP():Number{ return _tempdAddAP; }
	
			
		/**原始英雄防御力数值*/
			private var _skillAddDP:Number = 0;
			/**技能加成的防御力*/
			public function set skillAddDP(value:Number): void{ _skillAddDP = value; }
			public function get skillAddDP():Number{ return _skillAddDP; }
			
			private var _stateAddDP:Number = 0;
			/**状态加成的防御力*/
			public function set stateAddDP(value:Number): void{ _stateAddDP = value; }
			public function get stateAddDP():Number{ return _stateAddDP; }
			
			private var _equipAddDP:Number = 0;
			/**装备的防御力*/
			public function set equipAddDP(value:Number): void{ _equipAddDP = value; }
			public function get equipAddDP():Number{ return _equipAddDP; }
			
			private var _tempdAddDP:Number = 0;
			/**临时的防御力*/
			public function set tempdAddDP(value:Number): void{ _tempdAddDP = value; }
			public function get tempdAddDP():Number{ return _tempdAddDP; }
			
			
		
		
		
		
		
		
		/**物防的加成偏移*/
		public function set difDP(value:Number): void{ _difDP = value; }
		public function get difDP():Number{ return _difDP; }
		
		/**物防*/
		public function set DP(value:Number): void{ _dp = value; }
		public function get DP(): Number{ return _dp; }
		
		/**最大物防*/
		public function set MaxDP(value:Number): void{ _maxdp = value; }
		public function get MaxDP(): Number{ return _maxdp; }
		
		/**附加物理防御值*/		
		public function get DP_ADD():Number{return _dp_add;}
		public function set DP_ADD(value:Number):void{_dp_add = value;}
		
		/**物理防御加成系数*/
		public function get DP_COE():Number{return _dp_coe;}
		public function set DP_COE(value:Number):void{
			_dp_coe = value;
			_dp_coe  = recoe(_dp_coe);
		}
		
		/**魔攻*/
		public function set MAP(value:Number): void{ _map = value; }
		public function get MAP(): Number{ return _map; }
		
		/**最大魔攻*/
		public function set MaxMAP(value:Number): void{ _maxmap = value; }
		public function get MaxMAP(): Number{ return _maxmap; }
		
		/**魔防*/
		public function set MDP(value:Number): void{ _mdp = value;  }
		public function get MDP(): Number{ return _mdp; }
		
		/**最大魔防*/
		public function set MaxMDP(value:Number): void{ _maxmdp = value;  }
		public function get MaxMDP(): Number{ return _maxmdp; }
		
		/**魔法恢复加成系数*/
		public function get REPLYTP_COE():Number{return _replyTp_COE;}

		public function set REPLYTP_COE(value:Number):void{
			_replyTp_COE = value;
			_replyTp_COE  = recoe(_replyTp_COE);
		}

		/**生命恢复加成系数*/
		public function get REPLYHP_COE():Number{
			return _replyHp_COE;
		}

		public function set REPLYHP_COE(value:Number):void{
			_replyHp_COE = value;
			_replyHp_COE  = recoe(_replyHp_COE);
		}

		/**移动格子数*/
		public function get MoveSetp():int{return _moveSetp;}

		public function set MoveSetp(value:int):void{
			if(_moveSetp < 1) _moveSetp = 1;
			_moveSetp = value;
		}

		/**角色等级*/
		public function set LEVEL(value:int): void{ _level = value; }
		public function get LEVEL(): int{ return _level; }
		
		/**角色经验*/
		public function set EXP(value:int): void{ _exp = value; }
		public function get EXP(): int{ return _exp; }
		
		
		/**力量*/
		public function set FORCE(value:Number):void{ _force = value; }
		public function get FORCE():Number{ return _force + FORCE_E; }
		
		/**敏捷*/
		public function set AGILE(value:Number):void{ _agile = value; }
		public function get AGILE():Number{ return _agile + AGILE_E; }
		
		/**智力*/
		public function set INTELL(value:Number):void{ _intell = value; }
		public function get INTELL():Number{ return _intell + INTELL_E; }
		
		
		/**额外力量*/
		public function set FORCE_E(value:Number):void{ _forceE = value; }
		public function get FORCE_E():Number{ return _forceE; }
		
		/**额外敏捷*/
		public function set AGILE_E(value:Number):void{ _agileE = value; }
		public function get AGILE_E():Number{ return _agileE; }
		
		/**额外智力*/
		public function set INTELL_E(value:Number):void{ _intellE = value; }
		public function get INTELL_E():Number{ return _intellE; }
		
		private function replyTimeHP():void{
			if(_hp <= 0){
				_hp = 0;
//				isDie = true;
				_timer.stop();
				thisDie && thisDie();
			}else{
//				isDie=false;
				if(_hp > MaxHP){
					_hp = MaxHP;
				}
				!_timer.running && _timer.start();
			}
			if(changeHP!=null){
				changeHP(HP, MaxHP);
			}
		}
		
		/**血*/
		public function set HP(value:Number): void{
			if(int(_hp) > int(value)){
				displayChangeHP && displayChangeHP(-(_hp - value), this.isCritRate);
			}else if(int(value) > int(_hp)){
				displayChangeHP && displayChangeHP(value - _hp, false);
			}
			_hp = value;
			replyTimeHP();
		}
		
		public function get HP(): Number{ if(_hp.toString() == "NaN"){_hp=0;} return _hp; }
		
	    /**最大血*/
	    public function set MaxHP(value:Number): void{ _maxhp = value; }
		public function get MaxHP(): Number{ return _maxhp; }
		
		/**魔*/
		public function set TP(value:Number): void{
			_tp = value;
			if(_tp <= 0){
				_tp = 0;
			}else{
				if(_tp > MaxTP){
					_tp = MaxTP;
				}
			}
			if(changeMP!=null){
				changeMP(TP, MaxTP);
			}
		}
		public function get TP(): Number{ return _tp; }
		
		/**最大魔 */
		public function set MaxTP(value:Number): void{ _maxtp = value; }
	    public function get MaxTP(): Number{ return _maxtp; }
		
		/**移动速*/
		public function set MoveSP(value:Number): void{ _movesp = value; }
		public function get MoveSP(): Number{ return _movesp; }
		
		/**最大移动速*/
		public function set MaxMoveSP(value:Number): void{ _maxmovesp = value; }
		public function get MaxMoveSP(): Number{ return _maxmovesp; }
		
		/**攻击速*/
		public function set ASP(value:Number): void{ _asp = value; }
		public function get ASP(): Number{ return _asp; }
		
		/**最大攻击速*/
		public function set MaxASP(value:Number): void{ _maxasp = value; }
		public function get MaxASP(): Number{ return _maxasp; }
		
		
		
		/***--------------------------------------******/
		
		
		
		/**是否可移动*/
		public function set isMove(value:Boolean):void{ _isMove = value; }
		public function get isMove():Boolean{ return _isMove; }
		
		/**是否可物攻*/
		public function set isAttack(value:Boolean):void{ _isAttack = value; }
		public function get isAttack():Boolean{ return _isAttack; }
		
		/**是否可以释放魔法*/
		public function set isReleaseMac(value:Boolean):void{ _isReleaseMac = value; }
		public function get isReleaseMac():Boolean{ return _isReleaseMac; }
		
		/**沉默（如晕眩），所有操作不可执行*/
		public function isSilence(value:Boolean):void{
			isMove = value;
			isReleaseMac = value;
			isAttack = value;
		}
		
		/**当前攻式是否触发爆击*/
		public function comCritRate():Boolean{
			isCritRate = false;
			if(critRate <= 0){
				isCritRate = false;
				return isCritRate;
			}
			isCritRate = int(Math.random() * MAX_RATE) <= critRate ? true : false;
			return isCritRate;
		}
		/**当前攻式是否被闪避了*/
		public function comDodgeRate():Boolean{
			isDodgeRate = false;
			if(dodgeRate <= 0){
				isDodgeRate = false;
				return isDodgeRate;
			}
			isDodgeRate = int(Math.random() * MAX_RATE) <= dodgeRate ? true : false;
			return isDodgeRate;
		}

	    /**添加效果*/
	    public function addEffect(mc:DisplayObject): RoleProperty{
			roleEffect_containe.addChild(mc);
			return this;
	    }
		
		/**移除效果*/		
		public function removeEffect(mc:DisplayObject):RoleProperty{
			if(mc != null && roleEffect_containe.contains(mc))
				roleEffect_containe.removeChild(mc);
			return this;
		}

		/**有状态发生改变了*/
		public var changeState:Function = function():void{ trace(name+'有状态发生改变了!', isMove, isAttack, isReleaseMac); }
		
		/**被对方闪避了（MISS提示）*/
		public var byTheDodge:Function = function():void{ trace(name+": Miss"); }
		
		/**血小于1后马上死*/
		public var thisDie:Function = function():void{ trace(name+": Die"); };
		/**改变HP时*/
		public var changeHP:Function = null;
		/**改变TP时*/
		public var changeMP:Function = null;
		/**主属性发生变化时*/
		public var changeMainProperty:Function = null;
		/**显示伤害数值*/
		public var displayChangeHP:Function = null;
	}
}