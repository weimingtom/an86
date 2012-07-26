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
			UserList.push(new User());
			UserList.push(new User());
			//registerField("UserID","",Descriptor.INT32,Descriptor.LABEL_REQUIRED,1);
			//registerField("UserName","",Descriptor.STRING,Descriptor.LABEL_REPEATED,2);
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
