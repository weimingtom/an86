package module.config
{
	/** 如:swfUrl 	 = module/UiSystem.swf
		如:moduleUrl = module.UiSystem */
	public class ModuleConfigVO
	{
		/** 如:module/UiSystem.swf */
		public var swfUrl:String;
		/** 如:module.UiSystem */
		public var moduleUrl:String;
		
		public function ModuleConfigVO($swfUrl:String, $moduleUrl:String){
			swfUrl = $swfUrl;
			moduleUrl = $moduleUrl;
		}
		
	}
}