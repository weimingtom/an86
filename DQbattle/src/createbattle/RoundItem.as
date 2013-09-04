package createbattle
{
	public class RoundItem
	{
		public var who:int;
		public var type:int;
		public var shp:Number;
		public var id:int;
		
		public function toString():String{
			var str:String = "("+id+")\t";
			var _en:String = '';
			if(who == RoundConfig.ME){
				str += "me ";
				_en = "en ";
			}else{
				str += "en\t";
				_en = "me ";
			}
			switch(type){
				case RoundConfig.AT:
					str += "at\t";
					break;
				case RoundConfig.SAT:
					str += "sat\t";
					break;
				case RoundConfig.FLASH:
					str += _en + "\tfla ";
					break;
			}
			if(shp > 0){
				str += "sub " + _en + "hp:" + shp;
			}
			return str;
		}
	}
}