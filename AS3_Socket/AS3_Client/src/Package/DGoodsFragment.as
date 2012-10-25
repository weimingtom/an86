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
		registerField("fragmentId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("count", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("expired", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 4);
	}

	/**
	 * 用户碎片编号
	 */
	public var id:Number;

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
