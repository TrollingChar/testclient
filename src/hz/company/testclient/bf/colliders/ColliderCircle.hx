package hz.company.testclient.bf.colliders;
import hz.company.testclient.bf.colliders.*;
import hz.company.testclient.geom.*;
import openfl.geom.*;

/**
 * ...
 * @author 
 */
class ColliderCircle extends Collider
{
	public var offset:Point2D;
	public var cachePoint:Point2D;
	public var radius:Float;
	
	public function new() 
	{
		super();		
	}
	
	override public function collideWithLine(collider:ColliderLine):Collision 
	{
		var a:Point2D = collider.cachePoint0;
		var b:Point2D = collider.cachePoint1;
		var c:Point2D = cachePoint;				// центр окружности
		var v:Point2D = object.velocity;
		
		// находим пересечение прямых
		var x:Point2D = Geometry.intersection(a, b, c, c + v);
		
		// если прямые параллельны
		if (x == null)
			return null;
		
		// нам надо найти расстояние от точки c до прямой ab
		var ab:Float = a ^ b;
		var ac:Float = a ^ c;
		var bc:Float = b ^ c;		
		// по формуле Герона находим площадь, затем находим высоту
		// (то самое расстояние)
		var p:Float = (ab + bc + ac) / 2;
		var S:Float = Math.sqrt(p * (p - ab) * (p - bc) * (p - ac));		
		var h:Float = (2 * S) / ac;
		
		return null;
	}
	
	override public function collideWithCircle(collider:ColliderCircle):Collision {
		
		// Проверить, не нулевые ли у них радиусы (2 точки)
		if (radius == 0 && collider.radius == 0)
			return null;
		
		var a:Point2D = cachePoint;				// центр первого объекта
		var b:Point2D = collider.cachePoint;	// центр второго объекта
		var v:Point2D = object.velocity;		// скорость
		var c:Point2D = a + v;					// точка, в которую первый объект движется без учета столкновений
		//	d - точка, в которой объект реально окажется при столкновении
		//	h - точка на прямой ac, ближайшая к b
		
		// скалярное произведение векторов меньше 0 -> объект движется не к другому объекту, а от него
		if ((b.x - a.x) * v.x + (b.y - a.y) * v.y < 0)
			return null;		
		
		// скорость объекта (пройденный путь на данном шаге симуляции)
		var ac:Float = a ^ c;
		if (ac == 0)
			return null;
		
		// расстояние между центрами объектов
		var ab:Float = a ^ b;
		
		// расстояние между концом пути первого объекта и вторым
		var bc:Float = b ^ c;
		
		// по формуле Герона находим площадь, затем находим высоту
		// (расстояние от центра второго объекта до прямой)
		var p:Float = (ab + bc + ac) / 2;
		var S:Float = Math.sqrt(p * (p - ab) * (p - bc) * (p - ac));		
		var bh:Float = (2 * S) / ac;			// высота треугольника abc
		
		// длина этого отрезка равна сумме радиусов объектов
		var bd:Float = radius + collider.radius;
		
		// если объекты никогда не столкнутся
		if (bd > bh)
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
		var collisionPoint = (d * radius + b * collider.radius) / bd;
		
		var normal:Point2D = d - b;			// вектор нормали
		
		return new Collision(relativePath, this, collider, collisionPoint, normal);
	}
	
}