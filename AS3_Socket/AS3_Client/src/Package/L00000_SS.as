package Package
{
import com.google.protobuf.*;
public class L00000_SS extends Message
{
	public static const CMD:int = 00000;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L00000_SS"; }


	/**
	 * 
	 */
	public function L00000_SS()
	{
		registerField("ts", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 时间戳
	 */
	public var ts:uint;

}
}
