package hz.company.testclient.bf.colliders;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class Collision
{
	// shoild be null if no collision detected
	public var path:Float;			// how much time passed before objects collide
	public var collider:Collider;	// collider that was moved
	public var collided:Collider;	// collider that caused collision (null if it's immobile land)
	public var normal:Point;
	
	public function new() 
	{
		
	}
	
}