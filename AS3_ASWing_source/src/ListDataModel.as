package 
{
	public class ListDataModel
	{
		public var label:String;
		public var data:Object;
		
		public function ListDataModel($label:String, $data:Object)
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