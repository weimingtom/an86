package net.an86.ui.menu
{
	import anlei.util.NBPage;
	import anlei.util.PublicProperty;
	
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	
	import net.an86.tile.ATGame;
	import net.an86.ui.MyBitmapText;

	public class ATMenu extends Sprite implements IMenu
	{
		/**一页显示几条*/
		public static var LEN:int = 5;
		
		/**当前选中的Item的索引*/
		private var selectedIndex:int = 0;
		/**当前选中的Item*/
		protected var selectedItem:ATMenuItem;
		
		private var nbpage:NBPage;
		public var currPage:int = 1;
		
		/**按xml生成所有item*/
		private var list:Vector.<ATMenuItem> = new Vector.<ATMenuItem>();
		private var _data:XML;
		
		/**选中item所要的发光滤镜*/
		private var selectedFilter:Array;
		
		/**位图文本*/
		private var page_txt:MyBitmapText;
		
		/**是否要翻页文本*/
		private var _isPage:Boolean = true;
		
		/**每选中一个item就执行一次*/
		protected var selecting:Function;
		
		/**item样式*/
		protected var ITEM_CLASS:Class = null;
		
		public function ATMenu($data:XML)
		{
			nbpage = new NBPage();
			page_txt = new MyBitmapText();
			page_txt.border = true;
			page_txt.width = 90;
			page_txt.align = TextFieldAutoSize.CENTER;
			
			selectedFilter = [PublicProperty.OEffect(0xFF0000, true)];
			data = $data;
		}

		public function get data():XML { return _data; }
		public function set data(value:XML):void {
			_data = value;
			if(data){
				var _len:int = data.children().length();
				if(_len < LEN){
					LEN = _len;
				}
				nbpage.totalPage = Math.ceil(_len/LEN);
				if(nbpage.totalPage == 0) nbpage.totalPage = 1;
				for (var i:int = 0; i < _len; i++) 
				{
					var _tile:ATMenuItem = new ATMenuItem();
					if(ITEM_CLASS == null) ITEM_CLASS = ATMenuItemData;
					var _vo:ATMenuItemData = new ITEM_CLASS();
					_vo.id = data.children()[i].id;
					_vo.name = data.children()[i].name;
					_vo.price = data.children()[i].price;
					_vo.type = data.children()[i].type;
					_vo.data = data.children()[i].data;
					_vo.exec();
					
					if(data.children()[i].hasOwnProperty('data') && data.children()[i].data){
						_vo.data = data.children()[i].data;
					}
					_tile.data = _vo;
					list.push(_tile);
				}
				fill();
			}else{
				clear(true);
				list.splice(0, list.length);
			}
		}
		
		private function clear(isDispose:Boolean = false):void{
			if(list.length <= 0) return;
			for(var i:int = 0 ; i < list.length; i++){
				if(this.contains(list[i])){
					if(isDispose){
						list[i].dispose();
					}
					this.removeChild(list[i]);
				}
			}
		}

		private function fill():void{
			clear();
			if(list.length <= 0) return;
			selectedIndex = (nbpage.currPage - 1) * LEN;
			for(var i:int = selectedIndex, j:int = 0 ; i < nbpage.currPage * LEN + 1, j < LEN; i++, j++){
				if(i < list.length){
					this.addChild(list[i]);
					list[i].y = j * list[i].height;
				}
			}
			if(isPage){
				page_txt.text = nbpage.currPage + '/' + nbpage.totalPage;
				this.addChild(page_txt.fillBitmap());
				page_txt.bitmap.y = j * list[j].height;
			}
			setSelected();
		}
		
		private function nextPage(e:* = null):void{
			if(currPage == nbpage.totalPage) return;
			nbpage.onNext();
			fill();
			currPage = nbpage.currPage;
		}
		
		private function backPage(e:* = null):void{
			if(currPage == 1) return;
			nbpage.onBack();
			fill();
			currPage = nbpage.currPage;
		}
		
		private function setSelected():void{
			if(selectedItem != null){
				selectedItem.filters = null;
			}
			selectedItem = list[selectedIndex];
			selectedItem.filters = selectedFilter;
			if(selecting != null){
				selecting();
			}
		}
		
		public function left():void{
			backPage();
		}
		public function right():void{
			nextPage();
		}
		public function up():void{
			selectedIndex--;
			if(selectedIndex < LEN*currPage-LEN){
				selectedIndex = LEN*currPage-1;
			}
			if(selectedIndex > list.length){
				selectedIndex = list.length - 1;
			}
			setSelected();
		}
		public function down():void{
			selectedIndex++;
			if(selectedIndex >= LEN*currPage){
				selectedIndex = LEN*currPage-LEN;
			}
			if(selectedIndex >= list.length){
				selectedIndex = LEN*currPage-LEN;
			}
			setSelected();
		}
		
		public function A():void{
			
		}
		
		public function B():void{
			removePop();
		}
		
		public function pop():void{
			nbpage.currPage = 1;
			currPage = 1;
			fill();
			
			ATGame.root.addChild(this);
			x = ATGame.centery-width /2;
			y = ATGame.centery-height/2;
			ATGame.keyCtrl.currentMenu = this;
		}
		public function removePop():void{
			if(ATGame.root.contains(this)){
				ATGame.root.removeChild(this);
			}
			ATGame.keyCtrl.currentMenu = null;
		}

		/**是否显示页码*/
		public function get isPage():Boolean { return _isPage; }
		public function set isPage(value:Boolean):void {
			_isPage = value;
			
			if(isPage){
				this.addChild(page_txt.fillBitmap());
			}else{
				if(this.contains(page_txt.fillBitmap())){
					this.removeChild(page_txt.fillBitmap());
				}
			}
		}


	}
}