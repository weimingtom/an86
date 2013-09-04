package anlei.util
{
	/**
	 * 翻页类
	 * @author Anlei
	 */	
	public class NBPage {
		
		private var _currPage:int = 1;
		/** 总页 */		
		public var totalPage:int = 1;
		
		public function NBPage(){
			
		}
		
		/** 上一页 */
		public function onBack():void{
			if(currPage > 1){
				currPage--;
			}else{
				currPage = 1;
				return;
			}
			//page_txt.text = currPage + ' / ' + totalPage;
		}
		/** 下一页 */
		public function onNext():void{
			if(currPage < totalPage){
				currPage++;
			}else{
				currPage = totalPage;
				return;
			}
			//page_txt.text = currPage + ' / ' + totalPage;
		}
		/**
		 * 最前一页； 
		 * @return 
		 * 
		 */
		public function onBackTotal():void{
			currPage = 1;
		}
		/**
		 * 最后一页 
		 * @return 
		 * 
		 */
		public function onNextTotal():void{
			currPage = totalPage;
		}
		/** 当前页 */
		public function get currPage():int {
			return _currPage;
		}

		public function set currPage(value:int):void {
			_currPage = value;
			if(_currPage < 1){
				_currPage = 1;
			}
			if(_currPage > totalPage){
				_currPage = totalPage;
			}
		}

		
	}
}