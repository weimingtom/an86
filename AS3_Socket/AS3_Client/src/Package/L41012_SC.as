package Package
{
import com.google.protobuf.*;
public class L41012_SC extends Message
{
	public static const CMD:int = 41012;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L41012_SC"; }


	/**
	 * 
	 */
	public function L41012_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 返回值
	 */
	public var ret:uint;

}
}
