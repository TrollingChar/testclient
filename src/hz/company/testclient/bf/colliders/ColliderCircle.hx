package hz.company.testclient.bf.colliders;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class ColliderCircle extends Collider
{
	public var offset:Point;
	public var cachePoint:Point;
	public var radius:Float;
	
	public function new() 
	{
		super();		
	}
	
	override public function collideWithCircle(collider:ColliderCircle):Collision {
		
		// Проверить, не нулевые ли у них радиусы (2 точки)
		if (radius == 0 && collider.radius == 0)
			return null;
		
		var a:Point = cachePoint;			// центр первого объекта
		var b:Point = collider.cachePoint;	// центр второго объекта
		//	с - точка, в которую первый объект движется без учета столкновений
		//	d - точка, в которой объект реально окажется при столкновении
		//	h - точка на прямой ac, ближайшая к b
		
		// скалярное произведение векторов меньше 0 -> объект движется не к другому объекту, а от него
		if ((b.x - a.x) * object.vx + (b.y - a.y) * object.vy < 0)
			return null;		
		
		// скорость объекта (пройденный путь на данном шаге симуляции)
		var ac:Float = Math.sqrt(object.vx * object.vx + object.vy * object.vy);
		if (ac == 0) return null;
		
		// расстояние между центрами объектов
		var ab:Float = Math.sqrt((a.x - b.x)*(a.x - b.x) + (a.y - b.y)*(a.y - b.y));
		
		// расстояние между концом пути первого объекта и вторым
		var bc:Float = Math.sqrt(
			Math.pow((a.x + object.vx - b.x), 2) +
		    Math.pow((a.y + object.vy - b.y), 2));
		
		// по формуле Герона находим площадь, затем находим высоту (расстояние
		// от центра второго объекта до прямой
		var p:Float = (ab + bc + ac) / 2;
		var S:Float = Math.sqrt(p * (p - ab) * (p - bc) * (p - ac));		
		var bh:Float = (2 * S) / ac;		// высота треугольника abc
		
		// длина этого отрезка равна сумме радиусов объектов
		var bd:Float = radius + collider.radius;
		
		// если объекты никогда не столкнутся
		if (bd > bh)
			return null;
		
		var ah:Float = Math.sqrt(ab * ab - bh * bh);
		var dh:Float = Math.sqrt(bd * bd - bh * bh);
		var ad:Float = ah - dh;				// расстояние, которое пролетает объект
		
		// объект либо слишком далеко, либо сзади
		if (ad < 0 || ad > ac)
			return null;
		
		// так не бывает
		if (Math.isNaN(ad)) {
			Main.I.log("Error: ColliderCircle.collideWithCircle : ad == NaN!");
			return null;
		}
		
		// 1.0 - это длина ac, мы должны вычислить ad
		var relativePath:Float = ad / ac;
		var d:Point = new Point(a.x + relativePath * object.vx, a.y + relativePath * object.vy);
		var collisionPoint:Point = new Point(
			(d.x * radius + b.x * collider.radius) / bd,
			(d.y * radius + b.y * collider.radius) / bd);
		var normal:Point = new Point(d.x - b.x, d.y - b.y);		// вектор нормали
		
		return new Collision(relativePath, this, collider, collisionPoint, normal);
	}
	
}