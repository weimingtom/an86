package anlei.loading.utils
{
	import anlei.loading.AnleiLoader;
	import anlei.loading.node.LoaderItemes;

	public class ALoaderUtil
	{
		private static const file_arr:Array = ['swf', 'png', 'jpg', 'gif'];
		
		public static function isLoader(url:String):Boolean {
			var _arr:Array = url.split(".");
			var _len:int = file_arr.length;
			for (var i:int = 0; i < _len; i++) {
				if(_arr[_arr.length-1] == file_arr[i]){
					return true;
				}
			}
			return false; 
		}
		
		/**去除重复*/
		public static function trimReItem(list:Vector.<LoaderItemes>):void {
			var _len:int = list.length;
			for (var i:int = 0; i < _len; i++) {
				for (var j:int = 0; j < _len; j++) {
					if(i != j){
						if(list[i].url == list[j].url){
							list[i] = null;
						}
					}
				}
			}
			trimReItem_delNull(list);
		}
		
		/**去除与池中相同的文件*/
		public static function trimPoolItem(list:Vector.<LoaderItemes>):void{
			var poolList:Vector.<LoaderItemes> = AnleiLoader.getInstance().poolList;
			if(!poolList) return;
			var i_len:int = list.length;
			var j_len:int = poolList.length;
			for (var i:int = 0; i < i_len; i++) {
				for (var j:int = 0; j < j_len; j++) {
					if(list[i] && list[i].url == poolList[j].url){
						list[i] = null;
					}
				}
			}
			trimReItem_delNull(list);
		}
		
		/**删除列表中有null的项*/
		private static function trimReItem_delNull(list:Vector.<LoaderItemes>):void{
			var _len:int = list.length;
			for (var i:int = 0; i < _len; i++) {
				if(list[i] == null){
					list.splice(i, 1);
					trimReItem_delNull(list);
					return;
				}
			}
		}
		//////////////////////////////////////////////////////
		
		/**创建一个要加载的列表
		 * @param array		[[路径, key, 描述],[路径, key, 描述],[路径, key, 描述]]
		 */
		public static function c(array:Array):Vector.<LoaderItemes>{
			if(!array || array.length <= 0) return null;
			var _list:Vector.<LoaderItemes> = new Vector.<LoaderItemes>();
			for (var i:int = 0; i < array.length; i++) 
			{
				var _url:String = array[i][0];
				var _key:String = array[i][1];
				var _des:String = '';
				var _isb:Boolean = false;
				if(array[i].length > 2) _des = array[i][2];
				if(array[i].length > 3) _isb = array[i][3];
				var vo:LoaderItemes = new LoaderItemes(_url, _key, _des, _isb);
				_list.push(vo);
			}
			return _list;
		}
		
		
	}
}