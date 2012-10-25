package Package
{
import com.google.protobuf.*;
public class L42013_CS extends Message
{
	public static const CMD:int = 42013;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L42013_CS"; }


	/**
	 * 
	 */
	public function L42013_CS()
	{
		registerField("userHeroId", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 解雇的用户英雄编号
	 */
	public var userHeroId:Number;

}
}
