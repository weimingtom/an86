package net.an86.tile.bag
{
	import net.an86.tile.ATSaveConfig;
	import net.an86.ui.alert.Alert;
	import net.an86.ui.alert.AlertGold;
	import net.an86.ui.menu.ATMenu;
	import net.an86.ui.menu.ATMenuItemData;

	public class BagPriceMenu extends ATMenu
	{
		private var buyXML:XML = <menu>
						<item>
							<id>1</id>
							<name>出售</name>
							<price>0</price>
							<type></type>
						</item>
						<item>
							<id>2</id>
							<name>装备</name>
							<price>0</price>
							<type></type>
						</item>
						<item>
							<id>3</id>
							<name>取消</name>
							<price>0</price>
							<type></type>
						</item>
					</menu>;
		
		public var itemData:ATMenuItemData;
		
		public function BagPriceMenu()
		{
			super(buyXML);
			isPage = false;
		}
		
		override public function A():void{
			switch(this.selectedItem.data.id){
				case 1:
					if(this.itemData.price <= 0){
						Alert.show('这个物品不能卖!', true);
					}
					var _index:int = ATSaveConfig.indexOf_bag(this.itemData.id);
					if(_index != -1){
						var _cp:int = BagManager.getInstance().nbpage.currPage;
						var _sdd:int = BagManager.getInstance().selectedIndex;
						ATSaveConfig.bagItemList.splice(_index, 1);
						BagManager.getInstance().pop();
						BagManager.getInstance().nbpage.currPage = BagManager.getInstance().currPage = _cp;
						//BagManager.getInstance().fill();
						BagManager.getInstance().selectedIndex = _sdd;
						BagManager.getInstance().setSelected();
						///////////
						ATSaveConfig.glod += this.selectedItem.data.price;
						if(ATSaveConfig.bagItemList.length <= 0){
							this.B();
							BagManager.getInstance().B();
							break;
						}else{
							AlertGold.showGold();
							Alert.show('出售成功!', true);
						}
					}
					this.B();
					break;
				case 3:
					this.B();
					break;
			}
		}
		
	}
}