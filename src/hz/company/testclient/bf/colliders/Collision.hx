package hz.company.testclient.bf.colliders;
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
	public var point:Point;			// точка столкновения
	public var normal:Point;		// вектор нормали от поверхности второго объекта
	
	public function new(relativePath:Float,
						collider:Collider,
						collided:Collider,
						point:Point,
						normal:Point) 
	{
		this.relativePath = relativePath;
		this.collider = collider;
		this.collided = collided;
		this.point = point;
		this.normal = normal;
	}
	
}