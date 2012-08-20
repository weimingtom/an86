package
{
	import com.google.protobuf.Descriptor;
	import com.google.protobuf.Message;

	public class UserVO extends Message
	{
		public function UserVO(){
			registerField("name","",Descriptor.STRING,Descriptor.LABEL_REQUIRED,1);
			registerField("desc","",Descriptor.STRING,Descriptor.LABEL_REQUIRED,2);
			registerField("sarr","",Descriptor.STRING,Descriptor.LABEL_REPEATED,3);
			registerField("narr","",Descriptor.INT32, Descriptor.LABEL_REPEATED,4);
			
			for (var i:int = 0; i < 3; i++) 
			{
				var _u:User = new User();
				_u.id = 10+i;
				_u.name = "Anlei" + String(10+i);
				userList.push(_u);
			}
			
		}
			
		public var name:String = "Anlei";
		
		//[Embed(source="1.txt",mimeType='application/octet-stream')]
		//public static var type:Class;
		
		public var desc:String;
		public var sarr:Array = ['a','b','c','d'];
		public var narr:Array = [1,2,3,4];
		
		public var userList:Array = [];
		/////////////////////////
		override public function toCmd():int{
			return 1001;
		}
		
	}
}
class User{
	public var id:int;
	public var name:String;
}
class UserList{
	public var data:Vector.<User> = new Vector.<User>();
}