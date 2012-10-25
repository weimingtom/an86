package Package
{
import com.google.protobuf.*;
public class L31013_SC extends Message
{
	public static const CMD:int = 31013;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31013_SC"; }


	/**
	 * 
	 */
	public function L31013_SC()
	{
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("cmemo", "Package.CMemo", Descriptor.MESSAGE, Descriptor.LABEL_REQUIRED, 2);
	}

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 附带数据
	 */
	public var cmemo:Package.CMemo = new Package.CMemo();

}
}
