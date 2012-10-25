package Package
{
import com.google.protobuf.*;
public class L31001_CS extends Message
{
	public static const CMD:int = 31001;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31001_CS"; }


	/**
	 * 
	 */
	public function L31001_CS()
	{
		registerField("information", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 需要存储广播的数据
	 */
	public var information:String;

}
}
