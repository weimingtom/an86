package module
{
	import flash.display.Sprite;
	
	import module.iface.IUiSystem;
	
	public class UiSystem extends Sprite implements IUiSystem
	{
		public var uid:String;
		
		public function UiSystem()
		{
			
		}
		
		public function startup():void{
			
		}
		
		public function remove():void{
			
		}
		
		public function update():void{
			trace("update()");
		}
		
		public function dispose():void{
			trace("dispose()");
		}
	}
}