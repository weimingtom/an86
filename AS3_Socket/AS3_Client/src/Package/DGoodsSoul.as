package Package
{
import com.google.protobuf.*;
public class DGoodsSoul extends Message
{
	/**
	 * 
	 */
	public function DGoodsSoul()
	{
		registerField("id", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 2);
		registerField("soulId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("userHeroId", "", Descriptor.INT64, Descriptor.LABEL_REQUIRED, 4);
		registerField("experience", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
		registerField("expired", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 6);
	}

	/**
	 * 用户生魂编号
	 */
	public var id:Number;

	/**
	 * 用户编号
	 */
	public var uid:Number;

	/**
	 * 神魂固有编号
	 */
	public var soulId:uint;

	/**
	 * 用户英雄编号,穿在那个英雄上,没有为0
	 */
	public var userHeroId:Number;

	/**
	 * 神魂经验,前端根据等级表转化为等级
	 */
	public var experience:uint;

	/**
	 * 过期时间
	 */
	public var expired:uint;

}
}
