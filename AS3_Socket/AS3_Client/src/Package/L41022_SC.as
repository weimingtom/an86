package Package
{
import com.google.protobuf.*;
public class L41022_SC extends Message
{
	public static const CMD:int = 41022;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L41022_SC"; }


	/**
	 * 
	 */
	public function L41022_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("member", "", Descriptor.MESSAGE, Descriptor.LABEL_REQUIRED, 2);
		registerField("heroies", "", Descriptor.MESSAGE, Descriptor.LABEL_REQUIRED, 3);
	}

	/**
	 * 返回码
	 */
	public var ret:uint;

	/**
	 * 用户的Member模型
	 */
	public var member:Package.DMember = new Package.DMember();

	/**
	 * 主英雄Heroies模型
	 */
	public var heroies:Package.DHeroies = new Package.DHeroies();

}
}