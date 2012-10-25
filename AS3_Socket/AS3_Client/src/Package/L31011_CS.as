package Package
{
import com.google.protobuf.*;
public class L31011_CS extends Message
{
	public static const CMD:int = 31011;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31011_CS"; }


	/**
	 * 
	 */
	public function L31011_CS()
	{
		registerField("channelId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 频道编号
	 */
	public var channelId:uint;

}
}
