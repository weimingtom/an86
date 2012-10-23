package Package
{
import com.google.protobuf.*;
public class L31041_CC extends Message
{
	public static const CMD:int = 31041;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31041_CC"; }


	/**
	 * 
	 */
	public function L31041_CC()
	{
		registerField("targetUid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("data", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 2);
	}

	/**
	 * 目标用户编号
	 */
	public var targetUid:uint;

	/**
	 * 通讯数据
	 */
	public var data:String;

}
}
