package net.an86.ui.menu
{
	import anlei.util.NBPage;
	import anlei.util.PublicProperty;
	
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextFieldAutoSize;
	
	import net.an86.tile.ATGame;
	import net.an86.tile.ATSaveConfig;
	import net.an86.ui.MyBitmapText;

	public class ATMenu extends Sprite implements IMenu
	{
		/**选中item所要的发光滤镜*/
		public static const selectedFilter:Array = [new GlowFilter(0xFF6600, 1, 2, 2, 10, 1, true), new GlowFilter(0xFF0000, 1, 10, 10, 2)];
		
		private static const OFFXY:int = 10;
		
		private static const INIT_LEN:int = 5;
		/**一页显示几条*/
		private var LEN:int = INIT_LEN;
		
		private var _selectedIndex:int = 0;
		/**当前选中的Item*/
		protected var selectedItem:ATMenuItem;
		
		public var nbpage:NBPage;
		public var currPage:int = 1;
		
		/**按xml生成所有item*/
		private var list:Vector.<ATMenuItem> = new Vector.<ATMenuItem>();
		private var _data:XML;
		
		/**位图文本*/
		private var page_txt:MyBitmapText;
		
		/**是否要翻页文本*/
		private var _isPage:Boolean = true;
		
		/**每选中一个item就执行一次*/
		protected var selecting:Function;
		
		/**item样式*/
		protected var ITEM_CLASS:Class = null;
		
		/**按确定(A)时所执行的方法*/
		public var okFn:Function = null;
		/**按取消(B)时所执行的方法*/
		public var cancelFn:Function = null;
		
		public function ATMenu($data:XML = null)
		{
			nbpage = new NBPage();
			page_txt = new MyBitmapText();
			//page_txt.border = true;
			page_txt.width = 90;
			page_txt.align = TextFieldAutoSize.CENTER;
			
			if($data) data = $data;
			
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
					//_vo.data = data.children()[i].data;
					if(data.children()[i].hasOwnProperty('data') && data.children()[i].data){
						_vo.data = data.children()[i].data;
					}
					_vo.exec();
					
					_tile.data = _vo;
					list.push(_tile);
				}
				fill();
			}else{
				clear();
			}
		}
		
		private function clear():void{
			LEN = INIT_LEN;
			clearView(true);
			list.splice(0, list.length);
		}
		
		private function clearView(isDispose:Boolean = false):void{
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

		private function flushFill():int{
			clearView();
			for(var i:int = selectedIndex, j:int = 0 ; i < nbpage.currPage * LEN + 1, j < LEN; i++, j++){
				if(i < list.length){
					this.addChild(list[i]);
					list[i].x = OFFXY;
					list[i].y = j * (list[i].height + 3) + OFFXY;
				}else{
					break;
				}
			}
			return j;
		}
		
		public function fill($si:int = -1):void{
			if(list.length <= 0) return;
			if($si == -1){
				selectedIndex = (nbpage.currPage - 1) * LEN;
			}else{
				selectedIndex = $si;
			}
			var j:int = flushFill();
			if(isPage){
				page_txt.text = nbpage.currPage + '/' + nbpage.totalPage;
				this.addChild(page_txt.fillBitmap());
				page_txt.bitmap.x = OFFXY;
				page_txt.bitmap.y = j * (list[0].height + 3) + OFFXY;
			}
			
			graphics.clear();
			graphics.beginFill(0x0, 0.5);
			graphics.drawRect(0, 0, page_txt.width + OFFXY*2, this.height + OFFXY*2);
			graphics.endFill();
			
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
		
		public function setSelected():void{
			if(selectedItem != null){
				selectedItem.filters = null;
			}
			var _index:int = 0;
			if(selectedIndex < list.length) {
				_index = selectedIndex;
			}else{
				_index = selectedIndex = LEN-1;
			}
			selectedItem = list[_index];
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
		private function up_fn():void{
			selectedIndex--;
			trace(selectedIndex);
			if(selectedIndex < LEN*currPage-LEN){
				selectedIndex = LEN*currPage-1;
			}
			if(selectedIndex > list.length){
				selectedIndex = list.length - 1;
			}
		}
		public function up():void{
			up_fn();
			setSelected();
		}
		private function down_fn():void{
			selectedIndex++;
			trace(selectedIndex);
			if(selectedIndex >= LEN*currPage){
				selectedIndex = LEN*currPage-LEN;
			}
			if(selectedIndex >= list.length){
				selectedIndex = LEN*currPage-LEN;
			}
		}
		public function down():void{
			down_fn();
			setSelected();
		}
		
		public function A():void{
			
		}
		
		public function B():void{
			removePop();
			if(cancelFn != null) cancelFn();
		}
		
		public function pop():void{
			nbpage.currPage = 1;
			currPage = 1;
			fill();
			
			ATGame.root.addChild(this);
			x = ATGame.centerx-width/2;
			y = ATGame.centery-height/2 - OFFXY;
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

		public function setDataList(value:Vector.<ATMenuItemData>):void {
			clear();
			if(value){
				var _len:int = value.length;
				if(_len < LEN){
					LEN = _len;
				}
				nbpage.totalPage = Math.ceil(_len/LEN);
				if(nbpage.totalPage == 0) nbpage.totalPage = 1;
				for (var i:int = 0; i < _len; i++) 
				{
					var _tile:ATMenuItem = new ATMenuItem();
					var _vo:ATMenuItemData = value[i];
					_vo.exec();
					_tile.data = _vo;
					list.push(_tile);
				}
				fill();
			}
		}

		public function del($index:int, $isPop:Boolean):void{
			var _cp:int = nbpage.currPage;
			var _sdd:int = selectedIndex;
			ATSaveConfig.bagItemList.splice($index, 1);
			if($isPop) pop();
			nbpage.currPage = currPage = _cp;
			if(nbpage.currPage != _cp){
				pop();
			}
			selectedIndex = _sdd;
			setSelected();
		}
		
		/**当前选中的Item的索引*/
		public function get selectedIndex():int { return _selectedIndex; }
		public function set selectedIndex(value:int):void {
			_selectedIndex = value;
		}


	}
}