package {
	public class p {
		/**获得不重复的随机数*/
		public static function RandomArray(n1:int, n2:int, count:int = 1, cont:Array = null):Array {
			var my_array:Array = [];
			var i:int;
			for (i=n1; i<=n2; i++) {
				my_array.push(i);
			}
			var i_arr:Array = [];
			var new_arr:Array = [];
			for (i=0; i<count; i++) {
				var tmp1:int = di();
				i_arr.push(tmp1);
				new_arr.push(my_array[tmp1]);
			}
			function di():int {
				var tmp:int = Math.random() * my_array.length;
					for(var c:int =0 ; c < cont.length; c++){
						if(cont[c] == my_array[tmp]){
							tmp = Math.random() * my_array.length;
							tmp = di();
							break;
						}
					}
				for (var j:int = 0; j < i_arr.length; j++) {
					if (i_arr[j] == tmp) {
						tmp = Math.random() * my_array.length;
						tmp = di();
						break;
					}
				}
				return tmp;
			}
			return new_arr;
		}
		
		public static function ArrayJoin($source:Array, arr:Array):void{
			for(var i:int = 0 ; i < arr.length; i++){
				$source.push(arr[i]);
			}
		}
			
	}
}