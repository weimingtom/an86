package Package
{
import com.google.protobuf.*;
public class DGoodsMaterial extends Message
{
	/**
	 * 
	 */
	public function DGoodsMaterial()
	{
		registerField("id", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("materialId", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 3);
		registerField("count", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 4);
		registerField("expired", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
	}

	/**
	 * 用户材料编号
	 */
	public var id:Number;

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 材料固有编号
	 */
	public var materialId:Number;

	/**
	 * 数量
	 */
	public var count:uint;

	/**
	 * 过期时间
	 */
	public var expired:uint;

}
}
