package Package
{
import com.google.protobuf.*;
public class L42011_CS extends Message
{
	public static const CMD:int = 42011;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L42011_CS"; }


	/**
	 * 
	 */
	public function L42011_CS()
	{
		registerField("heroId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 英雄编号
	 */
	public var heroId:uint;

}
}
