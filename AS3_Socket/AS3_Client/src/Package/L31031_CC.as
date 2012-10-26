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
		registerField("world", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("type", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("data", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 3);
	}

	/**
	 * 0频道,1世界
	 */
	public var world:uint;

	/**
	 * 前端自定义类型
	 */
	public var type:uint;

	/**
	 * 广播数据
	 */
	public var data:String;

}
}
