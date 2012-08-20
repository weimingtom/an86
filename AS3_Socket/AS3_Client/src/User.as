package
{
	import com.google.protobuf.Descriptor;
	import com.google.protobuf.Message;

	public class User extends Message
	{
		public var UID:int;
		public var UN:String;
		
		public function User(){
			registerField("UID","",Descriptor.INT32,Descriptor.LABEL_REQUIRED,1);
			registerField("UN","",Descriptor.STRING,Descriptor.LABEL_REQUIRED,2);
		}
		
	}
}