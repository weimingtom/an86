package anlei.util
{
	import com.google.protobuf.Message;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	import anlei.debug.ApplicationStats;
	
	/**AS3 长连接通讯,处理粘包及VO反射的
	 * @author Anlei*/
	public class SocketServer
	{
		/**传输成功返回值*/
		public static const Success:int = 200;
		
		public static var ip:String;
		public static var port:int;
		
		private static var socket:Socket;
		private static var onConnectSuccess:Function;
		private static var onCloseSocket:Function;
		
		public static var errorCodeTipFn:Function;
		
		private static var success_arr:Vector.<Array>=new Vector.<Array>();
		
		private static var buf:ByteArray = new ByteArray();   
		private static function push(ba:ByteArray):void   
		{   
			if(buf == null){
				buf = ba;
			}else{
				buf.position = buf.length;
				buf.writeBytes(ba);
			}
		}

		public static function close():void{ socket.close(); onCloseSocket(); }
		
		public static function connect($ip:String, $port:int, $onConnectSuccess:Function = null, $onCloseSocket:Function = null):void
		{
			ip = $ip;
			port = $port;
			onConnectSuccess = $onConnectSuccess;
			onCloseSocket = $onCloseSocket;
			
			if(!socket){
				socket = new Socket();
				socket.endian= Endian.LITTLE_ENDIAN;
			}
			socket.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			
			socket.removeEventListener(Event.CLOSE, onClose);
			socket.addEventListener(Event.CLOSE, onClose);
			
			socket.removeEventListener(Event.CONNECT, onConnected);
			socket.addEventListener(Event.CONNECT, onConnected);
			
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, onServerData);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onServerData);
			socket.connect(ip, port);
		}
		
		private static function onIoError(e:IOErrorEvent):void{
			if(onCloseSocket!=null){
				onCloseSocket();
			}
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
			var ba:ByteArray = new ByteArray();
			socket.readBytes(ba, 0, socket.bytesAvailable);//服务器一次性发送的总共的数据，可能是几个包，也可能是几个半包  
			SocketServerBuffer.push(ba);
			var packet:Message 
			var packets:Vector.<Message> = SocketServerBuffer.getPackets();  
			var packetsLenght:int = packets.length;
			for(var i:int=0;i<packetsLenght;i++){
				packet = packets[i];
				if(packet != null){
					debug("接受:"+packet.toCmd()+"\n"+packet.toDump());
					disposeBackCall(packet);
					if(errorCodeTipFn != null && packet.hasOwnProperty('ret') && packet['ret'] != Success){
						errorCodeTipFn(packet['ret']);
					}
				}
			}
			
			
//			var ba:ByteArray = new ByteArray();
//			socket.readBytes(ba, 0, socket.bytesAvailable);//服务器一次性发送的总共的数据，可能是几个包，也可能是几个半包  
//			push(ba);
//			buf.position = 0;
//			while(buf && buf.bytesAvailable >= 4){
//				readFormatData();
//				if(buf.bytesAvailable <= 0) buf = null;
//			}
			
		}
		
		//////////////////////////////////////
		/**发送给服务端格式化好的数据(4位长度的包头+4位长度的协义号+包体VO对象)*/
		private static function writeFormatData($VO:Message):void{
			var body_byte:ByteArray = new ByteArray();
			$VO.writeToDataOutput(body_byte);
			
			var bytes:String = ""
			for(var i:int = 0 ; i < body_byte.length; i++){
				bytes += body_byte[i] + " ";
			}
			
			var cmd:int = $VO.toCmd();
			debug("发送:"+$VO.toCmd()+" 长度:"+body_byte.length + 4+" 包体: "+bytes+"\n发送协议:\n"+$VO.toDump());
			
			//第一个整数是包头(总长度=包体长度+协义号长度+标志[删除])
			//trace("包体总长度:", body_byte.length + 4 + [8]);
			socket.writeInt(body_byte.length + 4);
			//第二个是协义号(4位)
			//trace("写入协义号:",cmd);
			socket.writeInt(cmd);
			//第三个是标志(8位)[删除]
			//socket.writeDouble(0);
			//第四个是包体
			socket.writeBytes(body_byte, 0, body_byte.length);
			//socket.writeObject(body_byte);
			socket.flush();
		}
		
