package
{
	import com.google.protobuf.Descriptor;
	import com.google.protobuf.Message;

	public class CS10002 extends Message
	{
		public function CS10002(){
			registerField("name","",Descriptor.STRING,Descriptor.LABEL_REQUIRED,1);
			registerField("desc","",Descriptor.STRING,Descriptor.LABEL_REPEATED,2);
		}
		/////////上行必要
		override public function toCmd():int{
			return 10002;
		}
		////////////////
		
		public var name:String = 'cs10002_anlei';
		public var desc:String = 'cs10002';
		
	}
}