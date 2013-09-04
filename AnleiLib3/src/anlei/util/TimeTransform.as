package anlei.util
{
	/**秒转成日期*/
	public class TimeTransform
	{
		public   static var timeTrans:TimeTransform;  
		public var date:Date;  
		public function TimeTransform()  
		{  
			if(timeTrans!=null){  
				throw new Error("单例类只能被实例化一次");  
			}  
		}
		
		public static function getInstance():TimeTransform{  
			if(timeTrans==null){  
				timeTrans=new TimeTransform();  
			}  
			return timeTrans;  
		}
		
		public function getDataTime(num:Number):String{
			date = new Date(1377498418*1000);  
			return date.fullYear+"-"+(date.month+1)+"-"+date.date + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
		}
		
		public function transDate(num:Number):String{
			date=new Date(num*1000);  
			return date.fullYear+"/"+(date.month+1)+"/"+date.date;  
		}
		
		public function transToDate(num:Number):Object{  
			date = new Date(num*1000);
			return {year:date.fullYear, month:date.month + 1, date:date.date};  
		}
		
		public function getData(num:Number):Number{
			date = new Date(num*1000);
			var newData:Date = new Date(date.fullYear,date.month,date.date);
			return (newData.getTime())/1000;
		}
		
	}
}