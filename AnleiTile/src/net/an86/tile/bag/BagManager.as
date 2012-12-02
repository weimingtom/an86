package net.an86.tile.bag
{
	import net.an86.tile.ATGame;
	import net.an86.tile.ATSaveConfig;
	import net.an86.ui.alert.Alert;
	import net.an86.ui.alert.AlertDesction;
	import net.an86.ui.alert.AlertGold;
	import net.an86.ui.menu.ATMenu;

	public class BagManager extends ATMenu
	{
		private var _isPop:Boolean = false;
		
		private static var _instance:BagManager;
		public function BagManager(signle:Signle) { inits(); }
		public static function getInstance():BagManager {
			if (_instance == null)
				_instance = new BagManager(new Signle());
			return _instance;
		}
		
		////////////////////////
		
		private var priceMenu:BagPriceMenu;
		
		private function inits():void {
			selecting = onSelecting;
			
		}
		
		private function onSelecting():void{
			var _s:String = this.selectedItem.data.desc;
			if(!_s) _s = 'null';
			AlertDesction.show(_s);
		}
		
		override public function pop():void{
			ATGame.roleList[0].isCtrl = false;
			if(!ATSaveConfig.bagItemList || ATSaveConfig.bagItemList.length <= 0){
				Alert.show("你的背包空无一物!");
				return;
			}else{
				setDataList(ATSaveConfig.bagItemList);
			}
			if(_isPop == false){
				super.pop();
				AlertGold.showGold();
			}else{
				super.removePop();
			}
		}
		
		private function onCancelFn():void {
			ATGame.keyCtrl.currentMenu = this;
		}
		
		override public function removePop():void{
			super.removePop();
			ATGame.roleList[0].isCtrl = true;
			ATGame.keyCtrl.currentMenu = null;
		}
		
		override public function A():void{
			if(priceMenu == null){
				priceMenu = new BagPriceMenu();
				priceMenu.cancelFn = onCancelFn;
			}
			priceMenu.pop();
			priceMenu.itemData = this.selectedItem.data;
			priceMenu.x = x + width + 10;
			ATGame.keyCtrl.currentMenu = priceMenu;
		}
		
		override public function B():void{
			super.B();
			priceMenu.B();
			AlertDesction.hide();
			AlertGold.hide();
			ATGame.keyCtrl.currentMenu = null;
		}
		
	}
}
class Signle{}