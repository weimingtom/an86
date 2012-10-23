package Package
{
import com.google.protobuf.*;
public class L31052_SC extends Message
{
	public static const CMD:int = 31052;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31052_SC"; }


	/**
	 * 
	 */
	public function L31052_SC()
	{
		registerField("onlineUids", "", Descriptor.UINT32, Descriptor.LABEL_REPEATED, 1);
	}

	/**
	 * 是否在线
	 */
	public var onlineUids:Vector.<uint> = new Vector.<uint>();

}
}
