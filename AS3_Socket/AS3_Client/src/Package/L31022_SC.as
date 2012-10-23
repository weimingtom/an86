package Package
{
import com.google.protobuf.*;
public class L31022_SC extends Message
{
	public static const CMD:int = 31022;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31022_SC"; }


	/**
	 * 
	 */
	public function L31022_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 返回值
	 */
	public var ret:uint;

}
}
