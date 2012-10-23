package Package
{
import com.google.protobuf.*;
public class DFriends extends Message
{
	/**
	 * 
	 */
	public function DFriends()
	{
		registerField("id", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("uid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 2);
		registerField("friendUid", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 3);
		registerField("flag", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 4);
	}

	/**
	 * 编号
	 */
	public var id:uint;

	/**
	 * 用户编号
	 */
	public var uid:uint;

	/**
	 * 好友用户编号
	 */
	public var friendUid:uint;

	/**
	 * 标志位,0好友,1黑名单,2其他
	 */
	public var flag:uint;

}
}
