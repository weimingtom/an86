package Package
{
import com.google.protobuf.*;
public class L21002_SC extends Message
{
	public static const CMD:int = 21002;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L21002_SC"; }


	/**
	 * 
	 */
	public function L21002_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("install", "", Descriptor.BOOL, Descriptor.LABEL_REQUIRED, 3);
	}

	/**
	 * 返回值
	 */
	public var ret:uint;

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 是否安装
	 */
	public var install:Boolean;

}
}