//		private static var isReadHead:Boolean = false;
//		private static var cmd:int = 0;
//		private static var offestLen:int = 0;
//		/**接收服务端的数据，并解析包头+包体*/
//		private static function readFormatData():void {
//			//数据长度要超过4位(int型的二进制占位长度)，才可以得到完成的包头
//			if (buf.bytesAvailable < 4){
//				buf.position = 0;
//				return;
//			}
//			//解析包头可得知，SOCKET要接收多少长度的数据来做为包体
//			if(!isReadHead){
//				var _lenByte:CustomerByteArray = new CustomerByteArray();
//				buf.readBytes(_lenByte, 0, 4);
//				offestLen = _lenByte.readInt();
//				isReadHead = true;
//			}
//			trace("轮长:", buf.bytesAvailable, "总长:", offestLen);
//			//得到包体，并不够长的话就等待
//			if (buf.bytesAvailable < offestLen){
//				buf.position = 0;
//				return;
//			}
//			//position = 4 因为读过包头了
//			var _byte:CustomerByteArray = new CustomerByteArray();
//			//读包体里的协义号
//			if(cmd == 0){
//				buf.readBytes(_byte, 0, 4);
//				_byte.position = 0;
//				cmd = _byte.readInt();
//				buf.readBytes(_byte, 0, 8);
//			}
//			//trace(" SC协义号:", cmd);
//			//读包体二进制
//			_byte.clear();
//			if(offestLen-4-8 > 0){
//				buf.readBytes(_byte, 0, offestLen-4-8);
//				_byte.position = 0;
//			}
//			
//			var bytedump:String = ""
//			for(var i:int = 0 ; i < _byte.length; i++){
//				bytedump += _byte[i] + " ";
//			}
//			trace("协义号:", cmd, " 收到包体:", bytedump);
//			
//			//解析包体
//			var _name:String = ServiceUtils.getInstance().getCmdName(cmd);
//			var _msg:Message = ServiceUtils.getInstance().getVO(_name) as Message;
//			if(_msg != null){
//				_msg.readFromDataOutput(_byte);
//				trace("接受:"+_msg.toCmd()+"\n"+_msg.toDump());
//				disposeBackCall(_msg);
//				if(errorCodeTipFn != null){
//					if(_msg.hasOwnProperty('ret') && _msg['ret'] != Success){
//						errorCodeTipFn(_msg['ret']);
//					}
//				}
//				//var _obj:Object = _byte.readObject();
//				//var _cmdObj:Object = disposeVOUV(_obj, cmd);
//			}else{
//				trace("ServiceUtils.getInstance().getVO("+_name+") as Message is null")
//			}
//			
//			//如果是读过头，则当前消息大于消息长度则再次调用读取
//			offestLen = 0;
//			cmd = 0;
//			isReadHead = false;
//			/*if(buf.bytesAvailable > 0){
//				trace("dddddddddddddddddd")
//				readFormatData();
//			}*/
//		}
//		/*
//		private static function disposeVOUV($vo:Object, $cmd:int):Object{
//			var _icmd:Object = ServiceUtils.getInstance().CovneVO("SC" + $cmd, $vo);
//			return _icmd;
//		}
//		*/
		
		private static function disposeBackCall($ICmd:Message):void{
			BackCallMarger.dispatch($ICmd);
			
//			var _autoRemoveArr:Array = [];
//			var len:int = success_arr.length;
//			for (var i:int = 0; i < len; i++) 
//			{
//				var arr:Array = success_arr[i];
//				if($ICmd.toCmd() == arr[0]){
//					if(arr[2]){//自动移除
//						_autoRemoveArr.push(arr);
//					}
//					
//					var _fn:Function = arr[1];
//					if(_fn!=null){
//						_fn($ICmd);
//					}
//					
//				}
//			}
//			for (var j:int = 0; j < _autoRemoveArr.length; j++){
//				removeBackCall(_autoRemoveArr[j][0], _autoRemoveArr[j][1]);
//			}
//			for each(var ar:Array in _autoRemoveArr){
//				removeBackCall(ar[0],ar[1]);
//			}
		}
		
		/////////////////////////////
		
		/**发送数据给服务端*/
		public static function Send($vo:Message):void{
			if(!socket) return;
			if(socket.connected){
				trace("发送:"+$vo.toString());
				writeFormatData($vo);
			}
		}
		
		/**侦听等待服务端推送数据$autoDispose为是否自动移除侦听*/
		public static function BackCall($cmd:int, $onSuccess:Function, $autoRemove:Boolean = false):void{
			if(socket && socket.connected){
				BackCallMarger.add($cmd, $onSuccess, $autoRemove)
			}
				
//			if(socket && socket.connected){
//				success_arr.push([$cmd, $onSuccess, $autoRemove]);
//			}
		}
		
		/**移除侦听等待服务端推送数据*/
		public static function removeBackCall($cmd:int, $onSuccess:Function):void{
			BackCallMarger.remove($cmd, $onSuccess)
				
//			var len:int = success_arr.length;
//			for (var i:int = 0; i < len; i++) {
//				var arr:Array = success_arr[i];
//				if(	$cmd == arr[0] && $onSuccess == arr[1]){
//					arr[1]=null;
//					success_arr.splice(i, 1);
//					return;
//				}
//			}
		}
		
		/**侦听等待服务端推送数据*/
		public static function hasBackCall($cmd:int, $onSuccess:Function):Boolean{
			return BackCallMarger.contain($cmd, $onSuccess);
				
//			for each(var arr:Array in success_arr){
//				if($cmd == arr[0] && $onSuccess == arr[1]){
//					return true;
//				}
//			}
//			return false;
			
//			for (var i:int = 0; i < success_arr.length; i++) {
//				if(	$cmd == success_arr[i][0]
//					&& $onSuccess == success_arr[i][1]
//				) return true
//			}
//			return false;
		}
		
		/**调试信息*/
		public static function debug(info:String):void{
			var _trace:int = 0;
			if(PublicProperty.CONFIG_XML){
				_trace = PublicProperty.CONFIG_XML.trace;
			}
			if(_trace == 1){
				ApplicationStats.getInstance().push(info);
			}
			trace(info);
		}
	}
}



