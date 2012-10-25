package Package
{
import com.google.protobuf.*;
public class L31012_SC extends Message
{
	public static const CMD:int = 31012;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31012_SC"; }


	/**
	 * 
	 */
	public function L31012_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("informations", "Package.CMemo", Descriptor.MESSAGE, Descriptor.LABEL_REPEATED, 2);
	}

	/**
	 * 返回值
	 */
	public var ret:uint;

	/**
	 * 服务器上临时数据数组
	 */
	public var informations:Vector.<Package.CMemo> = new Vector.<Package.CMemo>();

}
}
