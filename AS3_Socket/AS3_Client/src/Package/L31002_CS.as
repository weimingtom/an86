package Package
{
import com.google.protobuf.*;
public class L31002_CS extends Message
{
	public static const CMD:int = 31002;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31002_CS"; }


	/**
	 * 
	 */
	public function L31002_CS()
	{
		registerField("coordinate", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 坐标
	 */
	public var coordinate:String;

}
}
