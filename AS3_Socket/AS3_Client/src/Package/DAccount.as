package Package
{
import com.google.protobuf.*;
public class DAccount extends Message
{
	/**
	 * 
	 */
	public function DAccount()
	{
		registerField("uid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("sid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("username", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 3);
		registerField("install", "", Descriptor.BOOL, Descriptor.LABEL_REQUIRED, 4);
		registerField("ctime", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
	}

	/**
	 * 用户编号
	 */
	public var uid:uint;

	/**
	 * 服务器编号
	 */
	public var sid:uint;

	/**
	 * 用户名
	 */
	public var username:String;

	/**
	 * 是否初始化
	 */
	public var install:Boolean;

	/**
	 * 创建时间
	 */
	public var ctime:uint;

}
}
