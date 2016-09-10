package hz.company.testclient.bf.colliders;
import hz.company.testclient.geom.Geometry;
import hz.company.testclient.geom.Point2D;

/**
 * ...
 * @author 
 */
class CollisionDetection
{
	static public function pointToLine(point:ColliderPoint, line:ColliderLine, v:Point2D):Collision {		
		var a:Point2D = line.cachePoint0;
		var b:Point2D = line.cachePoint1;
		var c:Point2D = point.cachePoint;
		
		var ab:Float = a...b;
		if (ab == 0)
			return null;
		
		var i:Point2D = (b - a) / ab;
		var j:Point2D = new Point2D(-i.y, i.x);	// 90° по часовой стрелке
		
		// раскладываем вектор c-a по базису векторов (i, j)
		var ac_ij:Point2D = Geometry.convertToBasis(a - c, i, j);
		
		// ac_ij.y -= circle.radius; - единственное различие между точкой и окружностью
		// объект вообще не с той стороны прямой, поэтому его не обрабатываем
		if (ac_ij.y < 0)
			return null;
		
		// вектор скорости тоже раскладываем
		var v_ij:Point2D = Geometry.convertToBasis(v, i, j);
		
		// объект движется не в ту сторону или не долетает
		if (v_ij.y <= ac_ij.y)
			return null;
		
		var relativePath:Float = ac_ij.y / v_ij.y;
		
		var offsetI:Float = ac_ij.x + v_ij.x * relativePath;
		
		// столкнулись с прямой но не с отрезком
		if (offsetI < 0 || offsetI > ab)
			return null;		
		
		return new Collision(relativePath, point, line, -j);
	}
	
	static public function circleToLine(circle:ColliderCircle, line:ColliderLine, v:Point2D):Collision {
		
		var a:Point2D = line.cachePoint0;
		var b:Point2D = line.cachePoint1;
		var c:Point2D = circle.cachePoint;		// центр окружности
		
		var ab:Float = a...b;
		if (ab == 0)
			return null;
		
		var i:Point2D = (b - a) / ab;
		var j:Point2D = new Point2D(-i.y, i.x);	// 90° по часовой стрелке
		
		// раскладываем вектор c-a по базису векторов (i, j)
		var ac_ij:Point2D = Geometry.convertToBasis(a - c, i, j);
		
		ac_ij.y -= circle.radius;
		// объект вообще не с той стороны прямой, поэтому его не обрабатываем
		if (ac_ij.y < 0)
			return null;
		
		// вектор скорости тоже раскладываем
		var v_ij:Point2D = Geometry.convertToBasis(v, i, j);
		
		// объект движется не в ту сторону или не долетает
		if (v_ij.y <= ac_ij.y)
			return null;
		
		var relativePath:Float = ac_ij.y / v_ij.y;
		
		var offsetI:Float = ac_ij.x + v_ij.x * relativePath;
		
		// столкнулись с прямой но не с отрезком
		if (offsetI < 0 || offsetI > ab)
			return null;
		
		return new Collision(relativePath, circle, line, -j);
	}

