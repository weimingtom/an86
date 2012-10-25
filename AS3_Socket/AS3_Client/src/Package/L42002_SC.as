package Package
{
import com.google.protobuf.*;
public class L42002_SC extends Message
{
	public static const CMD:int = 42002;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L42002_SC"; }


	/**
	 * 
	 */
	public function L42002_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("heroHaveIds", "", Descriptor.UINT32, Descriptor.LABEL_REPEATED, 2);
	}

	/**
	 * 返回值
	 */
	public var ret:uint;

	/**
	 * 已经拥有过的英雄的id列表
	 */
	public var heroHaveIds:Vector.<uint> = new Vector.<uint>();

}
}
