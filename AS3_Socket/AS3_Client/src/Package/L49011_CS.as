package Package
{
import com.google.protobuf.*;
public class L49011_CS extends Message
{
	public static const CMD:int = 49011;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L49011_CS"; }


	/**
	 * 
	 */
	public function L49011_CS()
	{
		registerField("targetName", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 1);
		registerField("targetUid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
	}

	/**
	 * 目标用户名
	 */
	public var targetName:String;

	/**
	 * 目标用户ID
	 */
	public var targetUid:uint;

}
}