	static public function pointToCircle(point:ColliderPoint, circle:ColliderCircle, v:Point2D):Collision {
		
		// Проверить, не нулевой ли радиус у окружности
		if (circle.radius == 0)
			return null;
		
		var a:Point2D = point.cachePoint;		// точка
		var b:Point2D = circle.cachePoint;		// центр объекта
		var c:Point2D = a + v;					// точка, в которую точечный объект движется без учета столкновений
		//	d - точка, в которой объект реально окажется при столкновении
		//	h - точка на прямой ac, ближайшая к b
		
		// скалярное произведение векторов меньше 0 -> точка движется не к объекту, а от него
		if ((b.x - a.x) * v.x + (b.y - a.y) * v.y < 0)
			return null;		
		
		// скорость объекта (пройденный путь на данном шаге симуляции)
		var ac:Float = a...c;
		if (ac == 0)
			return null;
		
		// расстояние между центрами объектов
		var ab:Float = a...b;
		
		// длина этого отрезка равна сумме радиусов объектов
		var bd:Float = circle.radius;
		
		// если они перекрываются
		if (ab < bd)
			return null;
		
		// расстояние между концом пути первого объекта и вторым
		var bc:Float = b...c;
		
		// по формуле Герона находим площадь, затем находим высоту
		// (расстояние от центра второго объекта до прямой)
		var p:Float = (ab + bc + ac) / 2;
		var S:Float = Math.sqrt(p * (p - ab) * (p - bc) * (p - ac));		
		var bh:Float = (2 * S) / ac;			// высота треугольника abc
		
		// если объекты никогда не столкнутся
		if (bh > bd)
			return null;
		
		var ah:Float = Geometry.cathetus(ab, bh);
		var dh:Float = Geometry.cathetus(bd, bh);
		var ad:Float = ah - dh;					// расстояние, которое пролетает объект
		
		// так не бывает
		if (Math.isNaN(ad)) {
			Main.I.log("Error: ColliderCircle.collideWithCircle: " + (Math.isNaN(ah) ? "ah == " : "") + (Math.isNaN(dh) ? "dh == " : "") + "NaN!");
			return null;
		}
		
		// объект либо слишком далеко, либо сзади
		if (ad < 0 || ad > ac)
			return null;
		
		// 1.0 - это длина ac, мы должны вычислить ad
		var relativePath:Float = ad / ac;
		var d:Point2D = a + v * relativePath;
		
		var normal:Point2D = d - b;				// вектор нормали (от поверхности к this)
		
		return new Collision(relativePath, point, circle, normal, d);		
	}

	static public function circleToCircle(circle0:ColliderCircle, circle1:ColliderCircle, v:Point2D):Collision {
		
		// Проверить, не нулевые ли у них радиусы (2 точки)
		if (circle0.radius == 0 && circle1.radius == 0)
			return null;
		
		var a:Point2D = circle0.cachePoint;		// центр первого объекта
		var b:Point2D = circle1.cachePoint;		// центр второго объекта
		var c:Point2D = a + v;					// точка, в которую первый объект движется без учета столкновений
		//	d - точка, в которой объект реально окажется при столкновении
		//	h - точка на прямой ac, ближайшая к b
		
		// скалярное произведение векторов меньше 0 -> объект движется не к другому объекту, а от него
		if ((b.x - a.x) * v.x + (b.y - a.y) * v.y < 0)
			return null;		
		
		// скорость объекта (пройденный путь на данном шаге симуляции)
		var ac:Float = a...c;
		if (ac == 0)
			return null;
		
		// расстояние между центрами объектов
		var ab:Float = a...b;
		
		// расстояние между концом пути первого объекта и вторым
		var bc:Float = b...c;
		
		// длина этого отрезка равна сумме радиусов объектов
		var bd:Float = circle0.radius + circle1.radius;
		
		// если они перекрываются
		if (ab < bd)
			return null;
		
		// по формуле Герона находим площадь, затем находим высоту
		// (расстояние от центра второго объекта до прямой)
		var p:Float = (ab + bc + ac) / 2;
		var S:Float = Math.sqrt(p * (p - ab) * (p - bc) * (p - ac));		
		var bh:Float = (2 * S) / ac;			// высота треугольника abc
		
		// если объекты никогда не столкнутся
		if (bh > bd)
			return null;
		
		var ah:Float = Geometry.cathetus(ab, bh);
		var dh:Float = Geometry.cathetus(bd, bh);
		var ad:Float = ah - dh;					// расстояние, которое пролетает объект
		
		// так не бывает
		if (Math.isNaN(ad)) {
			Main.I.log("Error: ColliderCircle.collideWithCircle : ad == NaN!");
			return null;
		}
		
		// объект либо слишком далеко, либо сзади
		if (ad < 0 || ad > ac)
			return null;
		
		// 1.0 - это длина ac, мы должны вычислить ad
		var relativePath:Float = ad / ac;
		var d:Point2D = a + v * relativePath;
		var collisionPoint = (b * circle0.radius + d * circle1.radius) / bd;
		
		var normal:Point2D = d - b;				// вектор нормали (от поверхности к this)
		
		return new Collision(relativePath, circle0, circle1, normal, collisionPoint);		
	}
	
}