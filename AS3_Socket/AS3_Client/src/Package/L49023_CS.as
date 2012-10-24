package Package
{
import com.google.protobuf.*;
public class L49023_CS extends Message
{
	public static const CMD:int = 49023;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L49023_CS"; }


	/**
	 * 
	 */
	public function L49023_CS()
	{
		registerField("targetUid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 目标用户
	 */
	public var targetUid:Number;

}
}
