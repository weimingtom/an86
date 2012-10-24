package Package
{
import com.google.protobuf.*;
public class DGoodsConsum extends Message
{
	/**
	 * 
	 */
	public function DGoodsConsum()
	{
		registerField("id", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("consumId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("count", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 4);
	}

	/**
	 * 用户消耗品编号
	 */
	public var id:Number;

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 消耗品固有编号
	 */
	public var consumId:uint;

	/**
	 * 数量
	 */
	public var count:uint;

}
}
