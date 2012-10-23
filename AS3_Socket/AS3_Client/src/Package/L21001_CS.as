package Package
{
import com.google.protobuf.*;
public class L21001_CS extends Message
{
	public static const CMD:int = 21001;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L21001_CS"; }


	/**
	 * 
	 */
	public function L21001_CS()
	{
		registerField("agent", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 1);
		registerField("sid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("username", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 3);
		registerField("isadult", "", Descriptor.BOOL, Descriptor.LABEL_REQUIRED, 4);
		registerField("sign", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 5);
		registerField("ts", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 6);
	}

	/**
	 * 运营商代号
	 */
	public var agent:String;

	/**
	 * 服务器编号
	 */
	public var sid:uint;

	/**
	 * 用户名
	 */
	public var username:String;

	/**
	 * 是否成人
	 */
	public var isadult:Boolean;

	/**
	 * 数据签名
	 */
	public var sign:String;

	/**
	 * 时间戳
	 */
	public var ts:uint;

}
}
