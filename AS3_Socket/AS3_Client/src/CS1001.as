package
{
	import com.google.protobuf.Descriptor;
	import com.google.protobuf.Message;

	public class CS1001 extends Message
	{
		//public var UserID:int = 123654;
		//public var UserName:String = 'cs1001_anlei';
		
		//public var StringList:Array = ['a','ab','cde','c','d'];
		//public var IntList:Array = [1,2,3,4,5,6];
		//public var NumList:Array = [1.12, 2.23, 3.34, 4.45];
		
		//public var Num:Number = 12.34;
		
		public var UserList:Vector.<User> = new Vector.<User>();
		
		
		public function CS1001()
		{
			var _u:User = new User();
			_u.UID = 1000001;
			_u.UN = "A";
			
			var _u1:User = new User();
			_u1.UID = 1000002;
			_u1.UN = "B";
			
			
			UserList.push(_u);
			UserList.push(_u1);
			//registerField("UserID","",Descriptor.INT32,Descriptor.LABEL_REQUIRED,1);
			//registerField("UserName","",Descriptor.STRING,Descriptor.LABEL_REQUIRED,2);
			//registerField("StringList","",Descriptor.STRING,Descriptor.LABEL_REPEATED,3);
			//registerField("IntList","",Descriptor.INT32,Descriptor.LABEL_REPEATED,4);
			//registerField("NumList","",Descriptor.DOUBLE,Descriptor.LABEL_REPEATED,1);
			//registerField("Num","",Descriptor.DOUBLE,Descriptor.LABEL_REQUIRED,1);
			registerField("UserList","", Descriptor.MESSAGE, Descriptor.LABEL_REPEATED, 1);
		}
		/////////上行必要
		override public function toCmd():int{
			return 1001;
		}
	}
}
/*
AS端CS的VO字段说明
在构造函数里注册字段
registerField("UserID",		"",	Descriptor.INT32,	Descriptor.LABEL_REQUIRED,	1);//int
registerField("UserName",	"",	Descriptor.STRING,	Descriptor.LABEL_REQUIRED,	2);//String
registerField("StringList",	"",	Descriptor.STRING,	Descriptor.LABEL_REPEATED,	3);//String Array
registerField("IntList",	"",	Descriptor.INT32,	Descriptor.LABEL_REPEATED,	4);//int Array
registerField("NumList",	"",	Descriptor.DOUBLE,	Descriptor.LABEL_REPEATED,	5);//Double Array
registerField("Num",		"",	Descriptor.DOUBLE,	Descriptor.LABEL_REQUIRED,	6);//Number(Double)
registerField("UserList",	"",	Descriptor.MESSAGE,	Descriptor.LABEL_REPEATED,	7);//VO内嵌(Vector)


/////////上行必要
override public function toCmd():int{
	return 1001;
}

*/
