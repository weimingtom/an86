package role
{
	public class AbsRolePro
	{
		public var strength:Number;
		public var agility:Number;
		public var attack:Number;
		public var defense:Number;
		public var hp:Number;
		private var _hp:Number = -1;
		
		
		public function AbsRolePro()
		{
		}
		
		public function get totalAT():Number{
			return strength + attack;
		}
		
		public function get totalDE():Number{
			return agility + defense;
		}
		
		private var _fir:Boolean = true;
		private function _getHP():void{
			if(_fir){
				_fir = false;
				_hp = strength + hp;
			}
		}
		
		public function set totalHP(value:Number):void {
			_getHP();
			_hp = value;
		}
		
		public function get totalHP():Number{
			_getHP();
			return _hp;
		}
		
		
	}
}