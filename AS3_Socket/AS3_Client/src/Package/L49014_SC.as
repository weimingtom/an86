package Package
{
import com.google.protobuf.*;
public class L49014_SC extends Message
{
	public static const CMD:int = 49014;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L49014_SC"; }


	/**
	 * 
	 */
	public function L49014_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 返回值
	 */
	public var ret:uint;

}
}