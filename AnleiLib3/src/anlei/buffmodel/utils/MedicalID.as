package anlei.buffmodel.utils
{
	public class MedicalID
	{
		/**可以重置的单一（如中毒）魔法效果集合*/
		public static const isresetMac:Array = [poisoning];
		
		/**中毒*/
		public static const poisoning:String = '100008';
		
		public static function pushIsreset($id:String):void{
			if(isresetMac.indexOf($id) == -1){
				isresetMac.push($id);
			}
		}
	}
}