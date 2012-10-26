package Package
{
import com.google.protobuf.*;
public class DMemberLocation extends Message
{
	/**
	 * 
	 */
	public function DMemberLocation()
	{
		registerField("id", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("location", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
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
	 * 地图编号
	 */
	public var location:uint;

}
}
