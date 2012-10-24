package Package
{
import com.google.protobuf.*;
public class L31051_CS extends Message
{
	public static const CMD:int = 31051;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31051_CS"; }


	/**
	 * 
	 */
	public function L31051_CS()
	{
		registerField("targetUids", "", Descriptor.INT64, Descriptor.LABEL_REPEATED, 1);
	}

	/**
	 * 目标用户
	 */
	public var targetUids:Vector.<Number> = new Vector.<Number>();

}
}
