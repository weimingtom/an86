package Package
{
import com.google.protobuf.*;
public class L31002_SC extends Message
{
	public static const CMD:int = 31002;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31002_SC"; }


	/**
	 * 
	 */
	public function L31002_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 返回码
	 */
	public var ret:uint;

}
}
