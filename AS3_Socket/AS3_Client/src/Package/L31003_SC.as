package Package
{
import com.google.protobuf.*;
public class L31003_SC extends Message
{
	public static const CMD:int = 31003;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L31003_SC"; }


	/**
	 * 
	 */
	public function L31003_SC()
	{
		registerField("cmemo", "Package.CMemo", Descriptor.MESSAGE, Descriptor.LABEL_REQUIRED, 1);
	}

	/**
	 * 用户记录信息
	 */
	public var cmemo:Package.CMemo = new Package.CMemo();

}
}
