package
{
	public class UserVO
	{
		public var cmd:int = 10001;
		public var name:String = "Anlei";
		
		[Embed(source="1.txt",mimeType='application/octet-stream')]
		public static var type:Class;
		
		public var desc:String;
	}
}