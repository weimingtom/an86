package Package
{
import com.google.protobuf.*;
public class DHeroies extends Message
{
	/**
	 * 
	 */
	public function DHeroies()
	{
		registerField("id", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("heroId", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("addition", "", Descriptor.DOUBLE, Descriptor.LABEL_REQUIRED, 4);
		registerField("artifact", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 5);
		registerField("site", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 6);
		registerField("flag", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 7);
	}

	/**
	 * 用户英雄编号
	 */
	public var id:uint;

	/**
	 * 用户编号
	 */
	public var uid:uint;

	/**
	 * 英雄编号
	 */
	public var heroId:uint;

	/**
	 * 成长值加成
	 */
	public var addition:Number;

	/**
	 * 神器总经验,可提取,前端对表转换等级
	 */
	public var artifact:uint;

	/**
	 * 在阵法的位置
	 */
	public var site:uint;

	/**
	 * 标志,1主英雄,2副英雄,3其他
	 */
	public var flag:uint;

}
}
