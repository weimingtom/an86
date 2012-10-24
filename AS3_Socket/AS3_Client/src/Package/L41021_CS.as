package Package
{
import com.google.protobuf.*;
public class L41021_CS extends Message
{
	public static const CMD:int = 41021;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L41021_CS"; }


	/**
	 * 
	 */
	public function L41021_CS()
	{
		registerField("targetUid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 要读取的目标用户编号
	 */
	public var targetUid:Number;

}
}
