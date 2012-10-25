package Package
{
import com.google.protobuf.*;
public class CMemo extends Message
{
	/**
	 * 
	 */
	public function CMemo()
	{
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("coordinate", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 2);
		registerField("information", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 3);
	}

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 坐标记录
	 */
	public var coordinate:String;

	/**
	 * 更多信息
	 */
	public var information:String;

}
}
