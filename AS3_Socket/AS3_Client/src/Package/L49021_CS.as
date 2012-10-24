package Package
{
import com.google.protobuf.*;
public class L49021_CS extends Message
{
	public static const CMD:int = 49021;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L49021_CS"; }


	/**
	 * 
	 */
	public function L49021_CS()
	{
		registerField("targetUid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("targetName", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 2);
	}

	/**
	 * 目标用户编号
	 */
	public var targetUid:Number;

	/**
	 * 目标名字
	 */
	public var targetName:String;

}
}
