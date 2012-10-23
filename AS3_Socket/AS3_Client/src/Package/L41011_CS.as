package Package
{
import com.google.protobuf.*;
public class L41011_CS extends Message
{
	public static const CMD:int = 41011;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L41011_CS"; }


	/**
	 * 
	 */
	public function L41011_CS()
	{
		registerField("sex", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("heroId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("nickname", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 3);
	}

	/**
	 * 性别
	 */
	public var sex:uint;

	/**
	 * 主英雄编号
	 */
	public var heroId:uint;

	/**
	 * 昵称
	 */
	public var nickname:String;

}
}
