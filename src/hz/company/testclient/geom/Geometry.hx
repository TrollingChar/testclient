package hz.company.testclient.geom;
//import openfl.geom.Point;

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
	
	static public function intersection(a0:Point2D, a1:Point2D, b0:Point2D, b1:Point2D) {
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
		return d == 0 ? null : new Point2D(C1 * B0 - C0 * B1, A1 * C0 - A0 * C1) / d;
	}
	
	static public function convertToBasis(v:Point2D, x:Point2D, y:Point2D):Point2D {		
		// коэффициенты системы уравнений
		var A0:Float = x.x;
		var B0:Float = y.x;
		var C0:Float = v.x;
		var A1:Float = x.y;
		var B1:Float = y.y;
		var C1:Float = v.y;
        // определитель матрицы при решении системы методом Крамера
		var d:Float = A0 * B1 - A1 * B0;
		// null - прямые параллельны или совпадают
		return d == 0 ? null : new Point2D(C0 * B1 - C1 * B0, A0 * C1 - A1 * C0) / d;
	}

	// разложение вектора по базису
	//public static PointF ConvertVectorToBasis (PointF v, PointF OX, PointF OY) {
		//float
			//a0 = OX.X,
			//b0 = OY.X,
			//c0 = v.X,
			//
			//a1 = OX.Y,
			//b1 = OY.Y,
			//c1 = v.Y,
			//
			//d = a0 * b1 - a1 * b0;
			//
		//return d == 0 ? new PointF(float.NaN, float.NaN) : new PointF((c0 * b1 - c1 * b0) / d, (a0 * c1 - a1 * c0) / d);
	//}
}