package hz.company.testclient.geom;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
abstract Point2D(Point) from Point to Point
{	
	public var x(get, set):Float;
	public var y(get, set):Float;
	
	// length already has getter (~) & setter (%):
	public var angle(get, set):Float;
	
	public function new(x:Float, y:Float) {
		this = new Point(x, y);
	}
	
	@:op(A + B) static public function add(a:Point2D, b:Point2D):Point2D {
		return new Point2D(a.x+b.x, a.y+b.y);
	}
	
	@:op(A - B) static public function subtract(a:Point2D, b:Point2D):Point2D {
		return new Point2D(a.x-b.x, a.y-b.y);
	}
	
	@:op(-A) static public function revert(a:Point2D):Point2D {
		return new Point2D(-a.x, -a.y);
	}
	
	@:op(~A) static public function distance(a:Point2D):Float {
		return Math.sqrt(a.x * a.x + a.y * a.y);
	}
	
	@:op(A...B) static public function distance2(a:Point2D, b:Point2D):Float {
		return ~(a - b);
	}
	
	@:op(A * B) @:commutative static public function multiply(a:Point2D, b:Float):Point2D {
		return new Point2D(a.x * b, a.y * b);
	}
	
	@:op(A / B) static public function divide(a:Point2D, b:Float):Point2D {
		return new Point2D(a.x / b, a.y / b);
	}
	
	@:op(A % B) static public function normalize(a:Point2D, b:Float):Point2D {
		var dist:Float = ~a;
		return dist == 0 ? new Point2D(0, -b) : a * b / dist;
	}
	
	@:op(A >> B) static public function rightShift(a:Point2D, b:Float):Point2D {
		a.angle += b;
		return a;
	}
	
	@:op(A << B) static public function leftShift(a:Point2D, b:Float):Point2D {
		a.angle -= b;
		return a;
	}
	
	function get_x():Float { return this.x; }
	
	function set_x(value:Float):Float { return this.x = value; }
	
	function get_y():Float { return this.y; }
	
	function set_y(value:Float):Float { return this.y = value; }
	
	function get_angle():Float 
	{
		return Math.atan2(y, x);
	}
	
	function set_angle(value:Float):Float 
	{
		var dist:Float = Math.sqrt(x*x + y*y);
		x = dist*Math.cos(value);
		y = dist*Math.sin(value);
		return value;
	}
	
}