package Package
{
import com.google.protobuf.*;
public class DHeroies extends Message
{
	/**
	 * 
	 */
	public function DHeroies()
	{
		registerField("id", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("heroId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("addition", "", Descriptor.FLOAT, Descriptor.LABEL_REQUIRED, 4);
		registerField("flag", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
	}

	/**
	 * 用户英雄编号
	 */
	public var id:uint;

	/**
	 * 用户编号
	 */
	public var uid:uint;

	/**
	 * 英雄编号
	 */
	public var heroId:uint;

	/**
	 * 成长值加成
	 */
	public var addition:Number;

	/**
	 * 标志,1主英雄,2副英雄,3其他
	 */
	public var flag:uint;

}
}
