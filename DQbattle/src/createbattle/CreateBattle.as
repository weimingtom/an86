package createbattle
{
	import role.AbsRolePro;

	public class CreateBattle
	{
		public function CreateBattle()
		{
		}
		
		private function createBoss():AbsRolePro{
			var _role:AbsRolePro = new AbsRolePro();
			_role.strength = 100;
			_role.agility = 50;
			_role.attack = 50;
			_role.defense = 40;
			_role.hp = 390;
			return _role;
		}
		
		private function createProt():AbsRolePro{
			var _role:AbsRolePro = new AbsRolePro();
			_role.strength = 90;
			_role.agility = 40;
			_role.attack = 40;
			_role.defense = 30;
			_role.hp = 380;
			return _role;
		}
		
		private function get rnd():int{
			return Math.random()*100;
		}
		
		public function get bossBattle():RoundGroup{
			var group:RoundGroup = new RoundGroup();
			var boss:AbsRolePro = createBoss();
			var prot:AbsRolePro = createProt();
			trace("Boss hp:", boss.totalHP);
			trace("Prot hp:", prot.totalHP);
			var i:int;
			var first:Boolean = boss.agility < prot.agility;
			while(1){
				if(boss.totalHP <= 0 || prot.totalHP <= 0) break;
				var _item:RoundItem = new RoundItem();
				
				//who first att
				_item.who = first ? RoundConfig.ME : RoundConfig.EN;
				first = !first;
				
				//att type
				_item.type = rnd > 50 ? RoundConfig.SAT : RoundConfig.AT;
				
				var subhp:Number = 0;
				var isFlash:Boolean = false;
				
				//flash Calculate
				if(rnd <= Math.abs(boss.agility - prot.agility)){
					isFlash = true;
				}
				
				if(_item.who == RoundConfig.ME){//my att
					if(!isFlash){
						subhp = prot.totalAT - boss.totalDE;
						if(_item.type == RoundConfig.AT) subhp *= 2;
						boss.totalHP -= subhp;
						trace("boss --hp:", subhp, boss.totalHP);
						if(boss.totalHP <= 0) group.myWin = true;
					}
				}else{//enemy att
					if(!isFlash){
						subhp = boss.totalAT - prot.totalDE;
						if(_item.type == RoundConfig.AT) subhp *= 2;
						prot.totalHP -= subhp;
						trace("prot --hp:", subhp, prot.totalHP);
						if(prot.totalHP <= 0) group.myWin = false;
					}
				}
				
				if(isFlash){//is flash
					_item.type = RoundConfig.FLASH;
				}else{//not flash, Caught
					if(_item.type == RoundConfig.AT){
						_item.shp = subhp;//at subs hp
					}else{
						_item.shp = subhp;//skill at subs hp
					}
				}
				_item.id = i++;
				group.list.push(_item);
				
				trace(_item.toString());
			}
			trace("win:", group.myWin);
			return group;
		}
		
	}
}