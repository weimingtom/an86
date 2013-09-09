package anlei.loading.node
{
	import anlei.loading.utils.ALoaderUtil;

	public class LoaderItemes
	{
		/**将 SWF、JPEG、渐进式 JPEG、非动画 GIF 或 PNG 文件加载到此 Loader 对象的子对象中。*/
		public static const SWF_TYPE:int = 1;
		/**文本类型*/
		public static const TXT_TYPE:int = 2;
		
		/**文件扩展名类型*/
		public var type:int;
		
		/**路径*/
		public var url:String;
		/**取资源用*/
		public var key:String;
		/**描述*/
		public var desc:String;
		/**是否采有二进制流加载方式*/
		public var isBinary:Boolean = false;
		/**是否直接完成, 有相同加载进程，等待之前的加载完成后，此状态改变(无需重新加载)*/
		public var finish:Boolean = false;
		
		public var id:int;
		public var node:LoaderNode;
		public var loader:LoaderContent;
		
		/**加载证明
		 * @param $url		文件地址
		 * @param $key		自定义KEY
		 * @param $desc		说明
		 * @param $isBinary	是否已二进制方式加载
		 */
		public function LoaderItemes($url:String, $key:String, $desc:String = '', $isBinary:Boolean = true)
		{
			type = TXT_TYPE;
			if(ALoaderUtil.isLoader($url)) type = SWF_TYPE;
			
			url = $url;
			key = $key;
			desc = $desc;
			isBinary = $isBinary;
			loader = new LoaderContent(this);
		}
		
		public function dispose():void{
			node = null;
			loader.dispose();
			loader = null;
		}
		
		public static function create($url:String, $key:String, $desc:String = ''):LoaderItemes{
			return new LoaderItemes($url, $key, $desc);
		}
		
	}
}