import com.google.protobuf.Message;
import flash.utils.Dictionary;

class BackCaller
{
	public var cmd:int;
	public var callBack:Function
	public var autoRemove:Boolean
}


class BackCallMarger
{
	private static var  seccess_dic:Dictionary = new Dictionary();
	
	public static function add($cmd:int, $onSuccess:Function, $autoRemove:Boolean = false):void
	{
		var success_arr:Vector.<BackCaller> = seccess_dic[$cmd] as Vector.<BackCaller>;
		if(success_arr == null){
			success_arr = new Vector.<BackCaller>();
			seccess_dic[$cmd] = success_arr;
		}
		
		var bc:BackCaller = new BackCaller()
		bc.cmd= $cmd;
		bc.callBack= $onSuccess;
		bc.autoRemove= $autoRemove;
		success_arr.push(bc);
	}
	
	public static function remove($cmd:int, $onSuccess:Function):void
	{
		var success_arr:Vector.<BackCaller> = seccess_dic[$cmd] as Vector.<BackCaller>;
		if(success_arr == null) return;
		
		var index:int = success_arr.length;
		while(--index >= 0){
			if($cmd == success_arr[index].cmd && $onSuccess == success_arr[index].callBack){
				success_arr[index].callBack = null;
				success_arr.splice(index, 1);
			}
		}
	}
	
	public static function contain($cmd:int, $onSuccess:Function):Boolean
	{
		var success_arr:Vector.<BackCaller> = seccess_dic[$cmd] as Vector.<BackCaller>;
		if(success_arr == null) return false;
		
		var index:int = success_arr.length;
		while(--index >= 0){
			if($cmd == success_arr[index].cmd && $onSuccess == success_arr[index].callBack){
				return true;
			}
		}
		return false;
	}
	
	public static function dispatch($IMsg:Message):void
	{
		var cmd:int = $IMsg.toCmd();
		var success_arr:Vector.<BackCaller> = seccess_dic[cmd] as Vector.<BackCaller>;
		if(success_arr == null) return;
		
		var index:int = success_arr.length;
		while(--index >= 0){
			var dc:BackCaller = success_arr[index];
			if(cmd == dc.cmd){
				var _fn:Function = dc.callBack;
				if(_fn != null) _fn($IMsg);
				if(dc.autoRemove) success_arr.splice(index, 1);
			}
		}
	}
}