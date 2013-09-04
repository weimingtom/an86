package anlei.util
{
	import com.adobe.crypto.MD5;
	
	import flash.display.Stage;
	
	import cmodule.test.CLibInit;

	/**
	 *
			var key:String = AlibabaPass.getInstance().getMoney(11, 4, 25);
			trace(key);
			var pass:String = XXTEA.encrypt_hax('nihao123!', key);
			trace(pass);
			
	 */
	public class AlibabaPass
	{
		/**---------------------------------- Start 单例 -------------------------------------------*/
		private static var _instance:AlibabaPass;
		public function AlibabaPass(signle:Signle)
		{
			if(signle == null) throw new Error("AlibabaPass类为单例，不能重新new");
		}
		public static function getInstance():AlibabaPass
		{
			if(_instance == null) _instance = new AlibabaPass(new Signle());
			return _instance;
		}
		/**----------------------------------  End 单例  -------------------------------------------*/
		
		public var PASS_KEY:String;
		
		public function getMoney(ts:int):String{
			var _obj:Object = TimeTransform.getInstance().transToDate(ts);
			var _stage:Stage = Entrance.getInstance().Root.stage;
			var clib:CLibInit = new CLibInit();
			var aslib:Object = clib.init();
			return aslib.getMoney(_obj.year, _obj.month-1, _obj.date-1, _stage);
		}
		
		public function GetFlashKeyCode(ikey:String, ts:int):String
		{
			var index:int;
			var key:String = getMoney(ts);//原来的获取密码
			
			for(var i:int = 0 ; i < ikey.length; i++){//顺序遍历
				var keyCode:String = String.fromCharCode(ikey.charCodeAt(i))
				index = int(keyCode);
				if (index > key.length - 1) index = key.length - 1;
				key = key.substring(0, index) + keyCode + key.substring(index, key.length);
			}
			key = MD5.hash(key + ts).toLowerCase();
			return key;
		}
		
	}
}
class Signle{}