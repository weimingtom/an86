package Package
{
import com.google.protobuf.*;
public class DMember extends Message
{
	/**
	 * 
	 */
	public function DMember()
	{
		registerField("uid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("sex", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("name", "", Descriptor.STRING, Descriptor.LABEL_REQUIRED, 3);
		registerField("title", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 4);
		registerField("titleExp", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
		registerField("vip", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 6);
		registerField("vipExp", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 7);
		registerField("vipInte", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 8);
		registerField("level", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 9);
		registerField("levelExp", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 10);
		registerField("ingot", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 11);
		registerField("ingotFree", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 12);
		registerField("power", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 13);
		registerField("coin", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 14);
	}

	/**
	 * 用户编号
	 */
	public var uid:uint;

	/**
	 * 性别
	 */
	public var sex:uint;

	/**
	 * 昵称
	 */
	public var name:String;

	/**
	 * 官爵
	 */
	public var title:uint;

	/**
	 * 官爵声望
	 */
	public var titleExp:uint;

	/**
	 * vip等级
	 */
	public var vip:uint;

	/**
	 * vip经验
	 */
	public var vipExp:uint;

	/**
	 * vip积分
	 */
	public var vipInte:uint;

	/**
	 * 等级
	 */
	public var level:uint;

	/**
	 * 等级经验
	 */
	public var levelExp:uint;

	/**
	 * 元宝
	 */
	public var ingot:uint;

	/**
	 * 元宝-免费送的
	 */
	public var ingotFree:uint;

	/**
	 * 体力
	 */
	public var power:uint;

	/**
	 * 铜币
	 */
	public var coin:uint;

}
}
