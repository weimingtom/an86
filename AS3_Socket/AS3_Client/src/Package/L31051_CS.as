package Package
{
import com.google.protobuf.*;
public class L31051_CS extends Message
{
	public function L31051_CS()
	{
		registerField("targetUids", "", Descriptor.UINT32, Descriptor.LABEL_REPEATED, 1);
	}

	/**
	 * 目标用户
	 */
	public var targetUids:Vector.<uint>;


	public static const CMD:int = 31051;

	override public function toCmd():int
	{
		return CMD;
	}

}
}
