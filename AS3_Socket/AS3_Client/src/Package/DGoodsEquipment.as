package Package
{
import com.google.protobuf.*;
public class DGoodsEquipment extends Message
{
	/**
	 * 
	 */
	public function DGoodsEquipment()
	{
		registerField("id", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("equipmentId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("userHeroId", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 4);
		registerField("strengthen", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
	}

	/**
	 * 用户装备编号
	 */
	public var id:Number;

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 装备固有编号
	 */
	public var equipmentId:uint;

	/**
	 * 穿在英雄Id身上,没穿为0
	 */
	public var userHeroId:Number;

	/**
	 * 强化等级
	 */
	public var strengthen:uint;

}
}
