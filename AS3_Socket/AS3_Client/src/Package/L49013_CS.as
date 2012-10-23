package Package
{
import com.google.protobuf.*;
public class L49013_CS extends Message
{
	public static const CMD:int = 49013;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L49013_CS"; }


	/**
	 * 
	 */
	public function L49013_CS()
	{
		registerField("targetUid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 目标用户
	 */
	public var targetUid:uint;

}
}
