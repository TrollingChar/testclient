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
	
	@:op(A ^ B) static public function distance(a:Point2D, b:Point2D):Float {
		var p:Point2D = a - b;
		return Math.sqrt(p.x * p.x + p.y * p.y);
	}
	
	@:op(A * B) @:commutative static public function multiply(a:Point2D, b:Float):Point2D {
		return new Point2D(a.x * b, a.y * b);
	}
	
	@:op(A / B) static public function divide(a:Point2D, b:Float):Point2D {
		return new Point2D(a.x / b, a.y / b);
	}
	
	function get_x():Float { return this.x; }
	
	function set_x(value:Float):Float { return this.x = value; }
	
	function get_y():Float { return this.y; }
	
	function set_y(value:Float):Float { return this.y = value; }
	
}