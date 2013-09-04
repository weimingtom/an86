package anlei.structlist
{
	/**
	 * 链表结点
	 * @author Anlei
	 */
	public class AnleiNode 
	{
		public var OBJECT:Object;
		private var _next:AnleiNode;
		private var _prev:AnleiNode;
		private var _link:LinkList;
		public var ID:int = 0;
		
		public function AnleiNode($obj:Object) 
		{
			setObject($obj);
		}
		
		public function setObject($obj:Object):void {
			OBJECT = $obj;
		}
		
		public function setLink($link:LinkList):void{
			_link = $link;
		}
		
		public function get next():AnleiNode { return _next; }
		
		public function set next(value:AnleiNode):void 
		{
			_next = value;
			_link.currNode = value;
		}
		
		public function get prev():AnleiNode { return _prev; }
		
		public function set prev(value:AnleiNode):void 
		{
			_prev = value;
			_link.currNode = value;
		}
		
	}

}