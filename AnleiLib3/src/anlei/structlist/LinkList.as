package anlei.structlist
{
	/**
	 * 循环列表
	 * 用法：
	 * 		var size:int = 3;
	    	var _list:LinkList = new LinkList();
			for (var i:int = 0 ; i < size; i++) {
				var _node:AnleiNode = new AnleiNode("Anlei" + i);
				_list.insert(_node);
			}
	 * @author Anlei
	 */
	public class LinkList 
	{
		private var _size:int;
		private var _data:Vector.<AnleiNode>;
		private var _currNode:AnleiNode;
		
		public function LinkList() 
		{
		}
		public function insert($node:AnleiNode):AnleiNode {
			if (_data == null) _data = new Vector.<AnleiNode>();
			
			$node.setLink(this);
			
			//当_data没有内容时，把第一个$node设成表头
			if (_data.length == 0) {
				_data.push($node);
				$node.prev = $node;
				$node.next = $node;
			}//否则的话则是表尾
			else {
				$node.prev = end;
				end.next = $node;
				$node.next = head;
				_data.push($node);
			}
			$node.ID = Data.length - 1;
			this.currNode = $node;
			return $node;
		}
		public function dele($node:AnleiNode):AnleiNode {
			var _did:int = _data.indexOf($node);
			//当没有找到可删除的对象时
			if (_did == -1) return null;
			
			this.currNode = $node.next;
			
			//当只有一个长度时
			if (_did == 0 && _data.length == 1) {
				head.next = null;
				head.prev = null;
				head.OBJECT = null;
				
				end.next = null;
				end.prev = null;
				end.OBJECT = null;
				
				_data = RemoveArrayNode(_data, _did);
				return null;
			}
			//当删除的是最后一个时
			if (_did == _data.length-1) {
				_data[_did - 1].next = head;
				head.prev = _data[_did - 1];
			}
			//当删除的不是最后一个时
			else {
				//当删除的是第一个
				if(_did == 0){
					end.next = _data[_did + 1];
				}
				//删除不是第一个也不是最后一个
				else {
					_data[_did - 1].next = _data[_did + 1];
					_data[_did + 1].prev = _data[_did - 1];
				}
			}
			_data = RemoveArrayNode(_data, _did);
			return $node;
		}
		
		public function get size():int { return _data.length; }
		
		public function get head():AnleiNode {
			if(_data.length <= 0) return null;
			return _data[0];
		}
		
		public function get end():AnleiNode {
			return _data[size - 1];
		}
		public function get Data():Vector.<AnleiNode>{
			return _data;
		}
		
		/**
		 * 当前指针
		 */
		public function get currNode():AnleiNode{
			return _currNode;
		}
		
		public function set currNode($node:AnleiNode):void{
			_currNode = $node;
		}
		
		private function RemoveArrayNode(inputArray:Vector.<AnleiNode>, removeIndex:uint):Vector.<AnleiNode> {
			var tem:Vector.<AnleiNode> = new Vector.<AnleiNode>();
			var len:int = inputArray.length;
			for(var i:int = 0 ; i < len; i++){
				if(i == removeIndex){
					continue;
				}
				tem.push(inputArray[i]);
			}
			inputArray=null;
			return tem;
		}
	}

}