package Package
{
import com.google.protobuf.*;
public class L21004_SS extends Message
{
	public static const CMD:int = 21004;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L21004_SS"; }


	/**
	 * 
	 */
	public function L21004_SS()
	{
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 用户编号
	 */
	public var uid:Number;

}
}
