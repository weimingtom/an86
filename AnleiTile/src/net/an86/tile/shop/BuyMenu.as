package net.an86.tile.shop
{
	import net.an86.tile.ATSaveConfig;
	import net.an86.ui.alert.Alert;
	import net.an86.ui.alert.AlertGold;
	import net.an86.ui.menu.ATMenu;
	import net.an86.ui.menu.ATMenuItemData;
	
	public class BuyMenu extends ATMenu
	{
		private var buyXML:XML = <menu>
						<item>
							<id>1</id>
							<name>购买</name>
							<price>0</price>
							<type></type>
						</item>
						<item>
							<id>2</id>
							<name>取消</name>
							<price>0</price>
							<type></type>
						</item>
					</menu>;
		public var itemData:ATMenuItemData;
		
		public function BuyMenu()
		{
			super(buyXML);
			isPage = false;
		}
		
		override public function A():void{
			switch(this.selectedItem.data.id){
				case 1:
					/*if(this.itemData.price <= 0){
						Alert.show('金钱不够!', true);
					}*/
					if(ATSaveConfig.glod < this.itemData.price){
						Alert.show('金钱不够!', true);
					}
					if(ATSaveConfig.bagItemList.length >= ATSaveConfig.BAG_LEN){
						Alert.show('背包已满!', true);
					}
					if(ATSaveConfig.glod >= this.itemData.price
						&& ATSaveConfig.bagItemList.length < ATSaveConfig.BAG_LEN
					){
						this.itemData.id = ATSaveConfig.getAddID();
						ATSaveConfig.glod -= this.itemData.price;
						ATSaveConfig.bagItemList.push(itemData);
						AlertGold.showGold();
						Alert.show('购买成功!', true);
					}
				case 2:
					this.B();
					break;
			}
		}
		
	}
}