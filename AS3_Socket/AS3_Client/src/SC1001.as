package
{
	import com.google.protobuf.Descriptor;
	import com.google.protobuf.Message;

	public class SC1001 extends Message
	{
		//public var UserID:int;
		//public var UserName:String;
		
		//public var StringList:Array = [];
		//public var IntList:Array = [];
		//public var NumList:Array = [];
		//public var Num:Number;
		public var UserList:Vector.<User> = new Vector.<User>();
		
		public function SC1001()
		{
			//registerField("UserID","",Descriptor.INT32,Descriptor.LABEL_REQUIRED,1);
			//registerField("UserName","",Descriptor.STRING,Descriptor.LABEL_REPEATED,2);
			//registerField("StringList","",Descriptor.STRING,Descriptor.LABEL_REPEATED,3);
			//registerField("IntList","",Descriptor.INT32,Descriptor.LABEL_REPEATED,4);
			//registerField("NumList","",Descriptor.DOUBLE, Descriptor.LABEL_REPEATED,1);
			//registerField("Num","",Descriptor.DOUBLE,Descriptor.LABEL_REQUIRED,1);
			registerField("UserList","User", Descriptor.MESSAGE, Descriptor.LABEL_REPEATED, 1);
		}
		/////////下行必要
		public static const CMD:int = 1001;
		override public function toCmd():int{
			return CMD;
		}
		///////////////////
		/*
		public var name:String;
		public var desc:String;
		public var sarr:StringList = new StringList();
		public var narr:NumberList = new NumberList();
		public var userList:UserList = new UserList();*/
	}
}
/*
class UserList{
	public var data:Vector.<User> = new Vector.<User>();
}
class StringList{
	public var data:Vector.<String> = new Vector.<String>();
}
class NumberList{
	public var data:Vector.<Number> = new Vector.<Number>();
}*/