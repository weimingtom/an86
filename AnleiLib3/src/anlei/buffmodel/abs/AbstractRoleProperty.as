package anlei.buffmodel.abs
{
	import flash.display.Sprite;
	
	import anlei.buffmodel.BuffModel;
	import anlei.buffmodel.utils.RoleProperty;

	public class AbstractRoleProperty extends Sprite
	{
		protected var skin:Sprite;
		protected var _property:RoleProperty;
		public var buff:BuffModel;
		
		public function AbstractRoleProperty($skin:Sprite)
		{
			skin = $skin;
			skin && addChild(skin);
			inits();
		}
		
		private function inits():void
		{
			_property = new RoleProperty(skin);
			buff = new BuffModel(property);
			property.buff = buff;
			
		}
		
		public function get property():RoleProperty{ return _property;}
		
	}
}