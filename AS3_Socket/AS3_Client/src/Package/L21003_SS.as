package Package
{
import com.google.protobuf.*;
public class L21003_SS extends Message
{
	public static const CMD:int = 21003;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L21003_SS"; }


	/**
	 * 
	 */
	public function L21003_SS()
	{
		registerField("uid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 用户编号
	 */
	public var uid:uint;

}
}
