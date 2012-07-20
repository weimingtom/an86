package net.an86
{
	import flash.events.NetStatusEvent;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	public class BasicRtmp{
		private static const URI:String = "";
		private static const APP:String = "";
		
		private var onSuccess:Function;
		private var onLose:Function;
		private var param:Object;
		
		private var nc:NetConnection = new NetConnection();
		
		public function BasicRtmp($onSuccess:Function = null, $onLose:Function = null, arg:Array = null)
		{
			onSuccess = $onSuccess;
			onLose = $onLose;
			param = arg;
			initLink();
		}
		private function initLink():void{
			nc.addEventListener(NetStatusEvent.NET_STATUS,doSO);
			//nc.connect("rtmp://172.16.18.2/test001");
			nc.connect("rtmp:/test001", param);
		}
		private function doSO(e:NetStatusEvent):void{
			if(e.info.code == "NetConnection.Connect.Success"){
				onSuccess && onSuccess();
			}else{
				onLose && onLose();
			}
		}
		
		public function get link():NetConnection{
			return nc;
		}
		
		public function call(cmd:Object,
							 onS:Function,
							 onL:Function = null,
							 arg:Object = null):BasicRtmp{
			nc.call(String(cmd),
					new Responder(onS, onL),
					arg);
			return this;
		}
		
	}
}