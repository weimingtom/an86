package Package
{
import com.google.protobuf.*;
public class L31031_CC extends Message
{
	public static const CMD:int = 31031;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31031_CC"; }


	/**
	 * 
	 */
	public function L31031_CC()
	{
		registerField("channelId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("data", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 2);
	}

	/**
	 * 频道编号,0为世界频道
	 */
	public var channelId:uint;

	/**
	 * 广播数据
	 */
	public var data:String;

}
}
