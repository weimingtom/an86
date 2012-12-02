package net.an86.tile.shop
{
	import net.an86.tile.ATGame;
	import net.an86.tile.ATSaveConfig;
	import net.an86.ui.alert.AlertDesction;
	import net.an86.ui.alert.AlertGold;
	import net.an86.ui.menu.ATMenu;
	
	public class ShopMenu extends ATMenu
	{
		public function ShopMenu($data:XML)
		{
			selecting = onSelecting;
			this.ITEM_CLASS = ShopMenuItemData;
			super($data);
			
		}
		
		private function onCancelFn():void {
			ATGame.keyCtrl.currentMenu = this;
		}
		
		private function onSelecting():void{
			var _s:String = this.selectedItem.data.desc;
			if(!_s) _s = 'null';
			AlertDesction.show(_s);
			AlertGold.showGold();
		}
		
		override public function A():void{
			//BuyManager.getInstance().buyMenu.okFn = onOkFn;
			BuyManager.getInstance().pop(this.x + this.width + 10);
			BuyManager.getInstance().buyMenu.itemData = this.selectedItem.data;
			BuyManager.getInstance().buyMenu.cancelFn = onCancelFn;
		}
		
		override public function B():void{
			super.B();
			AlertDesction.hide();
			AlertGold.hide();
		}
		
	}
}