package anlei.db
{
	
	/**
	 * 		处理Access中的数据,用法:<br />
			AccessDB.getInstance().zip.setBytes(_d.content);<br />
			trace(AccessDB.getInstance().zip.getXML('user'));<br />
			trace(AccessDB.getInstance().zip.getXMLList('photo', '4'));<br />
			trace(AccessDB.getInstance().zip.getFieldList('photo', 'uid', '5'));<br />
	 */
	public class AccessDB
	{
		/**---------------------------------- Start 单例 -------------------------------------------*/
		private static var _instance:AccessDB;
		public function AccessDB(signle:Signle)
		{
			if(signle == null) throw new Error("AccessDB类为单例，不能用new");
			inits();
		}
		public static function getInstance():AccessDB{
			if(_instance == null) _instance = new AccessDB(new Signle());
			return _instance;
		}
		/**----------------------------------  End 单例  -------------------------------------------*/
		public	var zip:ZIPXml;
		private function inits():void{
			zip = new ZIPXml();
		}
	}
}
class Signle{}