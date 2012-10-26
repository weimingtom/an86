package Package
{
import com.google.protobuf.*;
public class DGoodsFragment extends Message
{
	/**
	 * 
	 */
	public function DGoodsFragment()
	{
		registerField("id", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("fragmentId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("count", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 4);
		registerField("expired", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
	}

	/**
	 * 用户碎片编号
	 */
	public var id:Number;

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 碎片固有编号
	 */
	public var fragmentId:uint;

	/**
	 * 数量
	 */
	public var count:uint;

	/**
	 * 过期
	 */
	public var expired:uint;

}
}
