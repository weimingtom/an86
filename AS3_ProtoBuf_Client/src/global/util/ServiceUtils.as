package  global.util
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ServiceUtils
	{
		private static var _instance:ServiceUtils;
		public function ServiceUtils(_signle:signle){}
		public static function getInstance():ServiceUtils{
			if(_instance == null) _instance = new ServiceUtils(new signle());
			return _instance;}
		
		public var LIST:XML;// = ValueObjectList.LIST;
		/**
		 * 转换服务端数据成本地类的实例对象
		 * @param $ASClassName		类包命名空间，即地址
		 * @param $serviceData		服务端数据
		 */		
		public function CovneVO($ASClassName:String, $serviceData:Object, $method:String = ''):Object{
			$ASClassName = $ASClassName.toLocaleUpperCase();
			var _xmlList:Object = XMLList(LIST.item.(String(@id).toLocaleUpperCase()==$ASClassName));
			
			if(_xmlList.length() > 1){
				_xmlList = _xmlList[0];
			}
			
			if(String(_xmlList.@id) == '' || !$serviceData){
				return null;
			}
			var _lurl:String = String(_xmlList.@url);
			var _dotUrl:String = _lurl.length > 0 ? _lurl + "." : '';
			var _obj:* = setVO(_dotUrl + String(_xmlList.@id), $serviceData);
			if(_obj.hasOwnProperty('method')){
				_obj.method = $method;
			}
			return _obj;
		}
		/**
		 * 生成映射实例对象
		 * @param $class_path		类包命名空间，即包路径
		 * @param $serviceData		服务端数据
		 */		
		private function setVO($class_path:String, $serviceData:Object):*{
			var _ud:* = getDefinitionByName($class_path) as Class;
			_ud = new _ud();
			return setBasicVO(_ud, $serviceData);
		}
		
		/**
		 * 循环映射实例对象
		 * @param $newObject		已生成好的映射实例对象
		 * @param $serviceData		服务端数据
		 * @return 映射好的对象
		 */		
		private function setBasicVO($newObject:Object, $serviceData:Object):Object{
			if($serviceData && $serviceData.hasOwnProperty("0")){
				var _len:int = $serviceData.length;
				var _str:String = getQualifiedClassName($newObject.data);
				_str = resetTypeUrl(_str);
				
				for(var i:int = 0 ; i < _len; i++){
					var _class:* = setVO(_str, $serviceData[i]);
					if(_class == "" || _class == null){
						_class = $serviceData[i];
					}
					$newObject.data.push(_class);
				}
			}
			for(var _name:String in $serviceData){
				if($newObject.hasOwnProperty(_name)){
					if($serviceData[_name] is String || $serviceData[_name] is Number){
						$newObject[_name] = $serviceData[_name];
					}else{
						setBasicVO($newObject[_name], $serviceData[_name]);
					}
				}
			}
			if($newObject && $newObject.hasOwnProperty("execSuper")){
				$newObject["execSuper"]();
			}
			return $newObject;
		}

		/**取Vector数组里的类的包路径*/
		private function resetTypeUrl(_itemtype:String):String {
			var _typearr:Array = _itemtype.split("<");
			_itemtype = _typearr[_typearr.length - 1];
			_itemtype = replace(_itemtype, "::", '.');
			_itemtype = replace(_itemtype, ">", '');
			//var _last:int = _itemtype.lastIndexOf(".");
			//_itemtype = _itemtype.substring(_last+1, _itemtype.length);
			return _itemtype;
		}
		
		private function replace($oldstr:String, $restr:String, $revalue:String):String {
			return $oldstr.split($restr).join($revalue);
		}
	}
}
class signle{}