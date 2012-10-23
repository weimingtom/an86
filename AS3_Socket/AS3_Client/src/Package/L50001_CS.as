package Package
{
import com.google.protobuf.*;
public class L50001_CS extends Message
{
	public static const CMD:int = 50001;

	override public function toCmd():int{ return CMD; }

	override public function toString():String { return "L50001_CS"; }


	/**
	 * 
	 */
	public function L50001_CS()
	{
		registerField("model", "", Descriptor.MESSAGE, Descriptor.LABEL_REQUIRED, 1);
		registerField("models", "", Descriptor.MESSAGE, Descriptor.LABEL_REPEATED, 2);
	}

	public var model:Package.DMember = new Package.DMember();

	public var models:Vector.<Package.DMember> = new Vector.<Package.DMember>();

}
}
