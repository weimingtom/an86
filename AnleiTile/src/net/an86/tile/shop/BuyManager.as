package net.an86.tile.shop
{
	public class BuyManager
	{
		private static var _instance:BuyManager;
		public function BuyManager(signle:Signle) { inits(); }
		public static function getInstance():BuyManager {
			if (_instance == null)
				_instance = new BuyManager(new Signle());
			return _instance;
		}
		
		public var buyMenu:BuyMenu;
		
		private function inits():void {
			
		}
		
		public function pop(x:int = -1, y:int = -1):void{
			if(buyMenu == null){
				buyMenu = new BuyMenu();
			}
			buyMenu.pop();
			if(x != -1) buyMenu.x = x;
			if(y != -1) buyMenu.y = y;
			
		}
		
		
	}
}
class Signle{}
