package Package
{
import com.google.protobuf.*;
public class L31023_SC extends Message
{
	public static const CMD:int = 31023;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31023_SC"; }


	/**
	 * 
	 */
	public function L31023_SC()
	{
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 用户编号
	 */
	public var uid:Number;

}
}
