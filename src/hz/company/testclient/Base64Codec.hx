package hz.company.testclient;
import haxe.ds.HashMap;

/**
 * ...
 * @author 
 */
class Base64Codec
{
	static var s:String;
	//static var map:Object;
	static var map:Map<String, Int>;

	static public function Init(str:String = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz./")
	{
		s = str;
		map = new Map<String, Int>();
		for (i in 0...str.length) {
			map[s.charAt(i)] = i;
		}
	}
	
	static public function EncodeToChar(n:Int):String
	{
		return (n & ~63) == 0 ? s.charAt(n) : '?';
	}
	
	static public function Encode(n:Int):String
	{
		var s:String;
		s = "=";
		while (n != 0)
		{
			s = EncodeToChar(n & 63) + s;
			n >>= 6;
		}
		return s;
	}
	
	static public function Decode(c:String):Int
	{
		return map[c];
	}
}