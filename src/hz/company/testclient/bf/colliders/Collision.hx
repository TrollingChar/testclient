package hz.company.testclient.bf.colliders;
import hz.company.testclient.geom.Point2D;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class Collision
{
	// shoild be null if no collision detected
	public var relativePath:Float;	// относительный путь объекта
	public var collider:Collider;	// двигавшийся объект
	public var collided:Collider;	// объект, в который он врезался (null если это земля)
	public var point:Point2D;			// точка столкновения
	public var normal:Point2D;		// вектор нормали от поверхности второго объекта
	
	public function new(relativePath:Float,
						collider:Collider,
						collided:Collider,
						normal:Point2D,
						point:Point2D = null) 
	{
		this.relativePath = relativePath;
		this.collider = collider;
		this.collided = collided;
		this.point = point;
		this.normal = normal;
	}
	
	public function reverse():Collision {
		return new Collision(relativePath, collided, collider, -normal);
	}
}