package anlei.util
{
	import Events.GlobalEvent;
	
	import com.adobe.utils.StringUtil;
	
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	import anlei.debug.ApplicationStats;
	import anlei.util.ServiceUtils;
	
	import ui.component.MyLedClock;
	
	public class AMFService
	{
		public static var host:String = 'http://117.27.139.43/cTow/index_amf.php';
		public static var SID:String;
		
		public static const Evt:EventDispatcher = new EventDispatcher();
		
		
		public static var timeLed:MyLedClock = new MyLedClock();
		/**错误(警告)提示*/
		public static var onAlertPopModeth:Function = null;
		private static var connection:NetConnection;
		private var _isPopError:Boolean = true;
		
		
		public function AMFService($methods:String, $param:Object = null, $onSuccess:Function = null, $onFault:Function = null)
		{
			!$param && ($param = {})
			$param.SID = SID;
			if(!connection){
				connection= new NetConnection();
				connection.objectEncoding = ObjectEncoding.AMF3;
				connection.addEventListener(NetStatusEvent.NET_STATUS, onNetStaus);
				connection.connect(host);
				function onNetStaus(event:NetStatusEvent):void{
					ApplicationStats.getInstance().push("错误信息:" + $methods + "\n" + event.info.code);
					onAlertPopModeth && onAlertPopModeth("服务器繁忙!");
				}
			}
			
			//Waitting.getInstance().Show();
			
			var _dstr:String = '*********AMF请求:' + $methods + loopObject2Str($param) + '------------------------';
			ApplicationStats.getInstance().push(_dstr);
			trace(_dstr);
			
			connection.call($methods, new Responder(
				function(e:Object):void{
					
					timeLed.setTime(e.info.time);
					timeLed.countDown = false;
					
					//打印接收信息
					var _str:String = '*********AMF接收:' + loopObject2Str(e) + "AMF接收完*********\n";
					ApplicationStats.getInstance().push(_str);
					trace(_str);
					
					//Waitting.getInstance().Hide();
					
					//错误状态提示
					if(e.status != 1){
						if($onFault){
							$onFault(e);
						}else if(_isPopError){
							onAlertPopModeth && onAlertPopModeth(e);
						}
						return;
					}
					
					//事件反映
					if(e.info.hasOwnProperty('event')){
						for(var _item:String in e.info.event){
							Evt.dispatchEvent(new GlobalEvent(e.info.event[_item].type, e.info.event[_item].data));
						}
					}
					
					//VO转换并执行成功方法
					
					var CN:String = StringUtil.remove(e.info.method, '.');
					var _class:Class = ServiceUtils.getInstance().CovneVO(CN, e.data, e.info.method);
					if(_class != null){
						$onSuccess && $onSuccess(_class);
					}else{
						$onSuccess && $onSuccess(e);
					}
					
				}, $onFault), $param);
			
		}
		
		private function loopObject2Str(obj:Object, dee:int = 0):String{
			if(obj is String || obj is int){
				return obj + "\n";
			}else {
				var str:String="\n";
				for(var i:* in obj) { 
					str += tts(dee)+"["+i+"]=>" + loopObject2Str(obj[i],dee+1);
				}
				return str
			}
			return '';
		}
		
		private function tts(len:int):String {
			var str:String="";
			for(var i:int=0;i<len;i++)str+="     ";
			return str;
		}
		
		
		public function setPopError(value:Boolean):AMFService{ _isPopError = value; return this; }
		
		public static function Call($methods:String, $param:Object = null, $onSuccess:Function = null, $onFault:Function = null):AMFService{
			var _amf:AMFService = new AMFService($methods, $param, $onSuccess, $onFault);
			return _amf;
		}
		
	}
}