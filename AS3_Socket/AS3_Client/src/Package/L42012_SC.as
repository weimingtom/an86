package Package
{
import com.google.protobuf.*;
public class L42012_SC extends Message
{
	public static const CMD:int = 42012;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L42012_SC"; }


	/**
	 * 
	 */
	public function L42012_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 返回值
	 */
	public var ret:uint;

}
}
