package anlei.util
{
	public class StopWatch
	{
		private var stime:Number;
		
		public static function start():StopWatch
		{
			var sw:StopWatch = new StopWatch();
			return sw.start();
		}
		
		public function start():StopWatch
		{
			var sdate:Date = new Date();
			stime = sdate.getTime();
			return this;
		}
		
		public function stop(info:String):Number
		{
			var edate:Date = new Date();
			var etime:Number = edate.getTime();
			var ms:Number = etime - stime;
			stime = etime;
			trace(info, ":", ms, "ms");
			return ms;
		}
		
	}
}