package hz.company.testclient.bf.colliders;
import hz.company.testclient.bf.colliders.ColliderCircle;
import hz.company.testclient.bf.colliders.ColliderLine;
import hz.company.testclient.bf.colliders.Collision;
import hz.company.testclient.geom.Point2D;
import openfl.geom.Point;

/**
 * ...
 * @author 
 */
class ColliderPoint extends Collider
{
	public var offset:Point2D;
	public var cachePoint:Point2D;	

	public function new(point:Point2D) 
	{
		super();
		this.offset =
		this.cachePoint = point;
	}
	
	override public function update() 
	{
		cachePoint = object.position + offset;
	}
	
	override public function collideWithLine(collider:ColliderLine):Collision 
	{
		return CollisionDetection.pointToLine(this, collider, object.velocity);
	}
	
	override public function collideWithCircle(collider:ColliderCircle):Collision
	{
		return CollisionDetection.pointToCircle(this, collider, -object.velocity);
	}
	
	override public function getTop() : Float
	{
		return cachePoint.y;
	}
	
	override public function getLeft() : Float
	{
		return cachePoint.y;
	}
	
	override public function getBottom() : Float
	{
		return cachePoint.y;
	}
	
	override public function getRight() : Float
	{
		return cachePoint.x;
	}
}