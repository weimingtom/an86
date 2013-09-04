package anlei.util
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class CustomerByteArray extends ByteArray
	{
		public function CustomerByteArray()
		{
			super();
			this.endian = Endian.LITTLE_ENDIAN;
		}
		
	}
}