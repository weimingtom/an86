package global.util
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	/**AS3 长连接通讯,处理粘包及VO反射的
	 * @author Anlei*/
	public class SocketServer
	{
		public static var ip:String;
		public static var port:int;
		
		private static var socket:Socket;
		private static var onConnectSuccess:Function;
		private static var onCloseSocket:Function;
		
		private static var success_arr:Array = [];
		
		public static function connect($ip:String, $port:int, $onConnectSuccess:Function = null, $onCloseSocket:Function = null):void
		{
			ip = $ip;
			port = $port;
			onConnectSuccess = $onConnectSuccess;
			onCloseSocket = $onCloseSocket;
			
			if(!socket){
				socket = new Socket();
			}
			
			socket.removeEventListener(Event.CLOSE, onClose);
			socket.addEventListener(Event.CLOSE, onClose);
			
			socket.removeEventListener(Event.CONNECT, onConnected);
			socket.addEventListener(Event.CONNECT, onConnected);
			
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, onServerData);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onServerData);
			socket.connect(ip, port);
		}
		
		private static function onClose(e:Event):void{
			if(onCloseSocket!=null){
				onCloseSocket();
			}
		}
		
		private static function onConnected(event:Event):void {
			socket.removeEventListener(Event.CONNECT, onConnected);
			if(onConnectSuccess!=null){
				onConnectSuccess();
				onConnectSuccess = null;
			}
		}
		private static function onServerData(event:ProgressEvent):void {
			readFormatData();
		}
		
		
		//////////////////////////////////////
		
		
		/**发送给服务端格式化好的数据(4位长度的包头+包体VO对象)*/
		private static function writeFormatData($VO:Object):void{
			var body_byte:ByteArray = new ByteArray();
			body_byte.writeObject($VO);
			
			socket.writeInt(body_byte.length);
			socket.writeObject($VO);
			socket.flush();
		}
		
		private static var isReadHead:Boolean = false;
		private static var offestLen:int = 0;
		/**接收服务端的数据，并解析包头+包体*/
		private static function readFormatData():void {
			//数据长度要超过4位(int型的二进制占位长度)，才可以得到完成的包头
			if (socket.bytesAvailable < 4) return;
			//解析包头可得知，SOCKET要接收多少长度的数据来做为包体
			if(!isReadHead){
				var _lenByte:ByteArray = new ByteArray();
				socket.readBytes(_lenByte, 0, 4);
				offestLen = _lenByte.readInt();
				isReadHead = true;
			}
			//得到包体
			if (socket.bytesAvailable < offestLen) return;
			//position = 4 因为读过包头了
			var _byte:ByteArray = new ByteArray();
			//读包体二进制
			socket.readBytes(_byte, 0, offestLen);
			offestLen = 0;
			isReadHead = false;
			//解析包体
			var _obj:Object = _byte.readObject();
			
			var _cmd:Object = disposeVOUV(_obj);
			disposeBackCall(_cmd);
			
			//如果是读过头，则当前消息大于消息长度则再次调用读取
			socket.bytesAvailable > 0 && readFormatData();
		}
		
		private static function disposeVOUV($vo:Object):Object{
			var _icmd:Object = ServiceUtils.getInstance().CovneVO("SC"+$vo.cmd, $vo);
			return _icmd;
		}
		
		private static function disposeBackCall($ICmd:Object):void{
			for (var i:int = 0; i < success_arr.length; i++) 
			{
				if($ICmd.cmd == success_arr[i][0]){
					var _fn:Function = success_arr[i][1];
					if(_fn!=null){
						_fn($ICmd);
					}
				}
			}
			
		}
		
		/////////////////////////////
		
		/**发送数据给服务端*/
		public static function Send($vo:Object):void{
			if(socket.connected){
				writeFormatData($vo);
			}
		}
		
		/**侦听等待服务端推送数据*/
		public static function BackCall($cmd:int, $onSuccess:Function):void{
			if(socket.connected){
				success_arr.push([$cmd, $onSuccess]);
			}
		}
		
		/**移除侦听等待服务端推送数据*/
		public static function removeBackCall($cmd:int, $onSuccess:Function):void{
			for (var i:int = 0; i < success_arr.length; i++) {
				if(	$cmd == success_arr[i][0]
					&& $onSuccess == success_arr[i][1]
				){
					success_arr.splice(i, 1);
					return;
				}
			}
		}
		
	}
}
