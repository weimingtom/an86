package anlei.db
{
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	
	import flash.utils.ByteArray;
	/**
	 * 处理外部zip文件的二进制数据
	 * @author Anlei
	 */
	public class ZIPXml
	{
		private var isFrist:Boolean = false;
		private var zip:FZip;
		private var fileNameArr:Vector.<DBStruct>;
		
		public function ZIPXml()
		{
			inits();
		}
		
		private function inits():void{
			zip = new FZip();
			fileNameArr = new Vector.<DBStruct>();
		}
		/**把二进制数据写入ZIP类中*/
		public function setBytes($data:ByteArray):void{
			if(isFrist) return;
			isFrist = true;
			
			zip.loadBytes($data);
			
			var fc:int = zip.getFileCount();
			for(var i:int = 0;i<fc; i++)
			{
				var zipfile:FZipFile = zip.getFileAt(i);
				var str:String = zipfile.content.readUTFBytes(zipfile.content.bytesAvailable);
				var _xml:XML = XML(str);
				var _name:String = zipfile.filename.split('.')[0];
				var _db:DBStruct = new DBStruct();
				_db.name = _name;
				_db.xml = _xml;
				fileNameArr.push(_db);
			}
			zip.close(); 
		}
		
		/**获取单个XML文件
		 * @param $fileName		文件名(不包括展名)
		 * @return 				返回单个XML文件
		 */
		public function getXML($fileName:String):XML{
			var _len:int = fileNameArr.length;
			var _db:DBStruct;
			for each(_db in fileNameArr){
				if(_db.name == $fileName){
					return _db.xml;
				}
			}
			return null;
		}
		
		/**
		 * 获取单个XML文件里与ID相同的所有XMLList
		 * @param $fileName		文件名(不包括展名)
		 * @param $id			ID(一般是Access中自动生成的且会累计叠加的ID字段)
		 * @param $field		字段名
		 * @return				返回单个XMLList
		 */
		public function getList($fileName:String, $idValue:String, $field:String = 'id'):XML{
			var _list:XML = new XML(<{$fileName}/>);
			var _xml:XML = getXML($fileName);
//			var _len:int = _xml.children().length();
//			for(var i:int = 0 ; i < _len; i++){
//				if(_xml.children()[i][$field].toString() == $idValue){
//					_list.appendChild(_xml.children()[i]);
//				}
//			}
			var list:XMLList = _xml.children();
			for each(var item:XML in list){
				if(item[$field].toString() == $idValue){
					_list.appendChild(item);
				}
			}
			return _list;
		}
		
		/**获取单个XML文件中与$ID相同的节点
		 * @param $fileName		文件名(不包括展名)
		 * @param $id			ID(一般是Access中自动生成的且会累计叠加的ID字段)
		 * @return 				返回单个XML文件节点
		 */
		public function getXmlItem($fileName:String, $id:String):XML{
			var _xml:XML = getXML($fileName);
//			var _len:int = _xml.children().length();
//			for(var i:int = 0 ; i < _len; i++){
//				if(_xml.children()[i].id.toString() == $id){
//					return new XML(_xml.children()[i].toString());
//				}
//			}
			var list:XMLList = _xml.children();
			for each(var item:XML in list){
				if(item.id.toString() == $id){
					return item;
				}
			}
			return null;
		}
		/**
		 * 获取单个XML文件中字段与value相同的值
		 * @param $fileName		文件名(不包括展名)
		 * @param $field		字段
		 * @param $value		与字段值相同的值列表
		 * @return 				返回单个XML文件节点
		 */		
		public function getFieldListIn($fileName:String, $field:String, $value:Vector.<String>):XML{
			var _xml:XML = getXML($fileName);
			var list:XMLList = _xml.children();
			for each(var item:XML in list){
				if($value.indexOf(item[$field].toString()) != -1){
					return item;
				}
			}
			return null;
		}
		/**
		 * 获取单个XML文件中字段与value相同的值
		 * @param $fileName		文件名(不包括展名)
		 * @param $field		字段
		 * @param $value		与字段值相同的值
		 * @return 				返回单个XML文件节点
		 */		
		public function getFieldList($fileName:String, $field:String, $value:String):XML{
			var _xml:XML = getXML($fileName);
//			var _len:int = _xml.children().length();
//			for(var i:int = 0 ; i < _len; i++){
//				if(_xml.children()[i][$field].toString() == $value){
//					_xml = XML(_xml.children()[i].toString());
//					return _xml;
//				}
//			}
			var list:XMLList = _xml.children();
			for each(var item:XML in list){
				if(item[$field].toString() == $value){
					return item;
				}
			}
			return null;
		}
		/**
		 * 当有相同值的字段时, 以第二个值做对比并获取
		 * @param $fileName		文件名(不包括展名)
		 * @param $field_0		字段1
		 * @param $value_0		与字段1值相同的值
		 * @param $field_1		字段2
		 * @param $value_1		与字段2值相同的值
		 * @return 				xml节点
		 */		
		public function getFilter(
									$fileName:String,
								  	$id:String,
								  	$field_1:String, $value_1:String
									):XML{
			var _xml:XML = getList($fileName, $id);
//			var _len:int = _xml.children().length();
//			for(var i:int = 0 ; i < _len; i++){
//				if(_xml.children()[i][$field_1].toString() == $value_1){
//					return new XML(_xml.children()[i].toString());
//				}
//			}
			var list:XMLList = _xml.children();
			for each(var item:XML in list){
				if(item[$field_1].toString() == $value_1){
					return item;
				}
			}
			return null;
		}
		
		
		public function get2FieldList($fileName:String, $field_1:String, $value_1:String, $field_2:String, $value_2:String):XML{
			var _xml:XML = getXML($fileName);
//			var _len:int = _xml.children().length();
//			for(var i:int = 0 ; i < _len; i++){
//				var _child:XML = _xml.children()[i];
//				if(_child[$field_1].toString() == $value_1
//					&& _child[$field_2].toString() == $value_2){
//					_xml = XML(_child.toString());
//					return _xml;
//				}
//			}
			var list:XMLList = _xml.children();
			for each(var item:XML in list){
				if(item[$field_1].toString() == $value_1 && item[$field_2].toString() == $value_2){
					return item;
				}
			}
			return null;
		}
	}
}
class DBStruct{
	public var name:String;
	public var xml:XML;
}