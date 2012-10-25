package Package
{
import com.google.protobuf.*;
public class DGoodsGemstone extends Message
{
	/**
	 * 
	 */
	public function DGoodsGemstone()
	{
		registerField("id", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("gemstoneId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("userEquipmentId", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 4);
		registerField("count", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
		registerField("expired", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 6);
	}

	/**
	 * 用户宝石编号
	 */
	public var id:Number;

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 宝石固有编号
	 */
	public var gemstoneId:uint;

	/**
	 * 用户装备编号
	 */
	public var userEquipmentId:Number;

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
