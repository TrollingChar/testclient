package hz.company.testclient.geom;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class Geometry
{	
	//static public function distance(x0:Float, y0:Float, x1:Float, y1:Float):Float {
		//return Math.sqrt((x0 - x1) * (x0 - x1) + (y0 - y1) * (y0 - y1));
	//}
	
	static public function hypothenuse(cat0:Float, cat1:Float) {
		return Math.sqrt(cat0 * cat0 + cat1 * cat1);
	}
	
	static public function cathetus(hyp:Float, cat:Float) {
		return Math.sqrt(hyp * hyp - cat * cat);
	}
	
	static public function intersection(a0:Point, a1:Point, b0:Point, b1:Point) {
		// коэффициенты системы уравнений
		var A0:Float = a1.y - a0.y;
		var B0:Float = a0.x - a1.x;
		var C0:Float = -a0.x * A0 - a0.y * B0;
		var A1:Float = b1.y - b0.y;
		var B1:Float = b0.x - b1.x;
		var C1:Float = -b0.x * A1 - b0.y * B1;
        // определитель матрицы при решении системы методом Крамера
		var d:Float = A0 * B1 - A1 * B0;
		// null - прямые параллельны или совпадают
		return d == 0 ? null : new Point((C1 * B0 - C0 * B1) / d, (A1 * C0 - A0 * C1) / d);
	}
}