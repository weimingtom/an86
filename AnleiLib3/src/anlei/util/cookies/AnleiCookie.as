package anlei.util.cookies
{
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	public class AnleiCookie
	{
		private static var _instance:AnleiCookie;
		public function AnleiCookie(signle:Signle) { inits(); }
		public static function getInstance($name:String):AnleiCookie {
			name = $name;
			if (_instance == null)
				_instance = new AnleiCookie(new Signle());
			return _instance;
		}
		///////////////////////////
		private static var name:String;
		private var dict:Dictionary;
		
		private function inits():void {
			dict = new Dictionary();
		}
		
		private function createCK():void{
			if(!dict.hasOwnProperty(name))
				dict[name] = new RelineCookie(name);
		}
		
		public function Set($field:String, $value:Object):void{
			createCK();
			RelineCookie(dict[name]).Set($field, $value);
		}
		
		public function Get($field:String):Object{
			createCK();
			return RelineCookie(dict[name]).Get($field);
		}
		
		
	}
}
import flash.net.SharedObject;

class Signle{}

class RelineCookie {
	
	private var name:String;
	private var _so:SharedObject;
	
	public function RelineCookie($name:String){
		name = $name;
		_so=SharedObject.getLocal(name, "/");
		
	}
	
	public function Set($field:String, $value:Object):void{
		_so.data[$field] = $value;
		_so.flush();
	}
	
	public function Get($field:String):Object{
		return _so.data[$field];
	}
	
}