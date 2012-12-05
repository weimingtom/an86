package net.an86.battle
{
	public class BattleManager
	{
		private static var _instance:BattleManager;
		public function BattleManager(signle:Signle) { inits(); }
		public static function getInstance():BattleManager {
			if (_instance == null)
				_instance = new BattleManager(new Signle());
			return _instance;
		}
		
		///////////////////////////////
		
		private function inits():void {
			
		}
		
		public function pop(monsterId:int):void{
			
		}
		
	}
}
class Signle{}
