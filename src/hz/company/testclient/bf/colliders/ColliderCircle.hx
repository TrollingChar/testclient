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
	
	public function new(point:Point2D, radius:Float) 
	{
		super();
		this.offset =
		this.cachePoint = point;
		this.radius = radius;
	}
	
	override public function update() 
	{
		cachePoint = object.position + offset;
	}
	
	override public function collideWithPoint(collider:ColliderPoint):Collision 
	{
		return Collision.reverse(CollisionDetection.pointToCircle(collider, this, -object.velocity));
	}
	
	override public function collideWithLine(collider:ColliderLine):Collision 
	{
		return CollisionDetection.circleToLine(this, collider, object.velocity);
	}
	
	override public function collideWithCircle(collider:ColliderCircle):Collision
	{
		return CollisionDetection.circleToCircle(this, collider, object.velocity);
	}
	
	override public function relationToPoint(collider:ColliderPoint):Float 
	{
		return RelationDetection.pointToCircle(collider, this);
	}
	
	override public function relationToLine(collider:ColliderLine):Float 
	{
		return RelationDetection.circleToLine(this, collider);
	}
	
	override public function relationToCircle(collider:ColliderCircle):Float 
	{
		return RelationDetection.circleToCircle(this, collider);
	}
	
	override public function test(objectPosition:Point2D)
	{
		cachePoint = objectPosition + offset;
	}
	
    override public function getTop() : Float
	{
		return cachePoint.y - radius;
	}
	
	override public function getLeft() : Float
	{
		return cachePoint.x - radius;
	}
	
	override public function getBottom() : Float
	{
		return cachePoint.y + radius;
	}
	
	override public function getRight() : Float
	{
		return cachePoint.x + radius;
	}
	
}