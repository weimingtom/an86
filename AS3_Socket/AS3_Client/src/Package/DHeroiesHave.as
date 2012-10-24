package Package
{
import com.google.protobuf.*;
public class DHeroiesHave extends Message
{
	/**
	 * 
	 */
	public function DHeroiesHave()
	{
		registerField("id", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("heroId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
	}

	/**
	 * 编号
	 */
	public var id:Number;

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 英雄编号
	 */
	public var heroId:uint;

}
}
