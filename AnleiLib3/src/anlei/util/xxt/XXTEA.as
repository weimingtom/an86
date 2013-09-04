package anlei.util.xxt
{  
	import com.hurlant.util.Hex;
	
	import flash.utils.ByteArray;
	
	public class XXTEA
	{
		/**
		 * 
		 * @param char
		 * @param key
		 * @return 
		 * 
		 */		
		public static function encrypt_hax(char:String,key:String):String
		{
			char = Base64.encode(char)
			key = Base64.encode(key)
			return Hex.fromString(XXTEA.encrypt(char,key));
		}
		
		/**
		 * 
		 * @param hax
		 * @param key
		 * @return 
		 * 
		 */		
		public static function decrypt_hax(hax:String,key:String):String
		{
			key = Base64.encode(key)
			return Base64.decode(XXTEA.decrypt(Hex.toString(hax),key));
		}
		/**
		 * 
		 * @param char
		 * @param key
		 * @return 
		 * 
		 */		
		public static function encrypt(str:String,key:String):String
		{  
			if (str == "") return "";
			
			var v:Array = str2long(str, true);  
			var k:Array = str2long(key, false);
			var n:int = v.length - 1;
			
			var z:uint = v[n];
			var y:uint = v[0];
			var delta:uint = 0x9E3779B9;
			var q:int = 6 + 52 / (n + 1);
			var sum:int = 0;
			
			var e:int=0;
			var p:int=0;
			var mx:int=0;
			while (0 < q--){
				sum = int32(sum + delta);
				e = sum >> 2 & 3; 
				for (p = 0; p < n; p++){  
					y = v[p + 1];  
					mx = int32(((z >> 5 & 0x07ffffff) ^ y << 2) + ((y >> 3 & 0x1fffffff) ^ z << 4)) ^ int32((sum ^ y) + (k[p & 3 ^ e] ^ z));
					z = v[p] = int32(v[p] + mx);
				}
				y = v[0];
				mx = int32(((z >> 5 & 0x07ffffff) ^ y << 2) + ((y >> 3 & 0x1fffffff) ^ z << 4)) ^ int32((sum ^ y) + (k[p & 3 ^ e] ^ z));
				z = v[n] = int32(v[n] + mx);
			}
			return long2str(v, false)
		}
		/**
		 * 
		 * @param v
		 * @param k
		 * @return 
		 * 
		 */		
		public static function decrypt(str:String, key:String):String
		{  
			if (str == "") return "";
			
			var v:Array = str2long(str, false);  
			var k:Array = str2long(key, false);
			var n:int = v.length - 1;
			
			var z:uint = v[n];
			var y:uint = v[0];
			var delta:uint = 0x9E3779B9;
			var q:int = 6 + 52 / (n + 1);
			var sum:int = int32(q * delta);
			
			var e:int=0;
			var p:int=0;
			var mx:int=0;
			while (sum != 0){
				e = sum >> 2 & 3;
				for (p = n; p > 0;p--) {
					z = v[p - 1];
					mx = int32(((z >> 5 & 0x07ffffff) ^ y << 2) + ((y >> 3 & 0x1fffffff) ^ z << 4)) ^ int32((sum ^ y) + (k[p & 3 ^ e] ^ z));
					y = v[p] = int32(v[p] - mx);
				}
				z = v[n];
				mx = int32(((z >> 5 & 0x07ffffff) ^ y << 2) + ((y >> 3 & 0x1fffffff) ^ z << 4)) ^ int32((sum ^ y) + (k[p & 3 ^ e] ^ z));
				y = v[0] = int32(v[0] - mx);
				sum = int32(sum - delta);
			}
			return long2str(v, true);
		}
		
		/**
		 * 
		 * @param v
		 * @param k
		 * @return 
		 * 
		 */		
		public static function _decrypt(v:Array, k:Array):Array
		{  
			var n:int = v.length - 1;  
			if (n < 1){  
				return v;  
			}  
			if (k.length < 4)  
			{  
				var key:Array = new Array();  
				key = k.slice();  
				k = key;  
			}  
			while(k.length<4){  
				k.push(0);  
			}  
			var z:uint = v[n], y:uint = v[0], delta:uint = 0x9E3779B9, sum:uint, e:uint;  
			var p:int, q:int = 6 + 52 / (n + 1);  
			sum = uint(uint(q) * delta);  
			while (sum != 0){  
				e = sum >>> 2 & 3;  
				for (p = n; p > 0; p--){  
					z = v[p - 1];  
					y = uint(v[p] -= (z >>> 5 ^ y << 2) + (y >>> 3 ^ z << 4) ^ (sum ^ y) + (k[p & 3 ^ e] ^ z));  
				}  
				z = v[n];  
				y = uint(v[0] -= (z >>> 5 ^ y << 2) + (y >>> 3 ^ z << 4) ^ (sum ^ y) + (k[p & 3 ^ e] ^ z));  
				sum = uint(sum - delta);  
			}  
			return v;  
		}  
		
		/**
		 * 
		 * @param v
		 * @param w
		 * @return 
		 * 
		 */		
		public static function long2str(v:Array,w:Boolean):String 
		{  
			var vl:uint = v.length;  
			var sl:* = v[vl - 1] & 0xffffffff;  
			for (var i:uint = 0; i < vl; i++)
			{  
				v[i] = String.fromCharCode(v[i] & 0xff,  
					v[i] >>> 8 & 0xff,  
					v[i] >>> 16 & 0xff,  
					v[i] >>> 24 & 0xff);  
			}
			if(w){  
				return v.join('').substring(0, sl);  
			}  
			else {  
				return v.join('');  
			}  
		}
		
		/**
		 * 
		 * @param s
		 * @param w
		 * @return 
		 * 
		 */		
		public static function str2long(s:String, w:Boolean):Array
		{
			var len:uint = s.length;
			var v:Array = new Array();  
			for (var i:uint = 0; i < len; i += 4)
			{  
				v[i >> 2] = s.charCodeAt(i) | s.charCodeAt(i + 1) << 8 | s.charCodeAt(i + 2) << 16 | s.charCodeAt(i + 3) << 24;  
			}  
			if (w) 
			{  
				v[v.length] = len;  
			}  
			return v;  
		}
		
		/**
		 * 
		 * @param $n
		 * @return 
		 * 
		 */		
		public static function int32(n:int):int
		{
			while (n >= 2147483648) n -= 4294967296;
			while (n <= -2147483649) n += 4294967296;
			return int(n);
		}
	}  
}  
