package hz.company.testclient.bf;
import haxe.crypto.Base64;
import haxe.io.Bytes;

/**
 * ...
 * @author 
 */
class InputState
{
	public static var inline w:Int = 0x1;
	public static var inline a:Int = 0x2;
	public static var inline s:Int = 0x4;
	public static var inline d:Int = 0x8;
	public static var inline sp:Int = 0x10;		// spacebar
	public static var inline mb:Int = 0x20;		// mouse button

	
	public var flags : Int;
	
	public var x:Float;
	public var y:Float;

	public function new(x:Float, y:Float, flags = 0) 
	{
		this.x = x;
		this.y = y;
		this.flags = flags;
	}
	
	public function toString() : String
	{
		var b:Bytes = Bytes.alloc(16);
		b.setDouble(0, x);
		b.setDouble(8, y);
		return Base64Codec.Encode(flags) + Base64.encode(b);
	}
	
	public static function parse(str : String) : InputState
	{
		Base64Codec.s = str;
		flags = Base64Codec.DecodeFromString();
		var b:Bytes = Base64.decode(Base64Codec.s);
		var x : Float = b.getDouble(0);
		var y : Float = b.getDouble(8);
		return new InputState(x, y, flags);
	}
	
}