package Package
{
import com.google.protobuf.*;
public class L49002_SC extends Message
{
	public static const CMD:int = 49002;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L49002_SC"; }


	/**
	 * 
	 */
	public function L49002_SC()
	{
		registerField("ret", "", Descriptor.UINT32, Descriptor.LABEL_REQUIRED, 1);
		registerField("friendList", "Package.DFriends", Descriptor.MESSAGE, Descriptor.LABEL_REPEATED, 2);
		registerField("enemyList", "Package.DFriends", Descriptor.MESSAGE, Descriptor.LABEL_REPEATED, 3);
	}

	/**
	 * 返回码
	 */
	public var ret:uint;

	/**
	 * 好友
	 */
	public var friendList:Vector.<Package.DFriends> = new Vector.<Package.DFriends>();

	/**
	 * 仇人
	 */
	public var enemyList:Vector.<Package.DFriends> = new Vector.<Package.DFriends>();

}
}