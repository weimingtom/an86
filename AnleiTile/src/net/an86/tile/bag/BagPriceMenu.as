package net.an86.tile.bag
{
	import net.an86.tile.ATGame;
	import net.an86.tile.ATSaveConfig;
	import net.an86.tile.shop.ShopMenuItemData;
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
			var _index:int;
			switch(this.selectedItem.data.id){
				case 1:
					if(this.itemData.price <= 0){
						Alert.show('这个物品不能卖!', true);
					}
					_index = ATSaveConfig.indexOf_bag(this.itemData.id);
					if(_index != -1){
						BagManager.getInstance().del(_index, true);
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
				case 2:
					///暂不弹出英雄列表，只有一个英雄
					if(this.itemData.type_type == ShopMenuItemData.TYPE_TYPE_ZB){
						var _item:ATMenuItemData;
						switch(this.itemData.type_desc){
							case ShopMenuItemData.TYPE_DESC_AT:
								_item = ATGame.roleList[0].roleData.equip_at.clone(_item);
								ATGame.roleList[0].roleData.equip_at = this.itemData;
								break;
							case ShopMenuItemData.TYPE_DESC_DP:
								_item = ATGame.roleList[0].roleData.equip_dp.clone(_item);
								ATGame.roleList[0].roleData.equip_dp = this.itemData;
								break;
							case ShopMenuItemData.TYPE_DESC_AHP:
								_item = ATGame.roleList[0].roleData.equip_ahp.clone(_item);
								ATGame.roleList[0].roleData.equip_ahp = this.itemData;
								break;
						}
						_index = ATSaveConfig.indexOf_bag(this.itemData.id);
						if(_index != -1){
							BagManager.getInstance().del(_index, false);
						}
						if(_item.data){
							BagManager.getInstance().add(_item, false);
							Alert.show('卸下<font color="#9966CC">['+_item.name+']</font>,装备<font color="#FF6600">['+itemData.name+']</font>', true);
						}else{
							Alert.show('装备<font color="#FF6600">['+itemData.name+']</font>', true);
						}
						
						BagManager.getInstance().pop();
					}else{
						Alert.show('这个物品不是装备!', true);
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