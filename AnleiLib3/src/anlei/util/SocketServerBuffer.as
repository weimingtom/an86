package anlei.util
{
	import com.google.protobuf.Message;
	
	import flash.utils.ByteArray;

	public class SocketServerBuffer
	{
		private static const HEAD_LEN:int = 4;
		private static const CMDS_LEN:int = 4;
		private static const FLAG_LEN:int = 0;
		
		/**
		 * 
		 */		
		private static var buf:ByteArray = new ByteArray();   
		
		/**
		 * 
		 * @param ba
		 * 
		 */		
		public static function push(ba:ByteArray):void   
		{   
			if(buf == null){   
				buf = ba;   
           	}else{   
				buf.position = buf.length;   
				buf.writeBytes(ba);   
           	}   
        } 
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public static function getPackets():Vector.<Message>   
		{
			var ret:Vector.<Message> = new Vector.<Message>();
			var position:int = 0;
			
			//打印原数据
			SocketServer.debug("池长: " + buf.bytesAvailable + " 包体: " + dumpByteArray(buf));
			
			//标记从0开始
			buf.position = position;
			while(buf.bytesAvailable >= HEAD_LEN)
			{
				//不改变原数组  读取头长度
				var head:int = readInt(buf.position);
				if (buf.bytesAvailable < head + HEAD_LEN){
					//发现长度不够时候 复制剩下的数据到新数据
					SocketServer.debug("池长: " + buf.bytesAvailable + " 包长: " + head + " 等待...")
					var temp:ByteArray = new ByteArray();   
					temp.writeBytes(buf, buf.position, buf.bytesAvailable);             
					buf = temp;
					return ret;
				}
				
				//长度足够  原数组 指针推进4位
				buf.position += HEAD_LEN;
				//不改变原数组  读取本条数据命令
				var cmd:int = readInt(buf.position);
				
				//读取完成  原数组指针推进 12位(4位命令,8位标志[删除])
				buf.position += CMDS_LEN + FLAG_LEN;
				//不改变原数据 读取一个数据包
				var value: CustomerByteArray = readByteArray(buf.position, head - CMDS_LEN - FLAG_LEN);
				
				SocketServer.debug("包长: " + head + " 协义: " + cmd + " 包体:" + dumpByteArray(value));
				
				try
				{
					var _name:String = ServiceUtils.getInstance().getCmdName(cmd);
					var _msg:Message = ServiceUtils.getInstance().getVO(_name) as Message;
					if(_msg != null)_msg.readFromDataOutput(value);
					ret.push(_msg);
				}
				catch(e:Error){ SocketServer.debug("Socket Buffer Error Message is : " + e.message); }
				
				//最后将原数组指针 指向包末尾 等待下次循环
				buf.position += head - CMDS_LEN - FLAG_LEN;
			}
			//结束如果没有数据剩下 清理内存
			if(buf.bytesAvailable <= 0) buf = null;
			return ret;
		}

		/**
		 * 
		 * @return 
		 * 
		 */		
		private static function readInt(position:int):int
		{
			var value: CustomerByteArray = new CustomerByteArray();   
			value.writeBytes(buf, position, 4);
			value.position = 0;
			var len:uint = value.readInt();  
			return len;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		private static function readByteArray(position:int, length:int):CustomerByteArray
		{
			var value: CustomerByteArray = new CustomerByteArray();   
			if(length != 0) value.writeBytes(buf, position, length);
			value.position = 0;
			return value;
		}
		
		/**
		 * 
		 * @param _byte
		 * 
		 */		
		private static function dumpByteArray(_byte:ByteArray):String
		{
			var bytedump:String = ""

			for(var i:int = 0 ; i < _byte.length; i++){
				bytedump += _byte[i] + " ";
			}
			return bytedump;
		}
	}
}