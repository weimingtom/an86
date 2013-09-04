package ui.data
{
	public class DPModel
	{
		public var label:String;
		public var data:Object;
		
		public function DPModel($label:String, $data:Object)
		{
			label = $label;
			data = $data;
		}
		
		public function toString():String
		{
			return label;
		}
	}
}